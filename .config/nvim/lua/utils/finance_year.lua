local p = require("utils/print")

---@class FederalBracket
---@field from integer
---@field to integer
---@field rate number

---@class FederalRate
---@field [1] FederalBracket[]
---@field federal_standard_deduction integer

---@class MedicareRate
---@field [1] number
---@field high_income number

---@class SocialSecurityRate
---@field [1] number
---@field max integer

---@class IraRate
---@field max integer

---@class Rates
---@field federal FederalRate
---@field medicare MedicareRate
---@field social_security SocialSecurityRate
---@field ira IraRate

local RATES_BY_YEAR = {
  [2026] = {
    federal = {
      {
        { from = 0, to = 17700, rate = 0.0 },
        { from = 17701, to = 67450, rate = 0.12 },
        { from = 67451, to = 105700, rate = 0.22 },
        { from = 105701, to = 201775, rate = 0.24 },
        { from = 201775, to = 256200, rate = 0.32 },
        { from = 256201, to = 640600, rate = 0.35 },
        { from = 640601, to = 999999999, rate = 37.0 },
      },
      federal_standard_deduction = 24150,
    },
    medicare = {
      0.0145,
      high_income = 0.009,
    },
    social_security = {
      0.062,
      max = 11439,
    },
    ira = {
      max = 24500,
    },
  },
}

local SECONDS_IN_DAY = 60 * 60 * 24

---@param year integer
---@param as_of integer
---@return integer
local getPaychecksRemaining = function(year, as_of)
  local days_left = os.difftime(
    os.time({ year = year + 1, month = 1, day = 1 }),
    as_of
  ) / SECONDS_IN_DAY

  return math.floor(days_left / 14) + 1
end

---@param vest StockVest
---@param rates Rates
---@return number
local getSockVestTotalTaxRate = function(vest, rates)
  local other_rates = {
    medicare = rates.medicare[1],
    high_income_medicare = rates.medicare.high_income,
    ssn = rates.social_security[1],
  }

  local total_tax_rate = vest.tax_rate
  for _, applied_tax in ipairs(vest.other_taxes) do
    total_tax_rate = total_tax_rate + other_rates[applied_tax]
  end
  return total_tax_rate
end

---@param federal_taxible_income number
---@param rates Rates
local getFederalTaxEstimate = function(federal_taxible_income, rates)
  local taxes = 0
  local running_income = federal_taxible_income
  for _, bracket in ipairs(rates.federal[1]) do
    local taxable = math.min(running_income, bracket.to)
    taxes = taxes + (taxable * bracket.rate)
    running_income = running_income - taxable
  end

  return taxes - rates.federal.federal_standard_deduction
end

---@alias AppliedTaxes '"medicare"' | '"high_income_medicare"' | '"ssn"'
---@alias Features '"ssn"' | '"401k"' | '"stock"' | '"comp"'

---@class StockVest
---@field [1] string
---@field shares integer
---@field tax_rate number
---@field other_taxes AppliedTaxes[]

---@class Input
---@field year integer
---@field as_of integer
---@field stock_price number
---@field first_paycheck integer
---@field total_income number
---@field federal_taxible_income number
---@field federal_withholdings number
---@field social_security_withholdings number
---@field ira_contribution number
---@field salary number
---@field bonus number
---@field ira_contribution_rate number
---@field features Features[]
---@field stock_vests StockVest[]

---@class FinanceYear
---@field rates Rates
---@field input Input
---@field paychecks_in_year integer
---@field paychecks_remaining integer
---@field paycheck number
local FinanceYear = {}
FinanceYear.__index = FinanceYear

---@param input Input
function FinanceYear:new(input)
  local new_finance_year = {}
  setmetatable(new_finance_year, FinanceYear)

  new_finance_year.input = input
  new_finance_year.paychecks_in_year =
    getPaychecksRemaining(input.year, input.first_paycheck)
  new_finance_year.paychecks_remaining =
    getPaychecksRemaining(input.year, input.as_of)
  new_finance_year.rates = RATES_BY_YEAR[input.year]
  new_finance_year.paycheck = input.salary / new_finance_year.paychecks_in_year

  return new_finance_year
end

function FinanceYear:print()
  -- SSN
  p.printHeader("SSN")
  p.printf(
    "- SSN Withheld: %s",
    p.formatCurrInt(self.input.social_security_withholdings)
  )
  local remaining_ssn = self.rates.social_security.max
    - self.input.social_security_withholdings
  p.printf("- SSN Remaining: %s", p.formatCurrInt(remaining_ssn))
  p.printf(
    "- SSN Paychecks Remaining: %.1f",
    remaining_ssn / (self.paycheck * self.rates.social_security[1])
  )
  print()
  local feb_stock_ssn = self.input.stock_vests[1].shares
    * self.input.stock_price
    * self.rates.social_security[1]
  p.printf("- SSN From Feb Stock: %s", p.formatCurrInt(feb_stock_ssn))
  local remaining_ssn_after_vest = remaining_ssn - feb_stock_ssn
  p.printf(
    "- SSN Remaining After Vest: %s",
    p.formatCurrInt(remaining_ssn_after_vest)
  )
  p.printf(
    "- SSN Paychecks Remaining After Vest: %.1f",
    remaining_ssn_after_vest / (self.paycheck * self.rates.social_security[1])
  )
  print()
  local ssn_from_bonus = self.input.bonus * self.rates.social_security[1]
  p.printf("- SSN From Bonus: %s", p.formatCurrInt(ssn_from_bonus))
  local remaining_ssn_after_bonus = remaining_ssn_after_vest - ssn_from_bonus
  p.printf(
    "- SSN Remaining After Bonus: %s",
    p.formatCurrInt(remaining_ssn_after_bonus)
  )
  p.printf(
    "- SSN Paychecks Remaining After Bonus: %.1f",
    remaining_ssn_after_bonus / (self.paycheck * self.rates.social_security[1])
  )
  p.printSep()

  -- 401k
  p.printHeader("401k")
  p.printf(
    "- 401k Contribution: %s",
    p.formatCurrInt(self.input.ira_contribution)
  )
  p.printf(
    "- 401k Remaining: %s",
    p.formatCurrInt(self.rates.ira.max - self.input.ira_contribution)
  )
  p.printf(
    "- 401k Paychecks Remaining: %.1f",
    (self.rates.ira.max - self.input.ira_contribution)
      / (self.paycheck * self.input.ira_contribution_rate)
  )
  p.printSep()

  -- Stock Vests
  p.printHeader("Remaining Stock Vests")
  local total_stock = 0
  local total_stock_take_home = 0
  local stock_table = p.createTable({
    "Date",
    { "Value", justify = "right" },
    { "Take Home", justify = "right" },
  })
  for _, stock_vest in ipairs(self.input.stock_vests) do
    local value = self.input.stock_price * stock_vest.shares
    local take_home = value
      - (value * getSockVestTotalTaxRate(stock_vest, self.rates))
    total_stock = total_stock + value
    total_stock_take_home = total_stock_take_home + take_home
    stock_table:row({
      stock_vest[1],
      p.formatCurrInt(value),
      p.formatCurrInt(take_home),
    })
  end
  stock_table:print()
  print()
  p.printf("Total:           %s", p.formatCurrInt(total_stock))
  p.printf("Total Take Home: %s", p.formatCurrInt(total_stock_take_home))
  p.printSep()

  -- Comp
  p.printHeader("Estimated Comp")
  p.printf("- YTD: %s", p.formatCurrInt(self.input.total_income))
  local remaining_income = (self.paycheck * self.paychecks_remaining)
    + total_stock
    + self.input.bonus
  p.printf("- Estimated Remaining: %s", p.formatCurrInt(remaining_income))
  p.printf(
    "- Estimated Total: %s",
    p.formatCurrInt(self.input.total_income + remaining_income)
  )
  p.printSep()

  -- Taxes
  p.printHeader("Taxes")
  p.printf(
    "- Federal Taxes Withheld: %s",
    p.formatCurrInt(self.input.federal_withholdings)
  )
  local federal_tax_estimate =
    getFederalTaxEstimate(self.input.federal_taxible_income, self.rates)
  p.printf(
    "- Estimated Federal Taxes: %s",
    p.formatCurrInt(federal_tax_estimate)
  )
  p.printf(
    "- Estimated amount owed: %s",
    p.formatCurrInt(federal_tax_estimate - self.input.federal_withholdings)
  )
end

return FinanceYear

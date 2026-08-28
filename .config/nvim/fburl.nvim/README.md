# fburl.nvim

Replace a link's URL with an [fburl.com](https://fburl.com) short link, in place.

```markdown
[FBUrl docs](https://www.internalfb.com/intern/wiki/EP_Doc_Center/Foundations/Content_Products/FBUrl/)
```

`:FburlLink` with the cursor on that line turns it into:

```markdown
[FBUrl docs](https://fburl.com/wiki/p8lq1zgg)
```

## Usage

| Command             | Effect                                                     |
| ------------------- | ---------------------------------------------------------- |
| `:FburlLink`        | Shortens the link under the cursor (or the first on the line) |
| `:'<,'>FburlLink`   | Shortens every link in the range, after confirming          |
| `:%FburlLink`       | Shortens every link in the buffer, after confirming         |

Both inline markdown links (`[text](url)`, including `[text](<url> "title")`)
and bare `http(s)://` URLs are recognised. URLs that are already `fburl.com` or
`fb.me` are left alone.

Shortening runs asynchronously; the buffer is edited when the CLI returns, and
each edit is skipped if the line changed in the meantime.

## Requirements

The `meta` CLI, which ships on every Meta dev environment:

```
meta fburl.link create --url=<url> --output=json
```

## Configuration

`setup()` is optional. Defaults:

```lua
require("fburl").setup({
  cmd = { "meta", "fburl.link", "create", "--output=json" },
  timeout = 30000,
  short_hosts = { "fburl%.com", "fb%.me" }, -- lua patterns
  confirm_multiple = true,
})
```

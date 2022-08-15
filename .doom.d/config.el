;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq user-full-name "Chris Jones"
      user-mail-address "chris@yo3.io")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-unicode-font' -- for unicode glyphs
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
(setq doom-font (font-spec :family "JetBrainsMono Nerd Font Mono" :size 12)
      doom-variable-pitch-font (font-spec :family "JetBrainsMono Nerd Font Mono" :size 12)
      doom-big-font (font-spec :family "JetBrainsMono Nerd Font Mono" :size 12)
      doom-unicode-font (font-spec :family "JetBrainsMono Nerd Font Mono" :size 12)
      doom-serif-font (font-spec :family "JetBrainsMono Nerd Font Mono" :size 12))

;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-gruvbox)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")
(setq org-agenda-files '(
                         "~/org/"
                         "~/org/projects/"
                         "~/org/people/"
                         "~/org/journal/"))
(setq org-todo-keywords
      '((sequence "NEXT" "IN_PROGRESS" "WAITING_ON" "|" "DONE")))

(require 'key-chord)
(key-chord-mode t)
;; (key-chord-define-global "fd" 'evil-normal-state)
(key-chord-define evil-insert-state-map "jj" 'evil-normal-state)

  (use-package org-bullets
    :config
    (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1))))

(defun yo3/on-go-mode-load ()
  (setq flycheck-checker 'golangci-lint)
  (display-fill-column-indicator-mode))

(after! go-mode
  (setq +format-with-lsp nil)

  ;; this sets golines as the formatter, but it doesn't run when the
  ;; file is saved. To format with golines use M-x gofmt
  (setq gofmt-command "golines")
  (setq gofmt-args '("--max-len=80"))

  ;; The default is to use the lsp for checking, this sets golanci-lint as
  ;; the default.
  (add-hook 'go-mode-hook 'yo3/on-go-mode-load))

;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type `relative)

;; Map ctrl h/j/k/l for window navigation

(evil-global-set-key 'normal (kbd "C-h") 'evil-window-left)
(evil-global-set-key 'normal (kbd "C-j") 'evil-window-down)
(evil-global-set-key 'normal (kbd "C-k") 'evil-window-up)
(evil-global-set-key 'normal (kbd "C-l") 'evil-window-right)

(evil-global-set-key 'insert (kbd "C-h") 'evil-window-left)
(evil-global-set-key 'insert (kbd "C-j") 'evil-window-down)
(evil-global-set-key 'insert (kbd "C-k") 'evil-window-up)
(evil-global-set-key 'insert (kbd "C-l") 'evil-window-right)

;; Automatically tangle our Emacs.org config file when we save it
(defun yo3/org-babel-tangle-config ()
  (when (string-equal (buffer-file-name)
                      (expand-file-name "~/dotfiles/.doom.d/config.org"))
    ;; Dynamic scoping to the rescue
    (let ((org-confirm-babel-evaluate nil))
      (org-babel-tangle))))

(add-hook 'org-mode-hook (lambda () (add-hook 'after-save-hook #'yo3/org-babel-tangle-config)))

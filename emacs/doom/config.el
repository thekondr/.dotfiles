;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; refresh' after modifying this file!


;; These are used for a number of things, particularly for GPG configuration,
;; some email clients, file templates and snippets.
(setq user-full-name ""
      user-mail-address "")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
(setq doom-font "Source Code Pro Medium-14")

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. These are the defaults.
(setq doom-theme 'doom-one)

;; If you intend to use org, it is recommended you change this!
(setq org-directory "~/org/")

;; If you want to change the style of line numbers, change this to `relative' or
;; `nil' to disable it:
(setq display-line-numbers-type 'relative)


;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', where Emacs
;;   looks when you load packages with `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c g k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c g d') to jump to their definition and see how
;; they are implemented.

(after! popup
  (defun popup-vertical-motion (column direction)
    "A portable version of `vertical-motion'."
    (if (functionp 'line-number-display-width)
        (setq column (- column (line-number-display-width 'columns))))
    (vertical-motion (cons column direction))))

(defun tk-counsel-projectile-vc ()
  (interactive)
  (require 'counsel-projectile)
  (counsel-projectile-switch-project #'counsel-projectile-switch-project-action-vc))

(setq base16-theme-256-color-source "base16-shell")
(setq custom-theme-directory (expand-file-name "~/.dotfiles/emacs/theme"))
(add-to-list 'load-path "~/.dotfiles/emacs/theme")
(load-theme 'tk-base16)

(setq ivy-extra-directories nil)

(setq magit-refs-pad-commit-counts t)
(setq magit-revision-show-gravatars nil)
(setq magit-section-visibility-indicator nil)

(set-popup-rules! '(("*" :side right :size 0.5 :select t)))

(map! (:leader
       :n "1" #'winum-select-window-1
       :n "2" #'winum-select-window-2
       :n "3" #'winum-select-window-3
       :n "4" #'winum-select-window-4
       :n "5" #'winum-select-window-5
       :n "6" #'winum-select-window-6
       :n "7" #'winum-select-window-7
       :n "8" #'winum-select-window-8
       :n "9" #'winum-select-window-9
       :n "0" #'winum-select-window-0
       :n "/" #'+default/search-project
       :n "j" #'evil-avy-goto-word-or-subword-1
       :n "TAB" #'evil-switch-to-windows-last-buffer
       :n ";" #'evilnc-comment-operator
       :n "en" #'flycheck-next-error
       :n "ep" #'flycheck-previous-error)

      (:map doom-leader-project-map
       "p" #'tk-counsel-projectile-vc
       "v" #'projectile-vc)

      (:map counsel-find-file-map
       "C-h" #'counsel-up-directory)

      (:map ivy-minibuffer-map
       "M-J" #'ivy-yank-word
       "M-K" #'kill-sentence
       "M-j" #'ivy-next-line-and-call
       "M-k" #'ivy-previous-line-and-call
       "M-l" #'ivy-call
       "C-h" #'doom/delete-backward-word
       "C-S-h" help-map))
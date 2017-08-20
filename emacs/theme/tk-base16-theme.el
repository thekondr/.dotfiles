;; tk-base16-theme.el -- A base16 colorscheme

;;; Commentary:
;; Base16: (https://github.com/chriskempson/base16)

;;; Authors:
;; Scheme: Chris Kempson (http://chriskempson.com)
;; Template: Kaleb Elwert <belak@coded.io>

;;; Code:

(require 'base16-theme)

(defvar tk-base16-colors
  '(:base00 "#2b303b"
    :base01 "#343d46"
    :base02 "#3f4b56"
    :base03 "#65737e"
    :base04 "#a7adba"
    :base05 "#c0c5ce"
    :base06 "#dfe1e8"
    :base07 "#eff1f5"
    :base08 "#bf616a"
    :base09 "#d08770"
    :base0A "#ebcb8b"
    :base0B "#a3be8c"
    :base0C "#96b5b4"
    :base0D "#8fa1b3"
    :base0E "#b48ead"
    :base0F "#ab7967")
  "All colors for Base16 Ocean are defined here.")

;; Define the theme
(deftheme tk-base16)

;; Add all the faces to the theme
(base16-theme-define 'tk-base16 tk-base16-colors)

;; Mark the theme as provided
(provide-theme 'tk-base16)

(provide 'tk-base16-theme)

;;; tk-base16-theme.el ends here

(require 'evil)

(evil-define-text-object evil-a-defun (count &optional beg end type)
  "Select a defun."
  (evil-select-an-object 'evil-defun beg end type count t))

(evil-define-text-object evil-inner-defun (count &optional beg end type)
  "Select inner defun."
  (evil-select-inner-object 'evil-defun beg end type count t))

(provide 'evil-defun)

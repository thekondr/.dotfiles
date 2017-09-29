(setq evil-defun-packages '((evil-defun :location local)))

(defun evil-defun/init-evil-defun ()
  (use-package evil-defun
    :commands (evil-inner-defun
               evil-a-defun)
    :init
    (progn
      (define-key evil-outer-text-objects-map (kbd "d") 'evil-a-defun)
      (define-key evil-inner-text-objects-map (kbd "d") 'evil-inner-defun))))

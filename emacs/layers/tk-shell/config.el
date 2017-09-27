(unless (spacemacs/system-is-mswindows)
  (setq shell-command-switch "-ic"))

(with-eval-after-load 'eshell
  (evil-set-initial-state 'eshell-mode 'emacs)
  (add-hook 'eshell-mode-hook 'spacemacs//unset-scroll-margin))

(with-eval-after-load 'term
  (defun tk//setup-term-map ()
    (define-key term-raw-map (kbd "C-r") 'term-send-raw)
    (define-key term-raw-map (kbd "C-s") 'term-send-raw)
    (define-key term-raw-map (kbd "C-p") 'term-send-raw)
    (define-key term-raw-map (kbd "C-n") 'term-send-raw)
    (define-key term-raw-map (kbd "C-_") 'term-send-raw)
    (define-key term-raw-map (kbd "M-f") 'term-send-raw-meta)
    (define-key term-raw-map (kbd "M-b") 'term-send-raw-meta)
    (define-key term-raw-map (kbd "M-d") 'term-send-raw-meta)
    (define-key term-raw-map (kbd "M-p") 'term-send-raw-meta)
    (define-key term-raw-map (kbd "M-n") 'term-send-raw-meta)
    (define-key term-raw-map (kbd "M-j") 'term-send-raw-meta)
    (define-key term-raw-map (kbd "M-k") 'term-send-raw-meta)
    (define-key term-raw-map (kbd "M-l") 'term-send-raw-meta)
    (define-key term-raw-map (kbd (if (spacemacs/system-is-mac)
                                      "s-v" "C-V")) 'term-paste))

  (evil-set-initial-state 'term-mode 'emacs)
  (add-hook 'term-mode-hook 'tk//setup-term-map t))

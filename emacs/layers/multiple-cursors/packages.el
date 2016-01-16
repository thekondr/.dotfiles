(setq multiple-cursors-packages
      '(
        multiple-cursors
        phi-search
        expand-region
        ))

(defun multiple-cursors/init-multiple-cursors ()
  (use-package multiple-cursors
    :defer t
    :init
    (spacemacs|define-micro-state tk/multiple-cursors
      :doc ""
      :on-enter (evil-emacs-state)
      :bindings
      ("v" er/expand-region)
      ("n" mc/mark-next-like-this)
      ("p" mc/mark-previous-like-this)
      ("a" mc/mark-all-like-this)
      ("d" mc/mark-all-like-this-in-defun)
      ("r" mc/mark-all-in-region)
      ("q" nil :exit t))
    (spacemacs/set-leader-keys
      "xm" 'spacemacs/tk/multiple-cursors-micro-state)

    (setq mc/unsupported-minor-modes '(company-mode auto-complete-mode flyspell-mode jedi-mode))

    (add-hook 'multiple-cursors-mode-enabled-hook 'spacemacs/toggle-mode-line-minor-modes-on)
    (add-hook 'multiple-cursors-mode-disabled-hook 'spacemacs/toggle-mode-line-minor-modes-off)

    (add-hook 'multiple-cursors-mode-enabled-hook (defun tk/pending-delete-mode-turn-on ()
                                                    (pending-delete-mode 1)))
    (add-hook 'multiple-cursors-mode-disabled-hook (defun tk/pending-delete-mode-turn-off ()
                                                     (pending-delete-mode -1)))

    (add-hook 'multiple-cursors-mode-enabled-hook 'evil-emacs-state)
    (add-hook 'multiple-cursors-mode-disabled-hook 'evil-normal-state)
    ;; (add-hook 'multiple-cursors-mode-disabled-hook 'evil-change-to-previous-state)

    ;; (defadvice mc/maybe-multiple-cursors-mode (around tk/maybe-multiple-cursors-mode activate)
    ;;   (if (> (mc/num-cursors) 1)
    ;;       (unless multiple-cursors-mode (multiple-cursors-mode 1))
    ;;     (when multiple-cursors-mode (multiple-cursors-mode 0))))
    ))

(defun multiple-cursors/init-phi-search ()
  (use-package phi-search
    :defer t))

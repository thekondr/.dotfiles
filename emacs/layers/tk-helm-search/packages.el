(defconst tk-helm-search-packages
  '(
    helm-ag
    helm-swoop
    ))

(defun tk-helm-search/post-init-helm-ag ()
  ;; Override some spacemacs functions
  ;; to allow optional `dir` argument.

  (defun spacemacs/helm-files-do-ag-region-or-symbol (&optional dir)
    "Search in files with `ag' using a default input."
    (interactive)
    (spacemacs//helm-do-ag-region-or-symbol 'spacemacs/helm-files-do-ag dir))

  (defun spacemacs/helm-files-do-ack-region-or-symbol (&optional dir)
    "Search in files with `ack' using a default input."
    (interactive)
    (spacemacs//helm-do-ag-region-or-symbol 'spacemacs/helm-files-do-ack dir))

  (defun spacemacs/helm-files-do-pt-region-or-symbol (&optional dir)
    "Search in files with `pt' using a default input."
    (interactive)
    (spacemacs//helm-do-ag-region-or-symbol 'spacemacs/helm-files-do-pt dir))

  (defun tk/helm-smart-do-search-with-dir (dir &optional default-inputp)
    (interactive)
    (funcall
     (spacemacs//helm-do-search-find-tool "helm-files-do"
                                          dotspacemacs-search-tools
                                          default-inputp) dir))

  (defun tk/helm-smart-do-search-default-dir (&optional default-inputp)
    (interactive)
    (tk/helm-smart-do-search-with-dir default-directory default-inputp))

  (defun tk/helm-smart-do-search-default-dir-region-or-symbol ()
    (interactive)
    (tk/helm-smart-do-search-default-dir t))

  (spacemacs/set-leader-keys
    "sd" 'tk/helm-smart-do-search-default-dir
    "sD" 'tk/helm-smart-do-search-default-dir-region-or-symbol)

  ;; Original `spacemacs/helm-project-smart-do-search-in-dir` got broken.
  (with-eval-after-load 'helm-projectile
    (defalias 'spacemacs/helm-project-smart-do-search-in-dir
      'tk/helm-smart-do-search-with-dir)))

(defun tk-helm-search/post-init-helm-swoop ()
  (defmacro tk//customize-helm-swoop (swoop-func)
    (let ((func-name (intern (format "spacemacs/%s-region-or-symbol" (symbol-name swoop-func))))
          (advice-name (intern (format "add-evil-jump-to-%s" (symbol-name swoop-func)))))
      `(progn
         (defun ,func-name ()
           ,(format "Call `%s' with default input."
                    (symbol-name swoop-func))
           (interactive)
           (let ((helm-swoop-pre-input-function
                  (lambda ()
                    (if (region-active-p)
                        (buffer-substring-no-properties (region-beginning)
                                                        (region-end))
                      (let ((thing (thing-at-point 'symbol t)))
                        (if thing thing ""))))))
             (call-interactively ',swoop-func)))
         (defadvice ,swoop-func (before ,advice-name activate)
           (when (configuration-layer/package-usedp 'evil-jumper)
             (evil-set-jump))))))

  (tk//customize-helm-swoop helm-multi-swoop-all)
  (tk//customize-helm-swoop helm-multi-swoop-current-mode)

  (spacemacs/set-leader-keys
    "sm" 'helm-multi-swoop-current-mode
    "sM" 'spacemacs/helm-multi-swoop-current-mode-region-or-symbol))

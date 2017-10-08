(defconst code-format-packages '(clang-format whitespace))

(defun code-format/post-init-clang-format ()
  (use-package clang-format
    :commands (clang-format-region)
    :init
    (progn
      (evil-define-operator code-format/clang-format-operator (beg end)
        "Formats code with clang-format"
        (interactive "<r>")
        (clang-format-region beg end))

      (spacemacs/set-leader-keys "=" 'code-format/clang-format-operator))))

(defun code-format/post-init-whitespace ()
  (evil-define-operator code-format/whitespace-operator (beg end)
    "Cleans whitespaces"
    (interactive "<r>")
    (whitespace-cleanup-region beg end))

  (spacemacs/set-leader-keys "oc" 'code-format/whitespace-operator))

(defconst clang-format-packages '(clang-format))

(defun clang-format/post-init-clang-format ()
  (use-package clang-format
    :commands (clang-format-region)
    :init
    (progn
      (evil-define-operator tk/clang-format-operator (beg end)
        "Formats code with clang-format"
        (interactive "<r>")
        (clang-format-region beg end))

      (spacemacs/set-leader-keys "=" 'tk/clang-format-operator))))

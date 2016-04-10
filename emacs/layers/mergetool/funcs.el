(defun tk/mergetool (file-a file-b file-ancestor file-merge)
  "For use with git mergetool, add these lines to .gitconfig:

[merge]
	tool = ediff
[mergetool.ediff]
	cmd = emacs --eval \"(tk/mergetool \\\"$LOCAL\\\" \\\"$REMOTE\\\" \\\"$BASE\\\" \\\"$MERGED\\\")\"
or
	cmd = emacsclient -t --eval \"(tk/mergetool \\\"$LOCAL\\\" \\\"$REMOTE\\\" \\\"$BASE\\\" \\\"$MERGED\\\")\"
or
	cmd = emacsclient -c --frame-parameters=\"((fullscreen . maximized))\" --eval \"(tk/mergetool \\\"$LOCAL\\\" \\\"$REMOTE\\\" \\\"$BASE\\\" \\\"$MERGED\\\")\"
"
  (add-hook 'ediff-startup-hook (defun mergetool/ediff-startup-hook ()
    (remove-hook 'ediff-startup-hook 'mergetool/ediff-startup-hook)
    (ediff-toggle-show-clashes-only)
    (ediff-next-difference)))

  (add-hook 'ediff-quit-merge-hook (defun mergetool/ediff-quit-merge-hook ()
    (remove-hook 'ediff-quit-merge-hook 'mergetool/ediff-quit-merge-hook)
    (let ((file ediff-merge-store-file))
      (with-current-buffer ediff-buffer-C
        (write-region (point-min) (point-max) file)
        (set-buffer-modified-p nil)))
    (when ediff-buffer-A (kill-buffer ediff-buffer-A))
    (when ediff-buffer-B (kill-buffer ediff-buffer-B))
    (when ediff-buffer-C (kill-buffer ediff-buffer-C))
    (when ediff-ancestor-buffer (kill-buffer ediff-ancestor-buffer))
    (when ediff-diff-buffer (kill-buffer ediff-diff-buffer))
    (when ediff-fine-diff-buffer (kill-buffer ediff-fine-diff-buffer))
    (when ediff-error-buffer (kill-buffer ediff-error-buffer))
    (when ediff-control-buffer (kill-buffer ediff-control-buffer))
    (delete-frame)))

  (with-demoted-errors
      (ediff-merge-files-with-ancestor file-a file-b file-ancestor nil file-merge)))

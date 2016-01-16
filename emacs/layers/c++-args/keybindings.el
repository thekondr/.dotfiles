(spacemacs|define-micro-state tk/args
  :doc (concat "")
  :bindings
  ("b" tk/backward-arg)
  ("e" tk/forward-arg)
  ("x" tk/kill-arg)
  ("t" tk/transpose-arg)
  ("s" tk/line-wf-args-switch)
  (";" tk/comment-dwim-arg)
  ("u" undo-tree-undo)
  ("C-r" undo-tree-redo)
  ("q" nil :exit t)
  )

(spacemacs/set-leader-keys-for-major-mode 'c++-mode
  "a" 'spacemacs/tk/args-micro-state)

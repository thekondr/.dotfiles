(spacemacs|define-transient-state tk/args
  :title "C++ args transient state"
  :bindings
  ("b" tk/backward-arg "back")
  ("e" tk/forward-arg "forward")
  ("x" tk/kill-arg "kill")
  ("t" tk/transpose-arg "transpose")
  ("s" tk/line-wf-args-switch "switch")
  (";" tk/comment-dwim-arg "comment")
  ("u" undo-tree-undo "undo")
  ("C-r" undo-tree-redo "redo")
  ("q" nil "quit" :exit t)
  )

(spacemacs/set-leader-keys-for-major-mode 'c++-mode
  "a" 'spacemacs/tk/args-transient-state/body)

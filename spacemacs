;; -*- mode: emacs-lisp -*-
;; This file is loaded by Spacemacs at startup.
;; It must be stored in your home directory.

(defun dotspacemacs/layers ()
  "Configuration Layers declaration.
You should not put any user code in this function besides modifying the variable
values."
  (setq-default
   ;; Base distribution to use. This is a layer contained in the directory
   ;; `+distribution'. For now available distributions are `spacemacs-base'
   ;; or `spacemacs'. (default 'spacemacs)
   dotspacemacs-distribution 'spacemacs
   ;; List of additional paths where to look for configuration layers.
   ;; Paths must have a trailing slash (i.e. `~/.mycontribs/')
   dotspacemacs-configuration-layer-path '("~/.dotfiles/emacs/layers/")
   ;; List of configuration layers to load. If it is the symbol `all' instead
   ;; of a list then all discovered layers will be installed.
   dotspacemacs-configuration-layers
   '(
     (auto-completion :variables
                      auto-completion-tab-key-behavior 'complete
                      auto-completion-enable-snippets-in-popup t
                      auto-completion-enable-sort-by-usage t)
     emacs-lisp
     (git :variables
          git-magit-status-fullscreen t)
     (c-c++ :variables
            c-c++-default-mode-for-headers 'c++-mode)
     html
     java
     javascript
     python
     ruby
     gtags
     ranger
     shell
     shell-scripts
     (version-control :variables
                      version-control-diff-tool 'diff-hl)
     ibuffer
     vim-empty-lines
     (evil-snipe :variables
                 evil-snipe-enable-alternate-f-and-t-behaviors t)
     unimpaired

     ;; tk
     c++-args
     multiple-cursors

     ;; magnars
     hippie-closest-first

     ;; bb
     encoding
     evil-little-word
     no-dots
     )
   ;; List of additional packages that will be installed without being
   ;; wrapped in a layer. If you need some configuration for these
   ;; packages, then consider creating a layer. You can also put the
   ;; configuration in `dotspacemacs/user-config'.
   dotspacemacs-additional-packages '(google-c-style flymake-cursor)
   ;; A list of packages and/or extensions that will not be install and loaded.
   dotspacemacs-excluded-packages '(evil-escape evil-search-highlight-persist vi-tilde-fringe)
   ;; If non-nil spacemacs will delete any orphan packages, i.e. packages that
   ;; are declared in a layer which is not a member of
   ;; the list `dotspacemacs-configuration-layers'. (default t)
   dotspacemacs-delete-orphan-packages t))

(defun dotspacemacs/init ()
  "Initialization function.
This function is called at the very startup of Spacemacs initialization
before layers configuration.
You should not put any user code in there besides modifying the variable
values."
  ;; This setq-default sexp is an exhaustive list of all the supported
  ;; spacemacs settings.
  (setq-default
   ;; If non nil ELPA repositories are contacted via HTTPS whenever it's
   ;; possible. Set it to nil if you have no way to use HTTPS in your
   ;; environment, otherwise it is strongly recommended to let it set to t.
   ;; This variable has no effect if Emacs is launched with the parameter
   ;; `--insecure' which forces the value of this variable to nil.
   ;; (default t)
   dotspacemacs-elpa-https (not (eq system-type 'windows-nt))
   ;; Maximum allowed time in seconds to contact an ELPA repository.
   dotspacemacs-elpa-timeout 5
   ;; If non nil then spacemacs will check for updates at startup
   ;; when the current branch is not `develop'. (default t)
   dotspacemacs-check-for-update t
   ;; One of `vim', `emacs' or `hybrid'. Evil is always enabled but if the
   ;; variable is `emacs' then the `holy-mode' is enabled at startup. `hybrid'
   ;; uses emacs key bindings for vim's insert mode, but otherwise leaves evil
   ;; unchanged. (default 'vim)
   dotspacemacs-editing-style 'vim
   ;; If non nil output loading progress in `*Messages*' buffer. (default nil)
   dotspacemacs-verbose-loading nil
   ;; Specify the startup banner. Default value is `official', it displays
   ;; the official spacemacs logo. An integer value is the index of text
   ;; banner, `random' chooses a random text banner in `core/banners'
   ;; directory. A string value must be a path to an image format supported
   ;; by your Emacs build.
   ;; If the value is nil then no banner is displayed. (default 'official)
   dotspacemacs-startup-banner nil
   ;; List of items to show in the startup buffer. If nil it is disabled.
   ;; Possible values are: `recents' `bookmarks' `projects'.
   ;; (default '(recents projects))
   dotspacemacs-startup-lists '(recents projects)
   ;; Number of recent files to show in the startup buffer. Ignored if
   ;; `dotspacemacs-startup-lists' doesn't include `recents'. (default 5)
   dotspacemacs-startup-recent-list-size 5
   ;; Default major mode of the scratch buffer (default `text-mode')
   dotspacemacs-scratch-mode 'text-mode
   ;; List of themes, the first of the list is loaded when spacemacs starts.
   ;; Press <SPC> T n to cycle to the next theme in the list (works great
   ;; with 2 themes variants, one dark and one light)
   dotspacemacs-themes '(base16-tomorrow-dark)
   ;; If non nil the cursor color matches the state color in GUI Emacs.
   dotspacemacs-colorize-cursor-according-to-state nil
   ;; Default font. `powerline-scale' allows to quickly tweak the mode-line
   ;; size to make separators look not too crappy.
   dotspacemacs-default-font (if (eq system-type 'windows-nt)
                                 '("Consolas" :size 14)
                               '("Source Code Pro Medium" :size 14))
   ;; The leader key
   dotspacemacs-leader-key "SPC"
   ;; The leader key accessible in `emacs state' and `insert state'
   ;; (default "M-m")
   dotspacemacs-emacs-leader-key "M-m"
   ;; Major mode leader key is a shortcut key which is the equivalent of
   ;; pressing `<leader> m`. Set it to `nil` to disable it. (default ",")
   dotspacemacs-major-mode-leader-key ","
   ;; Major mode leader key accessible in `emacs state' and `insert state'.
   ;; (default "C-M-m)
   dotspacemacs-major-mode-emacs-leader-key "C-M-m"
   ;; These variables control whether separate commands are bound in the GUI to
   ;; the key pairs C-i, TAB and C-m, RET.
   ;; Setting it to a non-nil value, allows for separate commands under <C-i>
   ;; and TAB or <C-m> and RET.
   ;; In the terminal, these pairs are generally indistinguishable, so this only
   ;; works in the GUI. (default nil)
   dotspacemacs-distinguish-gui-tab nil
   ;; (Not implemented) dotspacemacs-distinguish-gui-ret nil
   ;; The command key used for Evil commands (ex-commands) and
   ;; Emacs commands (M-x).
   ;; By default the command key is `:' so ex-commands are executed like in Vim
   ;; with `:' and Emacs commands are executed with `<leader> :'.
   dotspacemacs-command-key ":"
   ;; If non nil `Y' is remapped to `y$'. (default t)
   dotspacemacs-remap-Y-to-y$ t
   ;; Name of the default layout (default "Default")
   dotspacemacs-default-layout-name "Default"
   ;; If non nil the default layout name is displayed in the mode-line.
   ;; (default nil)
   dotspacemacs-display-default-layout nil
   ;; If non nil then the last auto saved layouts are resume automatically upon
   ;; start. (default nil)
   dotspacemacs-auto-resume-layouts nil
   ;; Location where to auto-save files. Possible values are `original' to
   ;; auto-save the file in-place, `cache' to auto-save the file to another
   ;; file stored in the cache directory and `nil' to disable auto-saving.
   ;; (default 'cache)
   dotspacemacs-auto-save-file-location 'cache
   ;; Maximum number of rollback slots to keep in the cache. (default 5)
   dotspacemacs-max-rollback-slots 5
   ;; If non nil then `ido' replaces `helm' for some commands. For now only
   ;; `find-files' (SPC f f), `find-spacemacs-file' (SPC f e s), and
   ;; `find-contrib-file' (SPC f e c) are replaced. (default nil)
   dotspacemacs-use-ido nil
   ;; If non nil, `helm' will try to minimize the space it uses. (default nil)
   dotspacemacs-helm-resize nil
   ;; if non nil, the helm header is hidden when there is only one source.
   ;; (default nil)
   dotspacemacs-helm-no-header nil
   ;; define the position to display `helm', options are `bottom', `top',
   ;; `left', or `right'. (default 'bottom)
   dotspacemacs-helm-position 'bottom
   ;; If non nil the paste micro-state is enabled. When enabled pressing `p`
   ;; several times cycle between the kill ring content. (default nil)
   dotspacemacs-enable-paste-micro-state t
   ;; Which-key delay in seconds. The which-key buffer is the popup listing
   ;; the commands bound to the current keystroke sequence. (default 0.4)
   dotspacemacs-which-key-delay 0.4
   ;; Which-key frame position. Possible values are `right', `bottom' and
   ;; `right-then-bottom'. right-then-bottom tries to display the frame to the
   ;; right; if there is insufficient space it displays it at the bottom.
   ;; (default 'bottom)
   dotspacemacs-which-key-position 'bottom
   ;; If non nil a progress bar is displayed when spacemacs is loading. This
   ;; may increase the boot time on some systems and emacs builds, set it to
   ;; nil to boost the loading time. (default t)
   dotspacemacs-loading-progress-bar nil
   ;; If non nil the frame is fullscreen when Emacs starts up. (default nil)
   ;; (Emacs 24.4+ only)
   dotspacemacs-fullscreen-at-startup nil
   ;; If non nil `spacemacs/toggle-fullscreen' will not use native fullscreen.
   ;; Use to disable fullscreen animations in OSX. (default nil)
   dotspacemacs-fullscreen-use-non-native nil
   ;; If non nil the frame is maximized when Emacs starts up.
   ;; Takes effect only if `dotspacemacs-fullscreen-at-startup' is nil.
   ;; (default nil) (Emacs 24.4+ only)
   dotspacemacs-maximized-at-startup t
   ;; A value from the range (0..100), in increasing opacity, which describes
   ;; the transparency level of a frame when it's active or selected.
   ;; Transparency can be toggled through `toggle-transparency'. (default 90)
   dotspacemacs-active-transparency 90
   ;; A value from the range (0..100), in increasing opacity, which describes
   ;; the transparency level of a frame when it's inactive or deselected.
   ;; Transparency can be toggled through `toggle-transparency'. (default 90)
   dotspacemacs-inactive-transparency 90
   ;; If non nil unicode symbols are displayed in the mode line. (default t)
   dotspacemacs-mode-line-unicode-symbols nil
   ;; If non nil smooth scrolling (native-scrolling) is enabled. Smooth
   ;; scrolling overrides the default behavior of Emacs which recenters the
   ;; point when it reaches the top or bottom of the screen. (default t)
   dotspacemacs-smooth-scrolling t
   ;; If non nil line numbers are turned on in all `prog-mode' and `text-mode'
   ;; derivatives. If set to `relative', also turns on relative line numbers.
   ;; (default nil)
   dotspacemacs-line-numbers nil
   ;; If non-nil smartparens-strict-mode will be enabled in programming modes.
   ;; (default nil)
   dotspacemacs-smartparens-strict-mode nil
   ;; Select a scope to highlight delimiters. Possible values are `any',
   ;; `current', `all' or `nil'. Default is `all' (highlight any scope and
   ;; emphasis the current one). (default 'all)
   dotspacemacs-highlight-delimiters 'all
   ;; If non nil advises quit functions to keep server open when quitting.
   ;; (default nil)
   dotspacemacs-persistent-server nil
   ;; List of search tool executable names. Spacemacs uses the first installed
   ;; tool of the list. Supported tools are `ag', `pt', `ack' and `grep'.
   ;; (default '("ag" "pt" "ack" "grep"))
   dotspacemacs-search-tools '("ag" "pt" "ack" "grep")
   ;; The default package repository used if no explicit repository has been
   ;; specified with an installed package.
   ;; Not used for now. (default nil)
   dotspacemacs-default-package-repository nil
   ;; Delete whitespace while saving buffer. Possible values are `all'
   ;; to aggressively delete empty line and long sequences of whitespace,
   ;; `trailing' to delete only the whitespace at end of lines, `changed'to
   ;; delete only whitespace for changed lines or `nil' to disable cleanup.
   ;; (default nil)
   dotspacemacs-whitespace-cleanup nil
   ))

(defun dotspacemacs/user-init ()
  "Initialization function for user code.
It is called immediately after `dotspacemacs/init'.  You are free to put almost
any user code here.  The exception is org related code, which should be placed
in `dotspacemacs/user-config'."
  (setq custom-theme-directory (expand-file-name "~/.dotfiles/theme"))
  (setq exec-path-from-shell-check-startup-files nil)
  (setq ido-use-faces nil)
  (defadvice spacemacs/defface-micro-state-faces (around tk/defface-micro-state-faces activate))
  ;;
  ;; For use with git mergetool, add these lines to .gitconfig:
  ;;
  ;; [merge]
  ;; 	tool = ediff
  ;; [mergetool.ediff]
  ;; 	cmd = emacs --eval \"(tk/mergetool \\\"$LOCAL\\\" \\\"$REMOTE\\\" \\\"$BASE\\\" \\\"$MERGED\\\")\"
  ;; or
  ;; 	cmd = emacsclient -t --eval \"(tk/mergetool \\\"$LOCAL\\\" \\\"$REMOTE\\\" \\\"$BASE\\\" \\\"$MERGED\\\")\"
  ;; or
  ;; 	cmd = emacsclient -c --frame-parameters=\"((fullscreen . maximized))\" --eval \"(tk/mergetool \\\"$LOCAL\\\" \\\"$REMOTE\\\" \\\"$BASE\\\" \\\"$MERGED\\\")\"
  ;;
  (defun tk/mergetool (file-a file-b file-ancestor file-merge)
    (defun mergetool/ediff-startup-hook ()
      (remove-hook 'ediff-startup-hook 'mergetool/ediff-startup-hook)
      (ediff-toggle-show-clashes-only)
      (ediff-next-difference))
    (defun mergetool/ediff-quit-merge-hook ()
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
      (delete-frame))
    (add-hook 'ediff-startup-hook 'mergetool/ediff-startup-hook)
    (add-hook 'ediff-quit-merge-hook 'mergetool/ediff-quit-merge-hook)
    (with-demoted-errors
        (ediff-merge-files-with-ancestor file-a file-b file-ancestor nil file-merge)))

  (with-eval-after-load "ediff"
    (add-hook 'ediff-keymap-setup-hook
              (lambda () (define-key ediff-mode-map (kbd "SPC") 'spacemacs-cmds)))
    (add-hook 'ediff-before-setup-hook
              (lambda ()
                (window-configuration-to-register :ediff-window-config)))
    (add-hook 'ediff-quit-hook
              (lambda ()
                (jump-to-register :ediff-window-config)) 'append))
  )

(defun dotspacemacs/user-config ()
  "Configuration function for user code.
This function is called at the very end of Spacemacs initialization after
layers configuration. You are free to put any user code."
  (defun dotspacemacs/location ()
    (expand-file-name "~/.dotfiles/spacemacs"))
  (when (spacemacs/system-is-mac)
    (setq ns-use-srgb-colorspace nil))
  (setq paradox-github-token t)
  (setq evil-want-fine-undo 'no)

  (with-eval-after-load "with-editor"
    (add-hook 'with-editor-mode-hook 'evil-insert-state))

  (setq magit-delete-by-moving-to-trash nil)

  (setq ac-ignore-case 'smart
        ac-use-menu-map t)
  (add-hook 'emacs-lisp-mode-hook (defun tk/emacs-lisp-mode-hook ()
                                    (company-mode -1)
                                    (auto-complete-mode 1)
                                    (ac-emacs-lisp-mode-setup)) t)

  (with-eval-after-load "yasnippet"
    (spacemacs/set-leader-keys-for-minor-mode 'yas-minor-mode
      "oyn" 'yas-new-snippet
      "oyv" 'yas-visit-snippet-file)
    (evil-set-initial-state 'snippet-mode 'insert)
    (setq yas-snippet-dirs (list (expand-file-name "~/.dotfiles/emacs/snippets")))
    (define-key yas-minor-mode-map (kbd "TAB") 'yas-expand)
    (define-key yas-minor-mode-map (kbd "<tab>") 'yas-expand)
    (require 'popup)
    (define-key popup-menu-keymap (kbd "C-j") 'popup-next)
    (define-key popup-menu-keymap (kbd "C-k") 'popup-previous)

    (defun yas-popup-prompt (prompt choices &optional display-fn)
      (popup-menu*
       (mapcar
        (lambda (choice)
          (popup-make-item
           (or (and display-fn (funcall display-fn choice))
               choice)
           :value choice))
        choices)))

    (setq yas-prompt-functions '(yas-popup-prompt))
    (setq yas-also-auto-indent-first-line t))

  ;; basic
  (setq-default require-final-newline t)

  ;; utils
  (defun spacemacs-tk/cleanup-buffer-safe ()
    (interactive)
    (if indent-tabs-mode
        (tabify (point-min) (point-max))
      (untabify (point-min) (point-max)))
    (delete-trailing-whitespace)
    (set-buffer-file-coding-system 'utf-8))

  (defun spacemacs-tk/cleanup-buffer ()
    (interactive)
    (cleanup-buffer-safe)
    (indent-region (point-min) (point-max)))

  (setq powerline-default-separator 'arrow)
  (unless (spacemacs/system-is-mswindows)
    (setq shell-command-switch "-ic"))
  (setq whitespace-style
        '(face
          trailing
          indentation
          space-before-tab
          space-after-tab))
  (remove-hook 'diff-mode-hook 'spacemacs//set-whitespace-style-for-diff)
  (defun spacemacs-tk/find-color-theme ()
    (interactive)
    (find-file-existing (expand-file-name "~/.dotfiles/theme/base16-tomorrow-dark-theme.el")))
  (setq avy-background nil)
  (setq delete-by-moving-to-trash nil)

  (defadvice flymake-display-warning (around tk/flymake-display-warning activate)
    "Display a warning to the user, using message"
    (message warning))

  ;; c++-mode
  (add-to-list 'auto-mode-alist '("\\.mm\\'" . objc-mode))

  (defadvice c-mark-function (after c-mark-function-ad activate)
    (if (looking-back "\n\n")
        (forward-line -1)))

  (defun tk-c-mode-common-hook ()
    (setq ac-sources '(ac-source-words-in-same-mode-buffers))
    (local-set-key (kbd "C-c r a") 'tk-line-wf-args-switch))
  (add-hook 'c-mode-common-hook 'tk-c-mode-common-hook)

  (with-eval-after-load "helm"
    (define-key helm-map (kbd "M-j") 'helm-follow-action-forward)
    (define-key helm-map (kbd "M-k") 'helm-follow-action-backward)
    (define-key helm-map (kbd "M-K") 'helm-delete-minibuffer-contents))

  (with-eval-after-load "projectile"
    (defun spacemacs-tk/default-pop-shell-in-project-root ()
      (interactive)
      (let ((default-directory (projectile-project-root)))
        (spacemacs/default-pop-shell)))
    (defadvice projectile-compile-project (around spacemacs-tk/projectile-compile-project activate)
      (let ((default-directory (projectile-project-root)))
        (call-interactively 'compile)))
    (defun find-file-in-project-from-kill ()
      (interactive)
      (find-file (projectile-expand-root (current-kill 0))))
    (setq projectile-mode-line '(:eval (format " [%s]" (projectile-project-name))))
    (helm-projectile-on)
    (define-key projectile-command-map (kbd "w") 'find-file-in-project-from-kill)
    (spacemacs/set-leader-keys
      "p" 'projectile-command-map
      "\"" 'spacemacs-tk/default-pop-shell-in-project-root))

  (with-eval-after-load "helm-projectile"
    (defun spacemacs/helm-default-pop-shell (dir)
      (interactive)
      (let ((default-directory dir))
        (spacemacs/default-pop-shell)))
    (define-key helm-projectile-projects-map
      (kbd "M-t")
      (lambda ()
        (interactive)
        (helm-exit-and-execute-action 'spacemacs/helm-default-pop-shell))))

  (defmacro customize-helm-swoop (swoop-func)
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

  ;; (customize-helm-swoop helm-swoop)
  (customize-helm-swoop helm-multi-swoop-all)
  (customize-helm-swoop helm-multi-swoop-current-mode)

  (let ((comint-hooks '(eshell-mode-hook
                        term-mode-hook
                        messages-buffer-mode-hook
                        comint-mode-hook)))
    (spacemacs/add-to-hooks (defun tk/setup-comint-modes ()
                              (setq-local evil-move-cursor-back nil)
                              (setq-local global-hl-line-mode nil))
                            comint-hooks))
  (evil-set-initial-state 'term-mode 'emacs)
  (evil-set-initial-state 'eshell-mode 'emacs)
  (add-hook 'eshell-mode-hook 'spacemacs//unset-scroll-margin)

  (spacemacs/set-leader-keys
    "bD" (defun tk/kill-this-buffer-with-window ()
           (interactive)
           (kill-this-buffer)
           (delete-window))
    "fm" 'helm-multi-files
    "ha" 'helm-apropos
    ".f" 'flymake-mode
    "fec" 'spacemacs-tk/find-color-theme
    "fzd" (defun tk/find-zshrc ()
            (interactive)
            (find-file-existing (expand-file-name "~/.dotfiles/zsh/zshrc")))
    "fzc" (defun tk/find-zsh-prompt ()
            (interactive)
            (find-file-existing (expand-file-name "~/.dotfiles/zsh/functions/prompt_tk_setup")))
    "Cr" (defun tk/reload-theme ()
           (interactive)
           (load-theme 'base16-tomorrow-dark t))
    "sm" 'helm-multi-swoop-current-mode
    "sM" 'spacemacs/helm-multi-swoop-current-mode-region-or-symbol
    "g=" 'vc-version-ediff
    "sJ" 'helm-imenu-in-all-buffers)

  (with-eval-after-load "term"
    (add-hook 'term-mode-hook
              (defun tk/setup-term-map ()
                (define-key term-raw-map (kbd "C-r") 'term-send-raw)
                (define-key term-raw-map (kbd "C-s") 'term-send-raw)
                (define-key term-raw-map (kbd "C-p") 'term-send-raw)
                (define-key term-raw-map (kbd "C-n") 'term-send-raw)
                (define-key term-raw-map (kbd "C-_") 'term-send-raw)
                (define-key term-raw-map (kbd "M-Y") 'term-paste)
                (define-key term-raw-map (kbd "M-f") 'term-send-raw-meta)
                (define-key term-raw-map (kbd "M-b") 'term-send-raw-meta)
                (define-key term-raw-map (kbd "M-d") 'term-send-raw-meta)
                (define-key term-raw-map (kbd "M-p") 'term-send-raw-meta)
                (define-key term-raw-map (kbd "M-n") 'term-send-raw-meta)
                (define-key term-raw-map (kbd "M-j") 'term-send-raw-meta)
                (define-key term-raw-map (kbd "M-k") 'term-send-raw-meta)
                (define-key term-raw-map (kbd "M-l") 'term-send-raw-meta)) t))

  (setq hippie-expand-try-functions-list '(try-expand-dabbrev-closest-first
                                           try-complete-file-name
                                           try-expand-dabbrev-all-buffers
                                           try-expand-dabbrev-from-kill
                                           try-expand-all-abbrevs
                                           try-complete-lisp-symbol-partially
                                           try-complete-lisp-symbol))

  (setq evil-complete-next-func
        (defun hippie-expand-lines (arg)
          (interactive)
          (let ((hippie-expand-try-functions-list '(try-expand-line-closest-first
                                                    try-expand-line-all-buffers)))
            (hippie-expand arg))))

  (global-vim-empty-lines-mode -1)
  (add-hook 'prog-mode-hook (lambda () (vim-empty-lines-mode 1)))

  (spacemacs/toggle-mode-line-major-mode-off)
  (spacemacs/toggle-mode-line-minor-modes-off)

  (let ((tk-private (expand-file-name "~/.dotfiles/emacs/private/private.el")))
    (when (file-readable-p tk-private)
      (load-file tk-private)))
  )

;; Do not write anything past this comment. This is where Emacs will
;; auto-generate custom variable definitions.

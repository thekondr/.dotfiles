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
   dotspacemacs-configuration-layer-path '()
   ;; List of configuration layers to load. If it is the symbol `all' instead
   ;; of a list then all discovered layers will be installed.
   dotspacemacs-configuration-layers
   '(
     ;; ----------------------------------------------------------------
     ;; Example of useful layers you may want to use right away.
     ;; Uncomment some layer names and press <SPC f e R> (Vim style) or
     ;; <M-m f e R> (Emacs style) to install them.
     ;; ----------------------------------------------------------------
     (auto-completion :variables
                      auto-completion-enable-snippets-in-popup t)
     ;; better-defaults
     emacs-lisp
     (git :variables
          git-magit-status-fullscreen t)
     c-c++
     gtags
     ;; markdown
     ;; org
     (shell :variables
            shell-default-height 30
            shell-default-position 'bottom)
     shell-scripts
     ;; spell-checking
     ;; syntax-checking
     (version-control :variables
                      version-control-diff-tool 'diff-hl)
     )
   ;; List of additional packages that will be installed without being
   ;; wrapped in a layer. If you need some configuration for these
   ;; packages then consider to create a layer, you can also put the
   ;; configuration in `dotspacemacs/config'.
   dotspacemacs-additional-packages '(google-c-style flymake-cursor)
   ;; A list of packages and/or extensions that will not be install and loaded.
   dotspacemacs-excluded-packages '(evil-search-highlight-persist)
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
   dotspacemacs-startup-banner 'official
   ;; List of items to show in the startup buffer. If nil it is disabled.
   ;; Possible values are: `recents' `bookmarks' `projects'.
   ;; (default '(recents projects))
   dotspacemacs-startup-lists '(recents projects)
   ;; List of themes, the first of the list is loaded when spacemacs starts.
   ;; Press <SPC> T n to cycle to the next theme in the list (works great
   ;; with 2 themes variants, one dark and one light)
   dotspacemacs-themes '(base16-tomorrow-dark
                         spacemacs-dark
                         spacemacs-light
                         solarized-light
                         solarized-dark
                         leuven
                         monokai
                         zenburn)
   ;; If non nil the cursor color matches the state color.
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
   ;; The command key used for Evil commands (ex-commands) and
   ;; Emacs commands (M-x).
   ;; By default the command key is `:' so ex-commands are executed like in Vim
   ;; with `:' and Emacs commands are executed with `<leader> :'.
   dotspacemacs-command-key ":"
   ;; If non nil `Y' is remapped to `y$'. (default t)
   dotspacemacs-remap-Y-to-y$ t
   ;; Location where to auto-save files. Possible values are `original' to
   ;; auto-save the file in-place, `cache' to auto-save the file to another
   ;; file stored in the cache directory and `nil' to disable auto-saving.
   ;; (default 'cache)
   dotspacemacs-auto-save-file-location 'cache
   ;; If non nil then `ido' replaces `helm' for some commands. For now only
   ;; `find-files' (SPC f f), `find-spacemacs-file' (SPC f e s), and
   ;; `find-contrib-file' (SPC f e c) are replaced. (default nil)
   dotspacemacs-use-ido nil
   ;; If non nil, `helm' will try to miminimize the space it uses. (default nil)
   dotspacemacs-helm-resize nil
   ;; if non nil, the helm header is hidden when there is only one source.
   ;; (default nil)
   dotspacemacs-helm-no-header nil
   ;; define the position to display `helm', options are `bottom', `top',
   ;; `left', or `right'. (default 'bottom)
   dotspacemacs-helm-position 'bottom
   ;; If non nil the paste micro-state is enabled. When enabled pressing `p`
   ;; several times cycle between the kill ring content. (default nil)
   dotspacemacs-enable-paste-micro-state nil
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
   ))

(defun dotspacemacs/user-init ()
  "Initialization function for user code.
It is called immediately after `dotspacemacs/init'.  You are free to put any
user code."
  ;; color theme
  (setq custom-theme-directory (expand-file-name "~/.dotfiles/theme"))
  )

(defun dotspacemacs/user-config ()
  "Configuration function for user code.
 This function is called at the very end of Spacemacs initialization after
layers configuration. You are free to put any user code."
  (defun dotspacemacs/location ()
    (expand-file-name "~/.dotfiles/spacemacs"))
  (when (window-system)
    (setq ns-use-srgb-colorspace nil))
  (setq paradox-github-token t)
  (setq evil-want-fine-undo 'no)

  ;; evil little word
  ;; magnars hippie-exp closest first

  ;; (setq vc-make-backup-files t)

  ;; (use-package diff-mode
  ;;   :defer t
  ;;   :config
  ;;   (evil-set-initial-state 'diff-mode 'emacs)
  ;;   (add-hook 'diff-mode-hook 'whitespace-mode)
  ;;   (define-key diff-mode-shared-map "j" 'diff-hunk-next)
  ;;   (define-key diff-mode-shared-map "k" 'diff-hunk-prev)
  ;;   (define-key diff-mode-shared-map "d" 'diff-hunk-kill)
  ;;   (define-key diff-mode-shared-map "J" 'diff-file-next)
  ;;   (define-key diff-mode-shared-map "K" 'diff-file-prev)
  ;;   (define-key diff-mode-shared-map "D" 'diff-file-kill))

  ;; (use-package ediff
  ;;   :defer t
  ;;   :config
  ;;   (setq ediff-window-setup-function 'ediff-setup-windows-plain)
  ;;   (setq ediff-split-window-function 'split-window-horizontally)
  ;;   (setq ediff-merge-split-window-function 'split-window-horizontally)
  ;;   (add-hook 'ediff-before-setup-hook
  ;;             (lambda ()
  ;;               (window-configuration-to-register :ediff-window-config)))
  ;;   (add-hook 'ediff-quit-hook
  ;;             (lambda ()
  ;;               (jump-to-register :ediff-window-config)) 'append))

  ;; (use-package with-editor
  ;;   :defer t
  ;;   :config
  ;;   (add-hook 'with-editor-mode-hook 'evil-insert-state))

  ;; (use-package magit
  ;;   :defer t
  ;;   :commands (tk/magit-diff-head)
  ;;   :init
  ;;   (setq magit-last-seen-setup-instructions "1.4.0")
  ;;   (evil-leader/set-key
  ;;     "gb" 'magit-blame
  ;;     "gl" 'magit-log-all
  ;;     "gL" 'magit-log-buffer-file
  ;;     "gd" 'tk/magit-diff-head
  ;;     "g=" 'vc-version-ediff)

  ;;   :config
  ;;   (evil-set-initial-state 'magit-mode 'emacs)
  ;;   (setq magit-push-always-verify nil)
  ;;   (setq magit-delete-by-moving-to-trash nil)
  ;;   (defadvice magit-status-internal (around magit-fullscreen activate)
  ;;     (window-configuration-to-register :magit-fullscreen)
  ;;     ad-do-it
  ;;     (delete-other-windows))

  ;;   (defun magit-quit-session ()
  ;;     "Restores the previous window configuration and kills the magit buffer"
  ;;     (interactive)
  ;;     (kill-buffer)
  ;;     (jump-to-register :magit-fullscreen))

  ;;   (add-hook 'magit-status-mode-hook
  ;;             (lambda ()
  ;;               (define-key magit-status-mode-map
  ;;                 (kbd "q") 'magit-quit-session)))

  ;;   (define-key magit-blame-mode-map "j" 'magit-blame-next-chunk)
  ;;   (define-key magit-blame-mode-map "J" 'magit-blame-next-chunk-same-commit)
  ;;   (define-key magit-blame-mode-map "k" 'magit-blame-previous-chunk)
  ;;   (define-key magit-blame-mode-map "K" 'magit-blame-previous-chunk-same-commit)

  ;;   (defun tk/post-magit-blame-mode (&rest args)
  ;;     (if magit-blame-mode (evil-emacs-state) (evil-normal-state)))
  ;;   (advice-add 'magit-blame-mode :after 'tk/post-magit-blame-mode)

  ;;   (defun tk/magit-diff-head ()
  ;;     "Execute `magit-diff' against current HEAD."
  ;;     (interactive)
  ;;     (magit-diff "HEAD")))

  ;; (defun ediff-write-merge-buffer ()
  ;;   (let ((file ediff-merge-store-file))
  ;;     (set-buffer ediff-buffer-C)
  ;;     (write-region (point-min) (point-max) file)
  ;;     (message "Merge buffer saved in: %s" file)
  ;;     (set-buffer-modified-p nil)
  ;;     (sit-for 1)))

  ;; ;; For use with git mergetool, add these lines to .gitconfig:
  ;; ;;
  ;; ;; [merge]
  ;; ;; 	tool = ediff
  ;; ;; [mergetool.ediff]
  ;; ;; 	cmd = emacs --eval \"(tk/mergetool \\\"$LOCAL\\\" \\\"$REMOTE\\\" \\\"$BASE\\\" \\\"$MERGED\\\")\"
  ;; ;;
  ;; (defun tk/mergetool (file-a file-b file-ancestor file-merge)
  ;;   (setq ediff-quit-hook 'kill-emacs
  ;;         ediff-quit-merge-hook 'ediff-write-merge-buffer)
  ;;   (ediff-merge-files-with-ancestor file-a file-b file-ancestor nil file-merge))

  ;; (use-package auto-complete
  ;;   :defer t
  ;;   :diminish auto-complete-mode
  ;;   :init
  ;;   (setq ac-comphist-file (concat tk-cache-dir "ac-comphist.dat")
  ;;         ac-ignore-case 'smart
  ;;         ac-use-menu-map t
  ;;         ac-use-quick-help nil)
  ;;   (ac-config-default)
  ;;   :config
  ;;   (define-key ac-complete-mode-map (kbd "C-j") 'ac-next)
  ;;   (define-key ac-complete-mode-map (kbd "C-k") 'ac-previous)
  ;;   (define-key ac-complete-mode-map (kbd "<tab>") 'ac-complete)
  ;;   (define-key ac-complete-mode-map (kbd "TAB") 'ac-complete)
  ;;   (add-to-list 'ac-sources 'ac-source-yasnippet))

  ;; (use-package yasnippet
  ;;   :defer t
  ;;   :diminish yas-minor-mode
  ;;   :init
  ;;   (add-hook 'prog-mode-hook 'yas-minor-mode)
  ;;   (evil-leader/set-key
  ;;     "yn" 'yas-new-snippet
  ;;     "yv" 'yas-visit-snippet-file)
  ;;   (evil-set-initial-state 'snippet-mode 'insert)
  ;;   (setq yas-snippet-dirs (list (concat tk-emacs-dir "snippets")))
  ;;   :config
  ;;   (require 'popup)
  ;;   (define-key popup-menu-keymap (kbd "C-j") 'popup-next)
  ;;   (define-key popup-menu-keymap (kbd "C-k") 'popup-previous)

  ;;   (defun yas-popup-prompt (prompt choices &optional display-fn)
  ;;     (popup-menu*
  ;;      (mapcar
  ;;       (lambda (choice)
  ;;         (popup-make-item
  ;;          (or (and display-fn (funcall display-fn choice))
  ;;              choice)
  ;;          :value choice))
  ;;       choices)))

  ;;   (setq yas-prompt-functions '(yas-popup-prompt))
  ;;   (setq yas-also-auto-indent-first-line t)
  ;;   (yas-reload-all))

  ;; basic
  (setq backup-directory-alist
        `((".*" . ,temporary-file-directory)))
  (setq auto-save-file-name-transforms
        `((".*" ,temporary-file-directory t)))
  (setq require-final-newline t)

  ;; utils
  (defun add-to-exec-path (path &optional append)
    (if append
        (setenv "PATH" (concat (getenv "PATH") ":" path))
      (setenv "PATH" (concat path ":" (getenv "PATH"))))
    (add-to-list 'exec-path path append))

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

  (defadvice spacemacs//helm-hjkl-navigation (after spacemacs//helm-hjl-navigation activate)
    (define-key helm-map (kbd "C-k") 'helm-delete-minibuffer-contents))
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

  (defun flymake-display-warning (warning)
    "Display a warning to the user, using message"
    (message warning))

  ;; projectile
  (defadvice projectile-compile-project (around spacemacs-tk/projectile-compile-project activate)
    (let ((default-directory (projectile-project-root)))
      (call-interactively 'compile)))

  (defun find-file-in-project-from-kill ()
    (interactive)
    (find-file (projectile-expand-root (current-kill 0))))
  (setq projectile-mode-line '(:eval (format " [%s]" (projectile-project-name))))
  ;; (with-eval-after-load "projectile"
  ;;   (define-key projectile-command-map (kbd "w") 'find-file-in-project-from-kill)
  ;;   (spacemacs/set-leader-keys "p" 'projectile-command-map))

  ;; c++-mode
  ;; (add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))
  ;; (add-to-list 'auto-mode-alist '("\\.mm\\'" . objc-mode))
  ;; (use-package auto-complete-clang)
  ;; (defun tk-clang-complete ()
  ;;   (interactive)
  ;;   (auto-complete '(ac-source-clang)))

  ;; (defadvice c-mark-function (after c-mark-function-ad activate)
  ;;   (if (looking-back "\n\n")
  ;;       (forward-line -1)))

  ;; (defun tk-beginning-of-args ()
  ;;   (unless (looking-back "(")
  ;;     (cond ((looking-at "(") nil)
  ;;           ((looking-back ");?") (forward-list -1))
  ;;           (t (progn (forward-char)
  ;;                     (c-beginning-of-defun))))
  ;;     (search-forward "(")))

  ;; (defmacro tk-do-args (&rest body)
  ;;   `(while (progn (search-forward-regexp "[<>{}(),]")
  ;;                  (or (not (string= (match-string 0) ")"))
  ;;                      (c-in-literal)))
  ;;      (unless (c-in-literal)
  ;;        (cond ((string-match "[<({]" (match-string 0)) (forward-char -1) (forward-list))
  ;;              ((string= (match-string 0) ",") ,@body)))))

  ;; (defun tk-backward-arg-1 ()
  ;;   (let ((r (point)))
  ;;     (skip-chars-backward " \t\n")
  ;;     (when (looking-back ",")
  ;;       (forward-char -1))
  ;;     (while
  ;;         (progn
  ;;           (search-backward-regexp "[<>{}(),]" nil t)
  ;;           (or (not (string-match "[{(<,]" (match-string 0)))
  ;;               (c-in-literal)))
  ;;       (unless (c-in-literal)
  ;;         (forward-char)
  ;;         (forward-list -1)))
  ;;     (search-forward-regexp "[^({<,[:space:]\n]")
  ;;     (forward-char -1)
  ;;     (not (equal r (point)))))

  ;; (defun tk-forward-arg-1 ()
  ;;   (let ((r (point)))
  ;;     (when (looking-at ",")
  ;;       (forward-char))
  ;;     (while
  ;;         (progn
  ;;           (search-forward-regexp "[<>{}(),]" nil t)
  ;;           (or (not (string-match "[})>,]" (match-string 0)))
  ;;               (c-in-literal)))
  ;;       (unless (c-in-literal)
  ;;         (forward-char -1)
  ;;         (forward-list)))
  ;;     (forward-char -1)
  ;;     (not (equal r (point)))))

  ;; (defun tk-forward-arg (&optional arg)
  ;;   (interactive "p")
  ;;   (or arg (setq arg 1))
  ;;   (while (> arg 0)
  ;;     (setq arg (- arg 1))
  ;;     (tk-forward-arg-1))
  ;;   (while (< arg 0)
  ;;     (setq arg (+ arg 1))
  ;;     (tk-backward-arg-1)))

  ;; (defun tk-backward-arg (&optional arg)
  ;;   (interactive "p")
  ;;   (or arg (setq arg 1))
  ;;   (tk-forward-arg (- arg)))

  ;; (defun tk-beginning-of-arg-p ()
  ;;   (and (looking-back "[{(<,][[:space:]\n]*")
  ;;        (not (c-in-literal))))

  ;; (defun tk-end-of-arg-p ()
  ;;   (and (looking-at "[[:space:]\n]*[})>,]")
  ;;        (not (c-in-literal))))

  ;; (defun tk-first-arg-p ()
  ;;   (save-excursion
  ;;     (unless (tk-beginning-of-arg-p)
  ;;       (tk-backward-arg-1))
  ;;     (and (looking-back "[({<][[:space:]\n]*")
  ;;          (not (c-in-literal)))))

  ;; (defun tk-last-arg-p ()
  ;;   (save-excursion
  ;;     (unless (tk-end-of-arg-p)
  ;;       (tk-forward-arg-1))
  ;;     (and (looking-at "[[:space:]\n]*[)}>]")
  ;;          (not (c-in-literal)))))

  ;; (defun tk-kill-arg (arg)
  ;;   (interactive "p")
  ;;   (save-excursion
  ;;     (if (tk-beginning-of-arg-p)
  ;;         (skip-chars-forward " \t\n")
  ;;       (tk-backward-arg-1))
  ;;     (if (tk-last-arg-p)
  ;;         (kill-region (progn (if (tk-backward-arg-1)
  ;;                                 (tk-forward-arg-1))
  ;;                             (point))
  ;;                      (progn (tk-forward-arg arg)
  ;;                             (point)))
  ;;       (kill-region (point)
  ;;                    (progn (tk-forward-arg arg)
  ;;                           (if (tk-forward-arg-1)
  ;;                               (tk-backward-arg-1))
  ;;                           (point))))))

  ;; (defun tk-transpose-arg (arg)
  ;;   (interactive "*p")
  ;;   (transpose-subr 'tk-forward-arg arg))

  ;; (defun tk-multiline-wf-args ()
  ;;   (interactive)
  ;;   (save-excursion
  ;;     (tk-beginning-of-args)
  ;;     (unless (looking-at ")") (newline-and-indent))
  ;;     (tk-do-args (newline-and-indent))))

  ;; (defun tk-inline-wf-args ()
  ;;   (interactive)
  ;;   (save-excursion
  ;;     (tk-beginning-of-args)
  ;;     (tk-do-args (save-excursion (delete-indentation)))
  ;;     (unless (looking-back "()") (delete-indentation))))

  ;; (defun tk-line-wf-args-switch ()
  ;;   (interactive)
  ;;   (let (b e)
  ;;     (save-excursion
  ;;       (tk-beginning-of-args)
  ;;       (setq b (line-number-at-pos))
  ;;       (forward-char -1)
  ;;       (forward-list)
  ;;       (setq e (line-number-at-pos)))
  ;;     (if (equal b e)
  ;;         (tk-multiline-wf-args)
  ;;       (tk-inline-wf-args))))

  ;; (defun tk-comment-dwim-arg ()
  ;;   (interactive)
  ;;   (let ((comment-start "/* ") (comment-end " */"))
  ;;     (call-interactively 'comment-dwim)))

  ;; (defun tk-c-mode-common-hook ()
  ;;   (setq c-set-style "linux")
  ;;   (setq c-basic-offset 4)
  ;;   (c-set-offset 'substatement-open '0)
  ;;   (c-set-offset 'innamespace '0)
  ;;   (c-set-offset 'inline-open '0)
  ;;   (c-set-offset 'arglist-intro '+)
  ;;   (c-set-offset 'arglist-cont '0)
  ;;   (c-set-offset 'arglist-cont-nonempty '+)
  ;;   (setq ac-sources '(ac-source-words-in-same-mode-buffers))
  ;;   (local-set-key (kbd "C-c r a") 'tk-line-wf-args-switch))

  ;; (add-hook 'c-mode-common-hook 'tk-c-mode-common-hook)

  ;; helm
  ;; (define-key helm-map (kbd "M-n") 'helm-follow-action-forward)
  ;; (define-key helm-map (kbd "M-p") 'helm-follow-action-backward)
  ;; (define-key helm-map (kbd "M-j") 'helm-follow-action-forward)
  ;; (define-key helm-map (kbd "M-k") 'helm-follow-action-backward)

  (spacemacs/set-leader-keys
    "fm" 'helm-multi-files
    ".f" 'flymake-mode
    "fec" 'spacemacs-tk/find-color-theme
    "pw" 'find-file-in-project-from-kill
    "sm" 'helm-multi-swoop-current-mode
    "sj" 'helm-imenu-in-all-buffers)

  ;; android
  ;; (defun tk-ant ()
  ;;   (interactive)
  ;;   (let ((compilation-process-setup-function
  ;;          (lambda ()
  ;;            (setq-local compilation-finish-functions
  ;;                        'tk-android-auto-run))))
  ;;     (android-ant "debug install")))
  ;; (defun tk-android-auto-run (buffer msg)
  ;;   (when (string-match "finished" msg)
  ;;     (android-start-app)))

  ;; multipe cursors
  ;; (use-package multiple-cursors
  ;;   :bind (("C-C C-C" . mc/edit-lines)
  ;;          ("M-)" . mc/mark-next-like-this)
  ;;          ("M-(" . mc/mark-previous-like-this)
  ;;          ("M-9" . mc/mark-all-like-this)
  ;;          ("M-0" . mc/mark-all-like-this-in-defun)))
  ;; (use-package phi-search)
)

;; Do not write anything past this comment. This is where Emacs will
;; auto-generate custom variable definitions.

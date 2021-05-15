;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name ""
      user-mail-address "")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
(setq doom-font "Source Code Pro Medium-14")

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'tk-base16)
(setq base16-theme-256-color-source "base16-shell")
(setq custom-theme-directory (expand-file-name "~/.dotfiles/emacs/theme"))
(add-to-list 'load-path custom-theme-directory)
(add-to-list 'load-path (expand-file-name "~/.dotfiles/emacs"))

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)


;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

(setq diff-font-lock-syntax nil)
(setq doom-modeline-buffer-file-name-style 'file-name)

(when IS-LINUX
    (setq doom-modeline-height 32))

(when IS-MAC
  (setq mac-command-modifier 'control)
  (setq ns-command-modifier 'control)
  (setq ns-right-option-modifier 'left))

(setq winum-scope 'frame-local)
(setq evil-want-fine-undo 'no)
(add-to-list 'evil-motion-state-modes 'diff-mode)
(setq magit-delete-by-moving-to-trash nil)
(setq confirm-kill-emacs nil)
(setq +snippets-dir (expand-file-name "~/.dotfiles/emacs/snippets"))

(require 'diff-hl)

(after! popup
  (defun popup-vertical-motion (column direction)
    "A portable version of `vertical-motion'."
    (if (functionp 'line-number-display-width)
        (setq column (- column (line-number-display-width 'columns))))
    (vertical-motion (cons column direction))))

(defun tk-counsel-projectile-vc ()
  (interactive)
  (require 'counsel-projectile)
  (counsel-projectile-switch-project #'counsel-projectile-switch-project-action-vc))

(setq ivy-extra-directories nil)

(setq magit-refs-pad-commit-counts t)
(setq magit-revision-show-gravatars nil)
(setq magit-section-visibility-indicator nil)

;; Uncomment to disable tags in magit because they may slow down performance
;; in big repositories.
;; (after! magit
;;   (setq magit-refs-sections-hook (delq 'magit-insert-tags
;;                                        magit-refs-sections-hook)
;;         magit-status-headers-hook (delq 'magit-insert-tags-header
;;                                         magit-status-headers-hook)))

(setq git-messenger:show-detail t
      git-messenger:use-magit-popup t)

(after! git-messenger
  (defun open-github-url (&optional path)
    (interactive)
    (setq url (shell-command-to-string "git remote get-url origin"))
    (setq url (replace-regexp-in-string
               "git@\\(.*?\\):\\(.*\\)" "https://\\1/\\2" url))
    (setq url (replace-regexp-in-string
               "\\(.*?\\)\\(.git\\)?\\(\n\\|$\\)" "\\1" url))
    (browse-url (concat url path)))

  (defun open-github-commit (&optional rev)
    (interactive)
    (open-github-url (concat "/commit/" rev)))

  (defun git-messenger:git-commit-message (commit-id)
    (let ((args (git-messenger:cat-file-arguments commit-id)))
      (unless (zerop (git-messenger:execute-command 'git args t))
        (error "Failed: 'git cat-file'"))
      (goto-char (point-min))
      (forward-paragraph)
      (let ((p (or (search-forward " -----END PGP SIGNATURE-----" nil t)
                   (search-forward " -----END PGP MESSAGE-----" nil t))))
        (when p
          (goto-char p)
          (forward-paragraph)))
      (buffer-substring-no-properties (point) (point-max))))

  (defun tk/git-messenger:open-commit ()
    (interactive)
    (when git-messenger:last-commit-id
      (open-github-commit git-messenger:last-commit-id))
    (git-messenger:popup-close))

  (define-key git-messenger-map (kbd "o") 'tk/git-messenger:open-commit))

(defun tk/visit-pull-request-url ()
  "Visit the current branch's PR on Github."
  (interactive)
  (browse-url
    (format "https://github.com/%s/pull/new/%s"
      (replace-regexp-in-string
        "\\`.+github\\.com:\\(.+\\)\\.git\\'" "\\1"
        (magit-get "remote"
          (magit-get-current-remote)
          "url"))
      (magit-get-current-branch))))

(set-popup-rules! '(("*" :side right :size 0.5 :select t)))

(defvar tk/private-configs
  (list
   "~/.dotfiles/emacs/doom/config.el"
   "~/.zshrc"
   "~/.alacritty.yml"
   "~/.dotfiles/emacs/doom/init.el"
   "~/.dotfiles/emacs/doom/packages.el"
   "~/.dotfiles/zsh/zshrc"
   "~/.dotfiles/emacs/theme/base16-theme.el"))

(defun tk/find-private ()
  (interactive)
  (ivy-read "Find Config: " tk/private-configs
            :action (lambda (file)
                      (with-ivy-window
                        (when file
                          (find-file (expand-file-name file)))))))

(defadvice! tk--ivy-next-previous-line-and-call-a (orig-fn &rest args)
  :around #'ivy-next-line-and-call
  :around #'ivy-previous-line-and-call
  (if (memq last-command '(ivy-call ivy-next-line-and-call ivy-previous-line-and-call))
      (apply orig-fn args)
    (ivy-call)))

(defadvice! tk--evil-visualstar/begin-search (orig-fn &rest args)
  :around #'evil-visualstar/begin-search-backward
  :around #'evil-visualstar/begin-search-forward
  (let ((evil-ex-search-vim-style-regexp nil))
      (apply orig-fn args)))

(map! (:leader
       :n "SPC" #'counsel-M-x
       :n "1" #'winum-select-window-1
       :n "2" #'winum-select-window-2
       :n "3" #'winum-select-window-3
       :n "4" #'winum-select-window-4
       :n "5" #'winum-select-window-5
       :n "6" #'winum-select-window-6
       :n "7" #'winum-select-window-7
       :n "8" #'winum-select-window-8
       :n "9" #'winum-select-window-9
       :n "0" #'winum-select-window-0
       :n "j" #'evil-avy-goto-word-or-subword-1
       :n ";" #'evilnc-comment-operator
       :n "cr" #'recompile

       :n "g=" #'vc-version-ediff
       :n "oww" #'browse-url-at-point
       :n "fp" #'tk/find-private
       :n "gfh" #'magit-log-buffer-file
       :n "gv" #'diff-hl-diff-goto-hunk
       :n "gu" #'vc-revert
       :n "g~" #'vc-revision-other-window
       :n "gm" #'git-messenger:popup-message)

      (:i "C-n" #'+company/whole-lines
       :i "C-p" #'+company/dabbrev
       :i "C-a" #'evil-paste-last-insertion
       :i "C-," #'aya-expand
       :n "C-," #'aya-create
       :v "J" #'drag-stuff-down
       :v "K" #'drag-stuff-up)

  (:after tide
    (:map tide-mode-map
      :localleader
      "f" #'tide-fix
      "r" #'tide-refactor
      "q" #'tide-restart-server
      "i" #'tide-organize-imports
      "s" #'tide-nav
      "c" #'tide-rename-symbol))

      (:after magit
       (:map magit-mode-map
        :n "V" #'tk/visit-pull-request-url
        :nv "z" nil))

      (:map doom-leader-project-map
       "p" #'tk-counsel-projectile-vc
       "v" #'projectile-vc
       "g" #'projectile-find-file-dwim
       "G" #'projectile-find-file-dwim-other-window
       "t" #'projectile-find-implementation-or-test-other-window
       "T" #'magit-todos-list)

      (:map counsel-find-file-map
       "C-h" #'counsel-up-directory)

      (:map ivy-minibuffer-map
       "M-J" #'ivy-yank-word
       "M-K" #'kill-sentence
       "M-j" #'ivy-next-line-and-call
       "M-k" #'ivy-previous-line-and-call
       "C-v" #'ivy-scroll-up-command
       "M-v" #'ivy-scroll-down-command
       "C-h" #'doom/delete-backward-word
       "C-S-h" help-map))

  (defadvice! yas--move-to-field-end (_snippet field)
    :after #'yas--move-to-field
    (when (yas--field-modified-p field)
      (goto-char (yas--field-end field))))

(after! company
  (setq company-idle-delay 0.2)
  (setq company-tooltip-maximum-width 60))

(after! yasnippet
  (evil-set-initial-state 'snippet-mode 'insert)
  (setq yas-triggers-in-field t
        yas-snippet-dirs (list
                          +snippets-dir
                          (expand-file-name "~/.emacs.d/private/snippets")))
  (load (concat (expand-file-name "~/.dotfiles/emacs/snippets") "/utils.el"))
  (define-key yas-minor-mode-map (kbd "TAB") 'yas-expand)
  (define-key yas-minor-mode-map (kbd "<tab>") 'yas-expand)
  (require 'popup)
  (define-key popup-menu-keymap (kbd "C-j") 'popup-next)
  (define-key popup-menu-keymap (kbd "C-k") 'popup-previous)

  (add-hook 'snippet-mode-hook #'(lambda () (ws-butler-mode -1)))

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

(after! auto-yasnippet
  (setq aya-create-with-newline t))

;; basic
(setq-default require-final-newline t
              compilation-scroll-output t)

(setq powerline-default-separator nil)
(setq whitespace-style
      '(face
        trailing
        indentation
        space-before-tab
        space-after-tab))
(setq delete-by-moving-to-trash nil)

(after! js2-mode
  (add-hook 'js2-mode-hook #'(lambda ()
                               (setq js2-mode-show-parse-errors nil)
                               (setq js2-mode-show-strict-warnings nil)
                               (setq next-error-function nil)
                               (prettier-js-mode 1))))

(after! flycheck-popup-tip
  (setq flycheck-popup-tip-error-prefix ""))

(after! typescript-mode
  (add-hook 'typescript-mode-hook 'prettier-js-mode)
  (add-hook 'typescript-mode-hook 'tide-hl-identifier-mode)
  (after! tide
    (flycheck-add-next-checker 'typescript-tide 'javascript-eslint)))

(after! projectile
  (defun tk/find-file-in-project-from-kill ()
    (interactive)
    (let* ((data (split-string (current-kill 0) ":" t))
           (base-file (replace-regexp-in-string "\\\\" "/" (car data)))
           (file (projectile-expand-root base-file))
           (line (if (cdr data) (string-to-number (cadr data))))
           (column (if (cddr data) (string-to-number (caddr data)))))
      (find-file (if (file-readable-p file)
                     file
                   (projectile-expand-root
                    (projectile-completing-read
                     "Find file: "
                     (projectile-project-files (projectile-ensure-project (projectile-project-root)))
                     :initial-input base-file))))
      (when line (goto-char (point-min)) (forward-line (1- line)))
      (when column (forward-char (1- column)))))

  (setq projectile-create-missing-test-files t)

  (projectile-register-project-type 'npm '("package.json")
                                    :project-file "package.json"
                                    :compile "npm start"
                                    :test "npm test"
                                    :test-dir "src/"
                                    :test-suffix ".test")

  (defun tk/projectile-buffer-file-name ()
    (s-chop-prefix (projectile-project-root) (buffer-file-name)))

  (defun tk/projectile-header-guard ()
    (concat (replace-regexp-in-string "[/\.]" "_" (upcase (tk/projectile-buffer-file-name))) "_"))

  (defun tk/projectile-show-and-copy-buffer-filename ()
    "Show the path to the current file from project root in the minibuffer."
    (interactive)
    (let ((file-name (tk/projectile-buffer-file-name)))
      (if file-name
          (progn
            (message file-name)
            (kill-new file-name))
        (error "Buffer not visiting a file"))))

  (defun tk/show-and-copy-buffer-basename-and-line ()
    "Show the path to the current file from project root in the minibuffer."
    (interactive)
    (let ((file-name (file-name-nondirectory (buffer-file-name))))
      (if file-name
          (progn
            (setq file-name (concat file-name ":" (int-to-string (line-number-at-pos))))
            (message file-name)
            (kill-new file-name))
        (error "Buffer not visiting a file"))))

  (map! (:map doom-leader-project-map
         "y" #'tk/projectile-show-and-copy-buffer-filename
         "w" #'tk/find-file-in-project-from-kill)

        (:leader
         :n "\"" #'+vterm/here)))

(evil-define-text-object evil-a-defun (count &optional beg end type)
  "Select a defun."
  (evil-select-an-object 'evil-defun beg end type count t))

(evil-define-text-object evil-inner-defun (count &optional beg end type)
  "Select inner defun."
  (evil-select-inner-object 'evil-defun beg end type count t))

(use-package evil-defun
  :commands (evil-inner-defun
             evil-a-defun)
  :init
  (map! (:map evil-outer-text-objects-map "d" #'evil-a-defun)
        (:map evil-inner-text-objects-map "d" #'evil-inner-defun)))

(use-package! evil-little-word
  :commands (evil-forward-little-word-begin
             evil-backward-little-word-begin
             evil-forward-little-word-end
             evil-backward-little-word-end
             evil-a-little-word
             evil-inner-little-word)
  :init
  (map! (:map evil-outer-text-objects-map "lw" #'evil-a-little-word)
        (:map evil-inner-text-objects-map "lw" #'evil-inner-little-word)))

(defun flutter-chrome ()
  "Start `flutter run` or hot-reload if already running."
  (interactive)
  (if (flutter--running-p)
      (flutter-hot-reload)
    (flutter-run "-d chrome")))

(after! rustic
  (setq rustic-lsp-server 'rust-analyzer))

(evil-define-command +multiple-cursors/evil-mc-toggle-cursor-here ()
  "Create a cursor at point. If in visual block or line mode, then create
cursors on each line of the selection, on the column of the cursor. Otherwise
pauses cursors."
  :repeat nil
  :keep-visual nil
  :evil-mc t
  (interactive)
  (cond ((and (evil-mc-has-cursors-p)
              (evil-normal-state-p)
              (let* ((pos (point))
                     (cursor (cl-find-if (lambda (cursor)
                                           (eq pos (evil-mc-get-cursor-start cursor)))
                                         evil-mc-cursor-list)))
                (when cursor
                  (evil-mc-delete-cursor cursor)
                  (setq evil-mc-cursor-list (delq cursor evil-mc-cursor-list))
                  t))))

        ((and (boundp 'iedit-occurrences-overlays)
              iedit-occurrences-overlays)
         (let* ((ov (iedit-find-current-occurrence-overlay))
                (offset (- (point) (overlay-start ov)))
                (master (point)))
           (evil-mc-run-cursors-before)
           (dolist (occurrence iedit-occurrences-overlays)
             (let ((pos (+ (overlay-start occurrence) offset)))
               (unless (= master pos)
                 (evil-mc-make-cursor-at-pos pos))))
           (evil-multiedit-abort)))

        ((memq evil-this-type '(line block))
         (evil-mc-make-cursor-in-visual-selection-beg)
         (evil-mc-execute-for-all-cursors #'evil-normal-state))

        (t
         (evil-mc-pause-cursors)
         ;; I assume I don't want the cursors to move yet
         (evil-mc-make-cursor-here))))

(after! tide
  (defadvice! tide-no-save (orig-fn &rest args)
    :around #'tide-apply-code-edits
    :around #'tide-rename-symbol-at-location
    (cl-letf (((symbol-function 'basic-save-buffer) #'ignore))
      (apply orig-fn args))))

(set-frame-parameter (selected-frame) 'alpha 90)

(after! company
  (when (featurep! :completion company +childframe)
    (add-hook! 'evil-normal-state-entry-hook
      (defun +company-abort-h ()
        ;; HACK `company-abort' doesn't no-op if company isn't active; causing
        ;;      unwanted side-effects, like the suppression of messages in the
        ;;      echo-area.
        ;; REVIEW Revisit this to refactor; shouldn't be necessary!
        (when company-candidates
          (company-abort))))))

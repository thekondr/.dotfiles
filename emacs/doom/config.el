;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; refresh' after modifying this file!


;; These are used for a number of things, particularly for GPG configuration,
;; some email clients, file templates and snippets.
(setq user-full-name ""
      user-mail-address "")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
(setq doom-font "Source Code Pro Medium-14")

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. These are the defaults.
(setq doom-theme 'tk-base16)
(setq base16-theme-256-color-source "base16-shell")
(setq custom-theme-directory (expand-file-name "~/.dotfiles/emacs/theme"))
(add-to-list 'load-path custom-theme-directory)
(add-to-list 'load-path (expand-file-name "~/.dotfiles/emacs"))

;; If you intend to use org, it is recommended you change this!
(setq org-directory "~/org/")

;; If you want to change the style of line numbers, change this to `relative' or
;; `nil' to disable it:
(setq display-line-numbers-type 'relative)


;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', where Emacs
;;   looks when you load packages with `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c g k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c g d') to jump to their definition and see how
;; they are implemented.

(setq mac-command-modifier 'control)
(setq winum-scope 'frame-local)
(setq evil-want-fine-undo 'no)
(add-to-list 'evil-motion-state-modes 'diff-mode)
(setq magit-delete-by-moving-to-trash nil)

;; (setq hippie-expand-try-functions-list '(try-expand-dabbrev-closest-first
;;                                          try-complete-file-name
;;                                          try-expand-dabbrev-all-buffers
;;                                          try-expand-dabbrev-from-kill
;;                                          try-expand-all-abbrevs
;;                                          try-complete-lisp-symbol-partially
;;                                          try-complete-lisp-symbol))

;; (setq evil-complete-next-func
;;       (defun hippie-expand-lines (arg)
;;         (interactive)
;;         (let ((hippie-expand-try-functions-list '(yas-hippie-try-expand
;;                                                   try-expand-line-closest-first
;;                                                   try-expand-line-all-buffers)))
;;           (hippie-expand arg))))
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

(set-popup-rules! '(("*" :side right :size 0.5 :select t)))

(defvar tk/private-configs
  (list
   "~/.zshrc"
   "~/.dotfiles/emacs/doom/config.el"
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

(map! (:leader
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
       :n "/" #'+default/search-project
       :n "j" #'evil-avy-goto-word-or-subword-1
       :n "TAB" #'evil-switch-to-windows-last-buffer
       :n ";" #'evilnc-comment-operator
       :n "en" #'flycheck-next-error
       :n "ep" #'flycheck-previous-error

       :n "g=" #'vc-version-ediff
       :n "oww" #'browse-url-at-point
       :n "fp" #'tk/find-private
       :n "gv" #'diff-hl-diff-goto-hunk
       :n "gu" #'vc-revert
       :n "g~" #'vc-revision-other-window
       :n "gm" #'git-messenger:popup-message)

      (:i "C-." #'company-complete
       :i "C-," #'aya-expand
       :n "C-," #'aya-create
       :v "J" (concat ":m '>+1" (kbd "RET") "gv=gv")
       :v "K" (concat ":m '<-2" (kbd "RET") "gv=gv"))

      (:map doom-leader-project-map
       "p" #'tk-counsel-projectile-vc
       "v" #'projectile-vc)

      (:map counsel-find-file-map
       "C-h" #'counsel-up-directory)

      (:map ivy-minibuffer-map
       "M-J" #'ivy-yank-word
       "M-K" #'kill-sentence
       "M-j" #'ivy-next-line-and-call
       "M-k" #'ivy-previous-line-and-call
       "M-l" #'ivy-call
       "C-h" #'doom/delete-backward-word
       "C-S-h" help-map))

;; (after! ycmd
;;   (fset 'ycmd-command-map ycmd-command-map)
;;   (setq ycmd-server-command `("python" ,(expand-file-name "~/.ycmd/ycmd"))
;;         ycmd-extra-conf-whitelist `(,(expand-file-name "~/Documents/*")))
;;   (spacemacs/set-leader-keys-for-major-mode 'c++-mode "," 'ycmd-command-map))

;; (after! flycheck-ycmd
;;   (flycheck-add-next-checker 'ycmd 'c/c++-cppcheck))

;; (after! company
;;   (add-to-list 'company-backends-js2-mode '(company-flow))
;;   (add-to-list 'company-backends-react-mode '(company-flow)))

;; (after! company-flow
;;   (defun company-flow--parse-output (output)
;;     (when (not (or (equal output "Error: not enough type information to autocomplete\n")
;;                    (equal output "Error: autocomplete on possibly null or undefined value\n")))
;;       (mapcar 'company-flow--make-candidate
;;               (split-string output "\n"))))
;;   (defun company-flow--candidates-query (prefix callback)
;;     (let* ((line (line-number-at-pos (point)))
;;            (col (+ 1 (current-column)))
;;            (command (list (executable-find company-flow-executable)
;;                           "autocomplete"
;;                           "--quiet"
;;                           buffer-file-name
;;                           (number-to-string line)
;;                           (number-to-string col)))
;;            (process-connection-type nil)
;;            (process (apply 'start-process "company-flow" nil command)))
;;       (set-process-sentinel process #'company-flow--handle-signal)
;;       (set-process-filter process #'company-flow--receive-checker-output)
;;       (process-put process 'company-flow-callback callback)
;;       (process-put process 'company-flow-prefix prefix)
;;       (company-flow--process-send-buffer process))))

(after! yasnippet
  (evil-set-initial-state 'snippet-mode 'insert)
  (setq yas-snippet-dirs (list
                          (expand-file-name "~/.dotfiles/emacs/snippets")
                          (expand-file-name "~/.emacs.d/private/snippets")))
  (load (concat (expand-file-name "~/.dotfiles/emacs/snippets") "/utils.el"))
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

(after! flow-minor-mode
  (defun flow-minor-jump-to-definition-other-window ()
    (interactive)
    (let ((flow-minor-jump-other-window t))
      (flow-minor-jump-to-definition)))
  ;; (spacemacs/set-leader-keys-for-minor-mode 'flow-minor-mode
  ;;                                           "fs" 'flow-minor-status
  ;;                                           "ff" 'flow-minor-jump-to-definition
  ;;                                           "fF" 'flow-minor-jump-to-definition-other-window)
  (defun flow-minor-eldoc-sentinel (process _event)
    (when (eq (process-status process) 'exit)
      (if (eq (process-exit-status process) 0)
          (with-current-buffer "*Flow Eldoc*"
            (let ((message (if (string-equal (s-trim-right (buffer-string)) "(unknown)")
                               "(unknown)"
                             (goto-char (point-max))
                             (forward-line -1)
                             (delete-region (point) (point-max))
                             (flow-minor-colorize-buffer)
                             (buffer-substring (point-min) (- (point-max) 1)))))
              (eldoc-message message)))))))

(after! js2-mode
  (add-hook 'js2-mode-hook #'(lambda ()
                               (setq js2-mode-show-parse-errors nil)
                               (setq js2-mode-show-strict-warnings nil)
                               (setq next-error-function nil)
                               (prettier-js-mode 1)
                               (flow-js2-mode 1)
                               (flow-minor-mode 1))))

(after! flycheck
  ;; (require 'flycheck-google-cpplint)
  ;; (flycheck-add-next-checker 'c/c++-cppcheck 'c/c++-googlelint)
  (require 'flycheck-flow)
  (flycheck-add-next-checker 'javascript-flow 'javascript-eslint)
  (defun flycheck-flow-tag-present-p ()
    (string-match-p "^\\(//+\\|[/ ]\\**\\)[@a-zA-Z ]*@flow"
                    (buffer-substring-no-properties (point-min) (point-max))))
  (dolist (mode '(web-mode react-mode))
    (flycheck-add-mode 'javascript-flow mode)
    (flycheck-add-mode 'javascript-flow-coverage mode)))

(after! typescript-mode
  (add-hook 'typescript-mode-hook 'prettier-js-mode)
  ;; (spacemacs/set-leader-keys-for-major-mode 'typescript-mode
  ;;                                           "," 'prettier-js
  ;;                                           "f" 'tide-jump-to-definition
  ;;                                           "d" 'tide-documentation-at-point)
  (after! tide
    (flycheck-add-next-checker 'typescript-tide 'javascript-eslint)))

;; (after! projectile
;;   (defun tk/find-file-in-project-from-kill ()
;;     (interactive)
;;     (let* ((data (split-string (current-kill 0) ":" t))
;;            (file (projectile-expand-root (replace-regexp-in-string "\\\\" "/" (car data))))
;;            (line (if (cdr data) (string-to-number (cadr data))))
;;            (column (if (cddr data) (string-to-number (caddr data)))))
;;       (if (not (file-readable-p file))
;;           (error (concat "File '" file "' not found"))
;;         (find-file file)
;;         (if line (goto-line line))
;;         (if column (move-to-column (- column 1))))))
;;   (defun tk/projectile-buffer-file-name ()
;;     (s-chop-prefix (projectile-project-root) (buffer-file-name)))
;;   (defun tk/projectile-header-guard ()
;;     (concat (replace-regexp-in-string "[/\.]" "_" (upcase (tk/projectile-buffer-file-name))) "_"))
;;   (defun tk/projectile-show-and-copy-buffer-filename ()
;;     "Show the path to the current file from project root in the minibuffer."
;;     (interactive)
;;     (let ((file-name (tk/projectile-buffer-file-name)))
;;       (if file-name
;;           (progn
;;             (message file-name)
;;             (kill-new file-name))
;;         (error "Buffer not visiting a file"))))
;;   (defun tk/show-and-copy-buffer-basename-and-line ()
;;     "Show the path to the current file from project root in the minibuffer."
;;     (interactive)
;;     (let ((file-name (file-name-nondirectory (buffer-file-name))))
;;       (if file-name
;;           (progn
;;             (setq file-name (concat file-name ":" (int-to-string (line-number-at-pos))))
;;             (message file-name)
;;             (kill-new file-name))
;;         (error "Buffer not visiting a file"))))
;;   (setq projectile-mode-line '(:eval (format " [%s]" (projectile-project-name))))
;;   (spacemacs/set-leader-keys
;;    "pg" 'projectile-find-file-dwim
;;    "pG" 'projectile-find-file-dwim-other-window
;;    "pA" 'projectile-find-implementation-or-test-other-window
;;    "pw" 'tk/find-file-in-project-from-kill
;;    "py" 'tk/projectile-show-and-copy-buffer-filename
;;    "p C-g" nil
;;    "\"" 'spacemacs/projectile-shell-pop)
;;   (spacemacs/set-leader-keys-for-major-mode 'c++-mode
;;                                             "y" 'tk/show-and-copy-buffer-basename-and-line))

(evil-define-text-object evil-a-defun (count &optional beg end type)
  "Select a defun."
  (evil-select-an-object 'evil-defun beg end type count t))

(evil-define-text-object evil-inner-defun (count &optional beg end type)
  "Select inner defun."
  (evil-select-inner-object 'evil-defun beg end type count t))

(defun evil-defun/init-evil-defun ()
  (use-package evil-defun
    :commands (evil-inner-defun
               evil-a-defun)
    :init
    (progn
      (define-key evil-outer-text-objects-map (kbd "d") 'evil-a-defun)
      (define-key evil-inner-text-objects-map (kbd "d") 'evil-inner-defun))))


;; (use-package! evil-little-word
;;   :commands (evil-forward-little-word-begin
;;              evil-backward-little-word-begin
;;              evil-forward-little-word-end
;;              evil-backward-little-word-end
;;              evil-a-little-word
;;              evil-inner-little-word)
;;   :init
;;   (map! (:m "glw" #'evil-forward-little
;;          :m "glw" #'evil-forward-little-word-begin
;;          :m "glb" #'evil-backward-little-word-begin
;;          :m "glW" #'evil-forward-little-word-end
;;          :m "glB" #'evil-backward-little-word-end)
;;         (:map evil-outer-text-objects-map "lw" #'evil-a-little-word)
;;         (:map evil-inner-text-objects-map "lw" #'evil-inner-little-word)))

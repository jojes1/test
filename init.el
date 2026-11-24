;; =================================================================
;; DOOM-THEMES
;; =================================================================
;; https://github.com/doomemacs/themes

(add-to-list 'load-path "~/.emacs.d/plugins/doom-themes")
(add-to-list 'custom-theme-load-path "~/.emacs.d/plugins/doom-themes/themes")
(require 'doom-themes)
(load-theme 'doom-gruvbox t)

;; =================================================================
;; COMPAT
;; =================================================================
;; https://github.com/emacs-compat/compat

(add-to-list 'load-path "~/.emacs.d/plugins/compat")
(require 'compat)

;; =================================================================
;; ORDERLESS
;; =================================================================
;; https://github.com/oantolin/orderless

;; Load Orderless
(add-to-list 'load-path "~/.emacs.d/plugins/orderless")
(require 'orderless)

;; Set Orderless as the primary completion style
(setq completion-styles '(orderless basic))
(setq completion-category-defaults nil)
(setq completion-category-overrides '((file (styles partial-completion))))

(setq read-file-name-completion-ignore-case t)
(setq read-buffer-completion-ignore-case t)
(setq completion-ignore-case t)

;; =================================================================
;; VERTICO
;; Is dempendent of COMPAT which must be add to load path before.
;; =================================================================
;; https://github.com/minad/vertico

(add-to-list 'load-path "~/.emacs.d/plugins/vertico")
(add-to-list 'load-path "~/.emacs.d/plugins/vertico/extensions")

;; Load and enable Vertico
(require 'vertico)
(vertico-mode 1)

;; Register the Info manual
(with-eval-after-load 'info
  (info-initialize)
  (add-to-list 'Info-directory-list "~/.emacs.d/plugins/vertico"))

(defun vertico-manual ()
  "Open the Vertico README manual."
  (interactive)
  (find-file-read-only "~/.emacs.d/plugins/vertico/README.org"))

;; =================================================================
;; GOTO-CHG
;; =================================================================
;; https://github.com/emacs-evil/goto-chg

(add-to-list 'load-path "~/.emacs.d/plugins/goto-chg")

;; =================================================================
;; UNDO-FU
;; =================================================================
;; https://github.com/emacsmirror/undo-fu

(add-to-list 'load-path "~/.emacs.d/plugins/undo-fu")

;; =================================================================
;; EVIL-COLLECTION
;; =================================================================
;; https://github.com/emacs-evil/evil-collection

(add-to-list 'load-path "~/.emacs.d/plugins/evil-collection")

;; =================================================================
;; EVIL-ESCAPE
;; =================================================================
;; https://github.com/syl20bnr/evil-escape

(add-to-list 'load-path "~/.emacs.d/plugins/evil-escape")

;; =================================================================
;; EVIL
;; Is dempendent of GOTO-CHG which must be add to load path before.
;; Is dempendent of UNDO-FU which must be add to load path before.
;; Is dempendent of EVIL-COLLECTION which must be add to load path before.
;; =================================================================
;; https://github.com/emacs-evil/evil

(add-to-list 'load-path "~/.emacs.d/plugins/evil")
(setq evil-want-integration t)
(setq evil-search-module 'evil-search)
(setq evil-want-keybinding nil)
(setq evil-undo-system 'undo-fu)
;; Load and enable Evil mode
(require 'undo-fu)
(require 'evil)
(global-set-key (kbd "<escape>") #'keyboard-escape-quit)
(evil-mode 1)
(with-eval-after-load 'evil
  (require 'evil-collection)
  (evil-collection-init)
  (define-key evil-normal-state-map (kbd "<leader>f") #'find-file)
  (define-key evil-visual-state-map (kbd "<leader>f") #'find-file)
  (define-key evil-motion-state-map (kbd "<leader>f") #'find-file)
  (require 'evil-escape)
  (setq-default evil-escape-key-sequence "jk")
  (setq-default evil-escape-delay 0.2) ;; Seconds allowed between 'j' and 'k'
  (evil-escape-mode 1))

;; =================================================================
;; EMBARK
;; =================================================================
;; https://github.com/oantolin/embark

(add-to-list 'load-path "~/.emacs.d/plugins/embark")
(autoload 'embark-act "embark" nil t)
(autoload 'embark-dwim "embark" nil t)
(autoload 'embark-export "embark" nil t)

(autoload 'consult-preview-at-point-mode "consult" nil t)
(add-hook 'embark-collect-mode-hook #'consult-preview-at-point-mode)
(with-eval-after-load 'consult
  (with-eval-after-load 'embark
    (require 'embark-consult)))

(global-set-key (kbd "<leader>a") #'embark-act)
(define-key minibuffer-local-map (kbd "C-c C-e") #'embark-export)
(define-key minibuffer-local-map (kbd "M-RET") #'embark-dwim)

;; =================================================================
;; EMACS-WGREP
;; =================================================================
;; https://github.com/mhayashi1120/Emacs-wgrep

(add-to-list 'load-path "~/.emacs.d/plugins/Emacs-wgrep")

(with-eval-after-load 'grep
  (require 'wgrep))

;; =================================================================
;; EMACS-NEOTREE
;; =================================================================
;; https://github.com/jaypei/emacs-neotree

(add-to-list 'load-path "~/.emacs.d/plugins/emacs-neotree")

(require 'neotree)
(setq neo-smart-open t)

(defun my/neotree-project-root ()
  "Return the current project root directory, or `default-directory'."
  (let ((proj (and (fboundp 'project-current) (project-current))))
    (cond
     ((and proj (fboundp 'project-root)) (project-root proj))
     ((and proj (fboundp 'project-roots)) (car (project-roots proj)))
     ((vc-root-dir))
     (t default-directory))))
	 
(defun my/neotree-open-project-root ()
  "Open NeoTree rooted at the current project directory."
  (interactive)
  (let ((root (my/neotree-project-root))
        (current-file (buffer-file-name)))
    (neotree-dir root)
    (when current-file
      (neotree-find current-file))))
	  
(defun my/neotree-toggle-project-root ()
  "Toggle NeoTree at the current project root."
  (interactive)
  (if (and (fboundp 'neo-global--window-exists-p)
           (neo-global--window-exists-p))
      (neotree-hide)
    (my/neotree-open-project-root)))
	
(defun my/neo-open-file-window-picker (full-path &optional _arg)
  "Open FULL-PATH, prompting to pick a window if more than one exists."
  (let ((neo-win (neo-global--get-window))
        wins)
    (dolist (w (window-list nil 'no-mini))
      (unless (eq w neo-win)
        (push w wins)))
    (setq wins (nreverse wins))
    (cond
     ((= (length wins) 0)
      (select-window (split-window-right))
      (find-file full-path))
     ((= (length wins) 1)
      (select-window (car wins))
      (find-file full-path))
     (t
      (let (overlays choices)
        (unwind-protect
            (progn
              (dotimes (i (min (length wins) 9))
                (let* ((w (nth i wins))
                       (num (+ i 1))
                       (ov (make-overlay (window-start w) (window-start w) (window-buffer w))))
                  (overlay-put ov 'window w)
                  (overlay-put ov 'before-string
                               (propertize (format " [%d] " num)
                                           'face '(:background "#ffcc00"
                                                   :foreground "#000000"
                                                   :weight bold)))
                  (push ov overlays)
                  (push (+ ?0 num) choices)))
              (let* ((key (read-char-choice
                           (format "Select window (1-%d): " (length choices))
                           (nreverse choices)))
                     (target-win (nth (- key ?1) wins)))
                (select-window target-win)
                (find-file full-path)))
          (mapc #'delete-overlay overlays)))))))

(define-key neotree-mode-map (kbd "RET")
  (neotree-make-executor :file-fn #'my/neo-open-file-window-picker
                         :dir-fn #'neo-open-dir))
						 
(global-set-key [f8] #'my/neotree-toggle-project-root)
;;(add-hook 'emacs-startup-hook #'my/neotree-open-project-root)

(evil-define-key '(normal motion) 'global
  (kbd "<leader>ee") #'my/neotree-toggle-project-root)

;; (evil-define-key '(normal motion) neotree-mode-map
;;   (kbd "RET") nil
;;   (kbd "l") (neotree-make-executor :file-fn #'my/neo-open-file-window-picker
;;                                    :dir-fn #'neo-open-dir))

(evil-define-key '(normal motion) neotree-mode-map
  (kbd "RET") nil
  (kbd "l") (neotree-make-executor :file-fn #'my/neo-open-file-window-picker
                                   :dir-fn #'neo-open-dir)
  (kbd "a") #'neotree-create-node)


(setq neo-window-fixed-size nil)

;; Automatically resize NeoTree width to fit the longest visible line
(defun my/neotree-fit-window-width (&rest _)
  "Adjust the NeoTree window width to show the longest visible line."
  (when-let ((win (and (fboundp 'neo-global--get-window)
                       (neo-global--get-window))))
    (with-selected-window win
      (let ((max-width 25) ; Minimum width in columns
            (padding 4))   ; Extra space for icons/margins
        (save-excursion
          (goto-char (point-min))
          (while (not (eobp))
            (setq max-width (max max-width (+ (current-column)
                                              (- (line-end-position) (line-beginning-position)))))
            (forward-line 1)))
        (let* ((target-width (min (+ max-width padding) (/ (frame-width) 2)))
               (delta (- target-width (window-width win))))
          (unless (zerop delta)
            (window-resize win delta t)))))))

;; Resize when NeoTree opens or refreshes (e.g., when expanding directories)
(advice-add 'neo-buffer--refresh :after #'my/neotree-fit-window-width)

;; =================================================================
;; CONSULT
;; =================================================================
;; https://github.com/minad/consult

(add-to-list 'load-path "~/.emacs.d/plugins/consult")
(require 'consult)

;; =================================================================
;; WHICH-KEY
;; =================================================================

(require 'which-key)
(which-key-mode 1)

;; Show the hint quickly after pressing the leader key.
(setq which-key-idle-delay 0.2)

(setq which-key-side-window-location 'right)
(setq which-key-max-description-length nil)  ; no truncation
(setq which-key-side-window-max-width 0.85)  ;; default 0.333 of frame width
(setq which-key-side-window-slot 0)         ;; 0 = middle slot

;; When in which-key the following can be done
;; Other keys in that same C-h menu:

;; Key	Action
;; u	undo one key (go back one prefix level)
;; n / p	next / previous page
;; a	abort the whole sequence
;; d	toggle docstrings
;; C-h	show the help list

(require 'seq)

(defvar my/which-key-priority
  '(
    "prefix"
    ;; +NeoTree e
    "my/neotree-toggle-project-root" ;; ee
    ;; +Search s
    "consult-ripgrep" ;; st
    ;; +Miscellaneous m
    "my/delete-line" ;; md
    ;; +Debug d
    "dap-debug" ;; dd
    "my/dap-quit" ;; dq
    "dap-ui-locals" ;; dl
    "dap-ui-repl" ;; dR
    "dap-eval-thing-at-point" ;; de
    "dap-breakpoint-toggle" ;; db
    "dap-next" ;; dn
    "dap-step-in" ;; ds
    "dap-step-out" ;; do
    "dap-continue" ;; dc
    "dap-debug-restart" ;; dr
    ;; +Tabs t
    "tab-next" ;; tn
    "tab-previous" ;; tp
    "tab-new" ;; tt
    "tab-close" ;; tc
    "tab-rename" ;; tr
    "project-switch-project" ;; ts
    ;; +Git g
    "magit-dispatch" ;; gg
    "magit-status" ;; gs
    "magit-diff-dwim" ;; gd
    "magit-log-current" ;; gl
    "magit-blame-addition" ;; gb
    "my/git-create-bare-remote" ;; gB
    "magit-commit" ;; gc
    "magit-push" ;; gp
    "magit-pull" ;; gP
    ;; --------------------
    "project-find-file" ;; p
    "find-file" ;; f
    "embark-act" ;; a
    "evil-window-split" ;; h
    "evil-window-vsplit" ;; v
    ))

(defun my/which-key-sort (a b)
  "Sort by `my/which-key-priority', then by description."
  (let ((ra (or (seq-position my/which-key-priority (cdr a)) 100))
        (rb (or (seq-position my/which-key-priority (cdr b)) 100)))
    (if (= ra rb)
        (which-key-description-order a b)
      (< ra rb))))

(setq which-key-sort-order #'my/which-key-sort)


(setq which-key-separator " → ")   ;; default " : "
(setq which-key-prefix-prefix "")  ;; default "+" marker before prefix groups

(with-eval-after-load 'which-key
  (which-key-add-key-based-replacements
    "<leader> e" '("Neotree" . "Neotree commands")
    "<leader> s" '("Search"  . "Search commands")
    "<leader> m" '("Miscellaneous"  . "Miscellaneous commands")
    "<leader> d" '("Debug"  . "Debug commands")
    "<leader> t" '("Tabs" . "Tab commands")
    "<leader> g" '("Git" . "Git commands")
    "SPC e"      '("+Neotree" . "Neotree commands")
    "SPC s"      '("+Search"  . "Search commands")
    "SPC m"      '("+Miscellaneous"  . "Miscellaneous commands")
    "SPC d"      '("+Debug"  . "Debug commands")
    "SPC t"      '("+Tabs" . "Tab commands")
    "SPC g"      '("+Git" . "Git commands")))

(defvar my/which-key-prefix-order
  '("SPC e" "SPC s" "SPC m" "SPC d" "SPC t"))

(defun my/which-key-sort (a b)
  "Sort prefix groups by `my/which-key-prefix-order', then commands by priority."
  (let* ((desc-a (cdr a))
         (desc-b (cdr b))
         (group-a (string= desc-a "prefix"))
         (group-b (string= desc-b "prefix"))
         ;; Unlisted groups go before the listed ones, so SPC t stays last.
         (pa (and group-a
                  (or (seq-position my/which-key-prefix-order (car a)) -1)))
         (pb (and group-b
                  (or (seq-position my/which-key-prefix-order (car b)) -1)))
         (ra (or (seq-position my/which-key-priority desc-a) 100))
         (rb (or (seq-position my/which-key-priority desc-b) 100)))
    (cond
     ((and pa pb) (< pa pb))
     (pa t)          ; group a before command b
     (pb nil)        ; command a after group b
     ((/= ra rb) (< ra rb))
     (t (which-key-description-order a b)))))

(setq which-key-sort-order #'my/which-key-sort)

;; +NeoTree e
(add-to-list 'which-key-replacement-alist
             '((nil . "my/neotree-toggle-project-root") . (nil . "Toggle file tree")))

;; +Search s
;; Rename one command's description.
(add-to-list 'which-key-replacement-alist
             '((nil . "consult-ripgrep") . (nil . "Search text")))

;; +Miscellaneous m
;; Verified against your config: <leader>d now reads "Delete row".
(add-to-list 'which-key-replacement-alist
             '((nil . "my/delete-line") . (nil . "Delete row")))

;; +Debug d
(add-to-list 'which-key-replacement-alist ;; dd
             '((nil . "dap-debug") . (nil . "Start debug")))

(add-to-list 'which-key-replacement-alist ;; dq
             '((nil . "my/dap-quit") . (nil . "Quit debug")))

(add-to-list 'which-key-replacement-alist ;; dl
             '((nil . "dap-ui-locals") . (nil . "Show locals panel")))

(add-to-list 'which-key-replacement-alist ;; dR
             '((nil . "dap-ui-repl") . (nil . "UI repl")))

(add-to-list 'which-key-replacement-alist ;; de
             '((nil . "dap-eval-thing-at-point") . (nil . "Hover value")))

(add-to-list 'which-key-replacement-alist ;; db
             '((nil . "dap-breakpoint-toggle") . (nil . "Toggle breakpoint")))

(add-to-list 'which-key-replacement-alist ;; dn
             '((nil . "dap-next") . (nil . "Next")))

(add-to-list 'which-key-replacement-alist ;; ds
             '((nil . "dap-step-in") . (nil . "Step in")))

(add-to-list 'which-key-replacement-alist ;; do
             '((nil . "dap-step-out") . (nil . "Step out")))

(add-to-list 'which-key-replacement-alist ;; dc
             '((nil . "dap-continue") . (nil . "Continue")))

(add-to-list 'which-key-replacement-alist ;; dr
             '((nil . "dap-debug-restart") . (nil . "Restart")))

;; +Tabs t
(add-to-list 'which-key-replacement-alist ;; tn
             '((nil . "tab-next") . (nil . "Next tab")))

(add-to-list 'which-key-replacement-alist ;; tp
             '((nil . "tab-previous") . (nil . "Previous tab")))

(add-to-list 'which-key-replacement-alist ;; tt
             '((nil . "tab-new") . (nil . "New tab")))

(add-to-list 'which-key-replacement-alist ;; tc
             '((nil . "tab-close") . (nil . "Close tab")))

(add-to-list 'which-key-replacement-alist ;; tc
             '((nil . "tab-rename") . (nil . "Rename tab")))

(add-to-list 'which-key-replacement-alist ;; ts
             '((nil . "project-switch-project") . (nil . "Switch project")))

;; +Git g
(add-to-list 'which-key-replacement-alist ;; gg
             '((nil . "magit-dispatch") . (nil . "Dispatch")))

(add-to-list 'which-key-replacement-alist ;; gs
             '((nil . "magit-status") . (nil . "Status")))

(add-to-list 'which-key-replacement-alist ;; gd
             '((nil . "magit-diff-dwim") . (nil . "Diff-dwim")))

(add-to-list 'which-key-replacement-alist ;; gl
             '((nil . "magit-log-current") . (nil . "Log current")))

(add-to-list 'which-key-replacement-alist ;; gb
             '((nil . "magit-blame-addition") . (nil . "Blame addition")))

(add-to-list 'which-key-replacement-alist ;; gB
             '((nil . "my/git-create-bare-remote") . (nil . "Create remote repo from local")))

(add-to-list 'which-key-replacement-alist ;; gc
             '((nil . "magit-commit") . (nil . "Commit")))

(add-to-list 'which-key-replacement-alist ;; gp
             '((nil . "magit-push") . (nil . "Push")))

(add-to-list 'which-key-replacement-alist ;; gP
             '((nil . "magit-pull") . (nil . "Pull")))

;; First level
;; Match key AND description for precision.
(add-to-list 'which-key-replacement-alist ;; f
             '((nil . "find-file") . (nil . "Project dir")))

(add-to-list 'which-key-replacement-alist ;; p
             '((nil . "project-find-file") . (nil . "Find file")))

(add-to-list 'which-key-replacement-alist ;; a
             '((nil . "embark-act") . (nil . "Embark actions")))

(add-to-list 'which-key-replacement-alist ;; h
             '((nil . "evil-window-split") . (nil . "Horizontal split")))

(add-to-list 'which-key-replacement-alist ;; v
             '((nil . "evil-window-vsplit") . (nil . "Vertical split")))

;; =================================================================
;; DAP-DEBUG PLUGINS START
;; =================================================================

;; https://github.com/emacs-lsp/dap-mode
(add-to-list 'load-path "~/.emacs.d/plugins/dap-mode")

;; https://github.com/emacs-lsp/lsp-mode
(add-to-list 'load-path "~/.emacs.d/plugins/lsp-mode")

;; https://github.com/magnars/dash.el
(add-to-list 'load-path "~/.emacs.d/plugins/dash.el")

;; https://github.com/rejeep/f.el
(add-to-list 'load-path "~/.emacs.d/plugins/f.el")

;; https://github.com/magnars/s.el
(add-to-list 'load-path "~/.emacs.d/plugins/s.el")

;; https://github.com/Wilfred/ht.el
(add-to-list 'load-path "~/.emacs.d/plugins/ht.el")

;; https://github.com/alezost/bui.el
(add-to-list 'load-path "~/.emacs.d/plugins/bui.el")

;; https://github.com/abo-abo/hydra
(add-to-list 'load-path "~/.emacs.d/plugins/hydra")

;; https://github.com/jrblevin/markdown-mode
(add-to-list 'load-path "~/.emacs.d/plugins/markdown-mode")

;; https://github.com/Malabarba/spinner.el
(add-to-list 'load-path "~/.emacs.d/plugins/spinner.el")

;; https://github.com/emacs-lsp/lsp-treemacs
(add-to-list 'load-path "~/.emacs.d/plugins/lsp-treemacs")

;; https://github.com/tumashu/posframe
(add-to-list 'load-path "~/.emacs.d/plugins/posframe")

;; https://github.com/emacs-lsp/lsp-docker
(add-to-list 'load-path "~/.emacs.d/plugins/lsp-docker")

;; https://github.com/zkry/yaml.el
(add-to-list 'load-path "~/.emacs.d/plugins/yaml.el")

;; https://github.com/Alexander-Miller/treemacs
(add-to-list 'load-path "~/.emacs.d/plugins/treemacs/src/elisp")  ; if that's the layout

;; https://github.com/Alexander-Miller/pfuture
(add-to-list 'load-path "~/.emacs.d/plugins/pfuture")

(require 'dap-mode)
(require 'dap-gdb)
(require 'dap-ui)
(require 'dap-mouse)

(dap-mode 1)
(dap-ui-mode 1)
(dap-tooltip-mode 1)
(tooltip-mode 1)
(dap-ui-many-windows-mode 1)
(setq dap-auto-configure-features '(sessions locals controls tooltip))

(setq dap-gdb-debug-program '("c:/mingw64/bin/gdb" "-i" "dap"))
(setq dap-print-io t)

;; Let dap-mode read .vscode/launch.json without per-project .dir-locals eval.
(require 'subr-x)

(defun my/dap-project-root (dir)
  "Return project root for DIR, using project.el or .dir-locals.el as marker."
  (or (when-let ((p (project-current nil dir)))
        (cdr p))
      (locate-dominating-file dir ".dir-locals.el")))

(with-eval-after-load 'dap-launch
  (defun my/dap-launch-find-launch-json ()
    (when-let ((root (my/dap-project-root default-directory)))
      (require 'dap-variables)
      (dap-variables-find-vscode-config "launch.json" root)))
  (advice-add 'dap-launch-find-launch-json :override #'my/dap-launch-find-launch-json))

(with-eval-after-load 'dap-variables
  (setq dap-variables-project-root-function
        (lambda ()
          (directory-file-name (my/dap-project-root default-directory)))))

;;(lsp-workspace-folders-add "C:/user/cpp/calculator")

;; (dap-register-debug-template
;;  "Calculator::Debug"
;;  (list :type "gdb"
;;        :request "launch"
;;        :name "Calculator::Debug"
;;        :program "C:/user/cpp/calculator/build/debug/calculator.exe"
;;        :cwd "C:/user/cpp/calculator/build/debug"
;;        :args ""
;;        :stopAtBeginningOfMainSubprogram t
;;        :valuesFormatting "prettyPrinters"))

;; (dap-register-debug-template
;;  "Calculator Test::Debug"
;;  (list :type "gdb"
;;        :request "launch"
;;        :name "Calculator Test::Debug"
;;        :program "C:/user/cpp/calculator/build/debug/tests/calculator_tests.exe"
;;        :cwd "C:/user/cpp/calculator/build/debug/tests"
;;        :args ""
;;        :stopAtBeginningOfMainSubprogram t
;;        :valuesFormatting "prettyPrinters"))


(defun my/dap-ui-render-value (debug-session expression value variables-reference)
  "Like `dap-ui-render-value', but print EXPRESSION before VALUE."
  (lsp-treemacs-render
   `((:key ,expression
           :label ,(concat (propertize expression
                                       'face 'font-lock-variable-name-face)
                           ": "
                           value)
           :icon dap-field
           ,@(unless (zerop variables-reference)
               (list :children
                     (-partial #'dap-ui-render-variables
                               debug-session variables-reference nil nil)))))
   "" nil (buffer-name)))

(advice-add 'dap-ui-render-value :override #'my/dap-ui-render-value)

(defun my/dap-quit ()
  "Disconnect DAP, close all debug windows, and restore the source window."
  (interactive)
  ;; End every running debug session.
  (dolist (session (dap--get-sessions))
    (when (dap--session-running session)
      (dap-disconnect session)))

  ;; Close the auto-configured DAP windows.
  (when (fboundp 'dap-ui-hide-many-windows)
    (dap-ui-hide-many-windows))

  ;; Kill any DAP UI buffers still hanging around.
  (dolist (buf (buffer-list))
    (when (string-match-p "^\\*dap\\|^\\*debug-window" (buffer-name buf))
      (kill-buffer buf)))

  ;; Go back to a real file buffer and make it the only window.
  (let ((src (cl-find-if
              (lambda (w)
                (and (window-live-p w)
                     (buffer-file-name (window-buffer w))))
              (window-list))))
    (when src (select-window src))
    (delete-other-windows)))

;; =================================================================
;; DAP-DEBUG PLUGINS END
;; =================================================================

;; =================================================================
;; MAGIT PLUGINS START
;; =================================================================
;; https://github.com/tarsius/llama
(add-to-list 'load-path "~/.emacs.d/plugins/llama")
;; https://github.com/tarsius/cond-let
(add-to-list 'load-path "~/.emacs.d/plugins/cond-let")
;; https://github.com/magit/with-editor
(add-to-list 'load-path "~/.emacs.d/plugins/with-editor/lisp")
;; https://github.com/magit/transient
(add-to-list 'load-path "~/.emacs.d/plugins/transient/lisp")
;; https://github.com/magit/magit (also contains magit-section.el in lisp/)
(add-to-list 'load-path "~/.emacs.d/plugins/magit/lisp")

;; GitHub checkouts have no autoloads, so load Magit explicitly.
(require 'magit)

(evil-define-key 'normal 'global (kbd "<leader>gg") #'magit-dispatch)
(evil-define-key 'normal 'global (kbd "<leader>gs") #'magit-status)
(evil-define-key 'normal 'global (kbd "<leader>gd") #'magit-diff-dwim)
(evil-define-key 'normal 'global (kbd "<leader>gl") #'magit-log-current)
(evil-define-key 'normal 'global (kbd "<leader>gb") #'magit-blame-addition)
(evil-define-key 'normal 'global (kbd "<leader>gc") #'magit-commit)
(evil-define-key 'normal 'global (kbd "<leader>gp") #'magit-push)
(evil-define-key 'normal 'global (kbd "<leader>gP") #'magit-pull)

(defun my/git--call (dir program &rest args)
  "Run PROGRAM with ARGS in DIR.  Signal an error if it fails."
  (let ((default-directory dir))
    (with-temp-buffer
      (unless (zerop (apply #'call-process program nil t nil args))
        (user-error "%s failed: %s" program (buffer-string))))))

(defun my/git--forward-slashes (path)
  "Return PATH with forward slashes, as Git on Windows prefers."
  (subst-char-in-string ?\\ ?/ (expand-file-name path)))

(defun my/git-create-bare-remote (bare-dir remote-name &optional push)
  "Create a bare Git repo from the current repository and add it as a remote.

BARE-DIR is where the new bare repository is created.
REMOTE-NAME is the remote added to the current repository.
With a prefix argument PUSH, also push all branches and tags."
  (interactive
   (let* ((root (or (magit-toplevel)
                    (user-error "Not inside a Git repository")))
          (name (file-name-nondirectory (directory-file-name root)))
          ;; <repo>/../remote/
          (remote-dir (expand-file-name
                       "remote"
                       (file-name-directory (directory-file-name root))))
          ;; <repo>/../remote/<repo>.git
          (default (expand-file-name (concat name ".git") remote-dir)))
     (list (read-directory-name "Bare repository: " default)
           (read-string "Remote name: " "origin")
           current-prefix-arg)))
  (let* ((root (or (magit-toplevel)
                   (user-error "Not inside a Git repository")))
         (bare-abs (expand-file-name bare-dir))
         (bare (my/git--forward-slashes bare-abs))
         (src (my/git--forward-slashes root)))
    (when (file-exists-p bare-abs)
      (user-error "Path already exists: %s" bare-abs))
    (make-directory (file-name-directory bare-abs) t)
    ;; Copy all local refs into the new bare repository.
    (my/git--call default-directory "git" "clone" "--bare" src bare)
    ;; Add the remote, or update its URL if it already exists.
    (let ((exists (with-temp-buffer
                    (zerop (call-process "git" nil t nil
                                         "remote" "get-url" remote-name)))))
      (my/git--call root "git" "remote"
                    (if exists "set-url" "add") remote-name bare)
      (when push
        (my/git--call root "git" "push" "-u" remote-name "--all")
        (my/git--call root "git" "push" remote-name "--tags")))
    (message "Created bare repo %s and configured remote %s"
             bare remote-name)))

(evil-define-key 'normal 'global (kbd "<leader>gB")
  #'my/git-create-bare-remote)

;; (with-eval-after-load 'which-key
;;   (add-to-list 'which-key-replacement-alist
;;                '((nil . "my/git-create-bare-remote")
;;                  . (nil . "Create bare remote"))))

;; =================================================================
;; MAGIT PLUGINS END
;; =================================================================

;; =================================================================
;; GENERAL SETTINGS
;; =================================================================

;; Set Space as the leader key in normal and motion states
(evil-set-leader '(normal motion) (kbd "SPC"))

;; Set Space as the local leader for mode-specific bindings
(evil-set-leader 'normal (kbd "SPC") t)

;; Disable the welcome splash screen
(setq inhibit-startup-screen t)

;; Clear the default comment text inside the *scratch* buffer
(setq initial-scratch-message nil)

;; Stop creating backup~ files
(setq make-backup-files nil)

;; Stop creating #autosave# files
(setq auto-save-default nil)

;; Stop creating .#lockfiles
(setq create-lockfiles nil)

(setq frame-title-format "🌴 %b")

;; Set the frame title format with a palm tree emoji
;; frame-title-format (list "🌴 %b")

;; Disable the menu bar
(menu-bar-mode -1)

;; Disable the tool bar
(tool-bar-mode -1)

;; Disable the scroll bar
(scroll-bar-mode -1)

;; Enable line numbers
(global-display-line-numbers-mode 1)

;; (setq jit-lock-stealth-time 1)

;; Set Dired listing switches for more minimalist output
(setq dired-listing-switches "-laghov --group-directories-first")

(setq default-directory "~/.emacs.d")
;;(setq command-line-default-directory "~/.emacs.d")

;; Enable native pixel-based scrolling
(pixel-scroll-precision-mode 1)

;; Optional: Smoothly interpolate PgUp and PgDown scrolling
(setq pixel-scroll-precision-interpolate-page t)

;; Scroll one line at a time instead of jumping half a screen
(setq scroll-conservatively 101)

;; Keep a 5-line buffer margin at the top and bottom of the screen
(setq scroll-margin 0)

;; Prevent erratic jumps when scrolling past tall lines or images
(setq auto-window-vscroll nil)

;; (setq electric-pair-pairs '((?\< . ?\>)))

;; Auto-close (), [], {}, quotes, etc.
(electric-pair-mode 1)

;; To close menus, prompts, or popups in Emacs with a single press of the Escape key
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

;; Disable sound
(setq ring-bell-function 'ignore)

(setq-default truncate-lines t)

;; Set font
;; (set-face-attribute 'default nil :font "DejaVu Sans Mono" :height 120)
(set-face-attribute 'default nil :font "FiraCode Nerd Font Mono" :height 120)

(setq completion-styles '(basic partial-completion flex))

(add-to-list 'auto-mode-alist '("\\.grep\\'" . grep-mode))

;; Automatically focus the new window when splitting horizontally (opens below)
(setq evil-split-window-below t)

;; Automatically focus the new window when splitting vertically (opens to the right)
(setq evil-vsplit-window-right t)

;; 1. Start Eglot automatically in C++ buffers
(add-hook 'c++-mode-hook #'eglot-ensure)
(add-hook 'c++-ts-mode-hook #'eglot-ensure) ; If using Tree-sitter
;;(add-hook 'c++-mode-hook #'font-lock-ensure)
;;(add-hook 'c++-ts-mode-hook #'font-lock-ensure)

;; 2. Bind gd to xref-find-definitions (which Eglot powers)
(with-eval-after-load 'evil
  (define-key evil-normal-state-map (kbd "gd") #'xref-find-definitions))

;; NOTE! Do the following manually:
;; M-x treesit-install-language-grammar RET cpp RET
;; M-x treesit-install-language-grammar RET c RET

(setq treesit-language-source-alist
      '((c "https://github.com/tree-sitter/tree-sitter-c" "v0.23.6")
        (cpp "https://github.com/tree-sitter/tree-sitter-cpp" "v0.23.4")))

(setq treesit-font-lock-level 4)

(add-to-list 'major-mode-remap-alist '(c++-mode . c++-ts-mode))
(add-to-list 'major-mode-remap-alist '(c-mode . c-ts-mode))

(require 'cl-lib)

(defvar my/mx-prefill-region nil
  "Region of the prefilled M-x text, to delete on first typing.")

(defun my/mx--clear-prefill ()
  "Delete prefilled M-x text just before the first self-insert command."
  (when (and my/mx-prefill-region
             (eq this-command 'self-insert-command))
    (pcase-let ((`(,beg . ,end) my/mx-prefill-region))
      (when (and (integerp beg) (integerp end)
                 (<= beg end) (<= end (point-max)))
        (delete-region beg end)))
    (setq my/mx-prefill-region nil)
    (remove-hook 'pre-command-hook #'my/mx--clear-prefill t)))

(defun my/mx-prefill-last-command (orig prompt initial-input)
  (let* ((last (car extended-command-history))
         (input (or initial-input last))
         (prefill (and (null initial-input)
                       (stringp last) (> (length last) 0))))
    (minibuffer-with-setup-hook
        (lambda ()
          (when prefill
            (let ((beg (minibuffer-prompt-end)))
              (setq my/mx-prefill-region
                    (cons beg (+ beg (length input))))
              (add-hook 'pre-command-hook #'my/mx--clear-prefill nil t))))
      (funcall orig prompt input))))

(defun my/mx-keep-prefill ()
  "Keep the prefilled M-x command so typing appends to it."
  (interactive)
  (setq my/mx-prefill-region nil)
  (remove-hook 'pre-command-hook #'my/mx--clear-prefill t)
  (message "Appending to the prefilled command"))

(define-key read-extended-command-mode-map (kbd "M-a")
            #'my/mx-keep-prefill)

(advice-add 'read-extended-command-1 :around #'my/mx-prefill-last-command)

(setq-default mode-line-format nil)

(defun my/tab-bar-global-status ()
  "Return the current file path or buffer name as a tab-bar item."
  (let ((name (if (buffer-file-name)
                  (abbreviate-file-name (buffer-file-name))
                (buffer-name))))
    `((global-status menu-item ,name ignore))))

;; 2. Tell tab-bar to use this function
(setq tab-bar-show t)
(setq tab-bar-format '(my/tab-bar-global-status))

(tab-bar-mode 1)

(set-face-attribute 'tab-bar nil :foreground "#ffffff" :background "#222222")
(add-to-list 'tab-bar-format 'tab-bar-format-align-right t)

(defvar my/border-color "#ff0000")
(defvar my/border-width 3)

(setq window-divider-default-places t
      window-divider-default-bottom-width my/border-width
      window-divider-default-right-width my/border-width)

(set-face-attribute 'window-divider nil :foreground my/border-color)
(set-face-attribute 'window-divider-first-pixel nil :foreground my/border-color)
(set-face-attribute 'window-divider-last-pixel nil :foreground my/border-color)
(window-divider-mode 1)

(set-face-attribute 'tab-bar nil :box nil :underline nil :overline nil)
(setq-default header-line-format nil)
(dolist (buf (buffer-list))
  (with-current-buffer buf
    (kill-local-variable 'header-line-format)))

(set-face-attribute 'header-line nil
                    :background my/border-color
                    :foreground my/border-color
                    :height (* 1 10)
                    :box nil
                    :underline nil
                    :overline nil)

(defun my/sync-top-window-divider (&rest _)
  "Put a header-line divider on top-edge windows via window parameters."
  (walk-windows
   (lambda (win)
     (set-window-parameter
      win 'header-line-format
      (if (window-in-direction 'above win)
          'none   ;; Explicitly hide header-line if another window is above this one
        " ")))    ;; Show the red bar ONLY if this window touches the tab-bar
   nil t))

(add-hook 'window-state-change-hook #'my/sync-top-window-divider)
(my/sync-top-window-divider)

(let ((bg (face-background 'tab-bar nil t)))
  (set-face-attribute 'tab-bar nil
                      :box `(:line-width (8 . 6) :color ,bg :style nil)))

(setq scroll-margin 0)
(setq auto-window-vscroll nil)

(defun my/tab-bar-buffer-status ()
  "Return active buffer status info formatted for the tab-bar."
  (with-current-buffer (window-buffer (minibuffer-selected-window))
    (let* ((branch (when (and vc-mode (stringp vc-mode))
                     (string-trim vc-mode)))
           (mode (format-mode-line mode-name))
           (pos (format-mode-line " %l:%c ")))
      (concat
       (when branch (format " [%s] " branch))
       (format "(%s)" mode)
       pos))))

;; Add alignment and your custom status function to tab-bar-format
(setq tab-bar-format
      '(tab-bar-format-history
        tab-bar-format-tabs
        tab-bar-separator
        tab-bar-format-add-tab
        tab-bar-format-align-right
        my/tab-bar-buffer-status
        tab-bar-format-global))

;; GDB DEBUG
;; (setq system-uses-terminfo t)
(defun my/gdb-comint-term-environment (orig name buffer command switches)
  "Use terminfo-style TERM/TERMCAP for GDB buffers only."
  (let ((system-uses-terminfo
         (or system-uses-terminfo
             (string-prefix-p "*gud-" (buffer-name buffer)))))
    (funcall orig name buffer command switches)))

(with-eval-after-load 'comint
  (advice-add 'comint-exec-1 :around #'my/gdb-comint-term-environment))

;; Clean GDB setup: only GUD + source
(with-eval-after-load 'gdb-mi
  (setq gdb-many-windows nil)       ; avoid the 6-window layout
  (setq gdb-show-main t)            ; open main.cpp automatically
  (setq gdb-display-io-buffer nil)  ; program output stays in GUD buffer
  (setq gdb-max-source-window-count 1))

(defun my/debug-calculator ()
  (interactive)
  (gdb "gdb -i=mi C:/user/cpp/calculator/build/debug/calculator.exe"))

(setq gdb-restore-window-configuration-after-quit t)

;; =================================================================
;; KEY BINDINGS
;; =================================================================

;; Works for standard minibuffer prompts and M-x
(define-key minibuffer-local-map (kbd "C-l") #'exit-minibuffer)
(define-key minibuffer-local-completion-map (kbd "C-l") #'exit-minibuffer)
(define-key minibuffer-local-must-match-map (kbd "C-l") #'exit-minibuffer)

(evil-define-key 'normal 'global (kbd "<leader>p") 'project-find-file)

(evil-define-key 'normal 'global (kbd "<leader>tn") #'tab-next)
(evil-define-key 'normal 'global (kbd "<leader>tp") #'tab-previous)
(evil-define-key 'normal 'global (kbd "<leader>tt") #'tab-new)
(evil-define-key 'normal 'global (kbd "<leader>tc") #'tab-close)
(evil-define-key 'normal 'global (kbd "<leader>tr") #'tab-rename)
(evil-define-key 'normal 'global (kbd "<leader>ts") #'project-switch-project)

;; (with-eval-after-load 'which-key
;;   (which-key-add-key-based-replacements
;;     "<leader>t" '("Tabs" . "Tab commands")
;;     "SPC t"     '("+Tabs" . "Tab commands")))

(with-eval-after-load 'project
  (add-to-list 'project-vc-ignores "googletest/")
  (add-to-list 'project-vc-ignores ".venv/")
  (add-to-list 'project-vc-ignores ".cache/")
  (add-to-list 'project-vc-ignores "third_party/")
  (add-to-list 'project-vc-ignores "build/")
  (add-to-list 'project-vc-ignores "compile_commands.json"))

(evil-define-key 'normal 'global (kbd "<leader>h") 'evil-window-split)
(evil-define-key 'normal 'global (kbd "<leader>v") 'evil-window-vsplit)

(evil-define-key 'normal 'global (kbd "C-h") 'evil-window-left)
(evil-define-key 'normal 'global (kbd "C-j") 'evil-window-down)
(evil-define-key 'normal 'global (kbd "C-k") 'evil-window-up)
(evil-define-key 'normal 'global (kbd "C-l") 'evil-window-right)

(evil-define-key 'normal 'global (kbd "<leader>st") #'consult-ripgrep)
;;(evil-define-key 'normal 'global (kbd "<leader>st") #'project-find-regexp)

(with-eval-after-load 'consult
  (setq consult-ripgrep-args
        (concat consult-ripgrep-args
			" -g !googletest/"
			" -g !.git/"
			" -g !dist/"
			" -g !third_party/"
			" -g !build/"
			" -g !.cache/"
			" -g !*.txt"
            " -g !*.log"
			" -g !*.grep"
			" -g !*.md"
            " -g !*.json"))
  (add-to-list 'consult-preview-allowed-hooks 'global-display-line-numbers-mode))

(defun my/delete-line ()
  "Delete the current line, unlocking read-only buffers first."
  (interactive)
  (when buffer-read-only
    (read-only-mode -1))
  (kill-whole-line))

(evil-define-key 'normal 'global (kbd "<leader>md") #'my/delete-line)  

(evil-define-key 'normal 'global (kbd "<leader>dd") #'dap-debug)
(evil-define-key 'normal 'global (kbd "<leader>dq") #'my/dap-quit)
;; (which-key-add-key-based-replacements "<leader>dq" "Quit debug")

(evil-define-key 'normal 'global (kbd "<leader>dl") #'dap-ui-locals)
(evil-define-key 'normal 'global (kbd "<leader>dR") #'dap-ui-repl)
(evil-define-key 'normal 'global (kbd "<leader>de") #'dap-eval-thing-at-point)
(evil-define-key 'normal 'global (kbd "<leader>db") #'dap-breakpoint-toggle)
(evil-define-key 'normal 'global (kbd "<leader>dn") #'dap-next)
(evil-define-key 'normal 'global (kbd "<leader>ds") #'dap-step-in)
(evil-define-key 'normal 'global (kbd "<leader>do") #'dap-step-out)
(evil-define-key 'normal 'global (kbd "<leader>dc") #'dap-continue)
(evil-define-key 'normal 'global (kbd "<leader>dr") #'dap-debug-restart)

(with-eval-after-load 'magit
  (evil-define-key* 'normal magit-mode-map (kbd "R") #'magit-refresh))

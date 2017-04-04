;;; package --- my-hacks
;;; Commentary:
;;; this is my hacked up Emacs init script.
;;; Code:




(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(company-backends
   (quote
    (company-bbdb company-nxml company-css company-eclim company-semantic company-clang company-xcode company-cmake company-capf company-files
		  (company-dabbrev-code company-gtags company-etags company-keywords)
		  company-oddmuse company-dabbrev company-jedi)))
;; '(font-use-system-font t)
;; '(inhibit-startup-screen t)
 '(org-agenda-files (quote ("~/org/work.org" "~/org/personal.org"))))
;;(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 ;;)

;; (custom-set-variables
;;  ;; custom-set-variables was added by Custom.
;;  ;; If you edit it by hand, you could mess it up, so be careful.
;;  ;; Your init file should contain only one such instance.
;;  ;; If there is more than one, they won't work right.
;;  ;;'(custom-enabled-themes (quote (tango-dark)))
;;  ;; '(ecb-options-version "2.40")
;;  ;; '(ecb-primary-secondary-mouse-buttons (quote mouse-1--C-mouse-1))
;;  '(font-use-system-font t)
;;  '(inhibit-startup-screen t)
;; )


;; (custom-set-faces
;;  ;; custom-set-faces was added by Custom.
;;  ;; If you edit it by hand, you could mess it up, so be careful.
;;  ;; Your init file should contain only one such instance.
;;  ;; If there is more than one, they won't work right.
;;  )


;;
;; ecb config
;;
;; check OS type
;; (cond
;;  ((string-equal system-type "darwin")   ; Mac OS X
;;   (setq ecb-source-path
;;       (quote
;;        (("~/code/private/Cloud-Database" "Cloud-Database"))))
;;   )
;;  ((string-equal system-type "gnu/linux") ; linux
;;   (setq ecb-source-path
;;       (quote
;;        (("~/code" "code")
;;         ("/home/cp16net/code/etherpy" "etherpy")
;;         )))
;;   )
;;  )
;; (setq ecb-layout-window-sizes
;;       (quote
;;        (("left4"
;;          (ecb-directories-buffer-name 0.1865671641791045 . 0.2911392405063291)
;;          (ecb-sources-buffer-name 0.1865671641791045 . 0.24050632911392406)
;;          (ecb-methods-buffer-name 0.1865671641791045 . 0.2911392405063291)))))


;; setup the python env for pymacs to use
(push "~/.virtualenvs/default/bin" exec-path)
(setenv "PATH"
        (concat
         "~/.virtualenvs/default/bin" ":"
         (getenv "PATH")
         ))


;;
;; load up the packaging goodness
;;
;;(require 'cl)
(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/"))
(package-initialize)

;; (unless (package-installed-p 'use-package)
;;   (package-refresh-contents)
;;   (package-install 'use-package))

;; (eval-when-compile
;;   (require 'use-package))
;; (require 'diminish)
;; (require 'bind-key)

; defvar is the correct way to declare global variables
; you might see setq as well, but setq is supposed to be use just to set variables,
; not create them.

;; (defvar required-packages
;;   '(
;;     ;; ac-python
;;     ;; auto-complete
;;     ;; color-theme
;;     ;; color-theme-zenburn
;;     diff-hl
;;     diredful
;;     exec-path-from-shell
;;     ;; fill-column-indicator
;;     ;; git-commit-mode
;;     ;; git-rebase-mode
;;     ;; go-mode
;;     ;; go-autocomplete
;;     magit
;;     org
;;     popup
;;     ;; yalinum
;;     yaml-mode
;;     yasnippet
;;     monokai-theme
;;     ) "A list of packages to ensure are installed at launch.")

;; ; method to check if all packages are installed
;; (defun packages-installed-p ()
;;   "Install a list of pacakges."
;;   (loop for p in required-packages
;;         when (not (package-installed-p p)) do (return nil)
;;         finally (return t)))

;; ; if not all packages are installed, check one by one and install the missing ones.
;; (unless (packages-installed-p)
;;   ; check for new packages (package versions)
;;   (message "%s" "Emacs is now refreshing its package database...")
;;   (package-refresh-contents)
;;   (message "%s" " done.")
;;   ; install the missing packages
;;   (dolist (p required-packages)
;;     (when (not (package-installed-p p))
;;       (package-install p))))

(require 'magit)
(define-key global-map (kbd "C-c m") 'magit-status)

(require 'yasnippet)
(yas-global-mode 1)
(yas-load-directory "~/.emacs.d/snippets")
(add-hook 'term-mode-hook (lambda()
			    (setq yas-dont-activate t)))


;;
;; CLOSE emacs for REAL?
;;
(defun ask-before-closing ()
  "Ask whether or not to close, and then close if y was pressed."
  (interactive)
  (if (y-or-n-p (format "Are you sure you want to exit Emacs? "))
      (if (< emacs-major-version 22)
          (save-buffers-kill-terminal)
        (save-buffers-kill-emacs))
    (message "Canceled exit")))
(when window-system
  (global-set-key (kbd "C-x C-c") 'ask-before-closing))


;;
;; store the backup and autosave in the system's tmp directory
;;
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
            `((".*" ,temporary-file-directory t)))


;;;
;;; Org Mode
;;;
;; (add-to-list 'load-path (expand-file-name "~/code/org-mode/lisp"))
(add-to-list 'auto-mode-alist '("\\.\\(org\\|org_archive\\)$" . org-mode))
(require 'org)
;; Standard key bindings
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)
;; TODO keywords list setup
(setq org-todo-keywords
      (quote ((sequence "TODO(t)" "NEXT(n)" "IN PROGRESS(i)" "|" "DONE(d)")
              (sequence "|" "CANCELLED(c)"))))
(setq org-todo-keyword-faces
      (quote (("TODO" :foreground "red" :weight bold)
              ("NEXT" :foreground "blue" :weight bold)
              ("IN PROGRESS" :foreground "green" :weight bold)
              ("DONE" :foreground "forest green" :weight bold)
              ("CANCELLED" :foreground "forest green" :weight bold)
	      )))




;;
;; pretty diff view of whats changed in a file
;;
(global-diff-hl-mode)
(diff-hl-margin-mode)


;;
;; zencoding - nice add for adding code
;;
;; (add-to-list 'load-path "~/.emacs.d/zencoding/")
;; (require 'zencoding-mode)
;; (add-hook 'sgml-mode-hook 'zencoding-mode) ;; Auto-start on any markup modes



;;
;; load my-keys after init
;;
(add-hook 'after-init-hook '(lambda ()
  (load "~/.emacs.d/my-keys.el")
))



;;(add-to-list 'load-path "~/.emacs.d")    ; This may not be appeared if you have already added.

;;
;; delete the trailing whitespace on lines before save
;;
(add-hook 'before-save-hook 'delete-trailing-whitespace)


;;
;; load theme
;;
(load-theme 'monokai t)


;;
;; set line numbers on the left side
;; (doesnt work in terminal mode only in gui mode)
;;
;; (require 'yalinum)
;; (add-hook 'yalinum-mode 'python-mode)
;; (global-yalinum-mode t)
;; (setq yalinum-format "%4d ")


;; auto complete enabled
;; (require 'auto-complete-config)
;; (add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")
;; (ac-config-default)

;; (defmacro after (mode &rest body)
;;   `(eval-after-load ,mode
;;      '(progn ,@body)))

;; (after 'auto-complete
;;        (add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")
;;        (setq ac-use-menu-map t)
;;        (define-key ac-menu-map "\C-n" 'ac-next)
;;        (define-key ac-menu-map "\C-p" 'ac-previous))

;; (after 'auto-complete-config
;;       (ac-config-default)
;;       (when (file-exists-p (expand-file-name "~/.emacs.d/sites-lisp/Pymacs"))
;;         (ac-ropemacs-initialize)
;;         (ac-ropemacs-setup)))

;; (after 'auto-complete-autoloads
;;        (autoload 'auto-complete-mode "auto-complete" "enable auto-complete-mode" t nil)
;;        (add-hook 'python-mode-hook
;;                  (lambda ()
;;                    (require 'auto-complete-config)
;;                    (add-to-list 'ac-sources 'ac-source-ropemacs)
;;                    (auto-complete-mode))))


;; 80 character bar limit
;; (require 'fill-column-indicator)
;; (setq fci-rule-column 80)
;; (setq fci-rule-color "darkgrey")
;; (add-hook 'after-change-major-mode-hook 'fci-mode)


;; bunch of ecb plugin stuff
;; (require 'ecb)
;; (setq stack-trace-on-error nil) ;;don’t popup Backtrace window
;; (setq ecb-tip-of-the-day nil)
;; (setq ecb-auto-activate t)
;; (setq ecb-layout-name "left6")
;; (setq ecb-options-version "2.40")
;; (setq ecb-primary-secondary-mouse-buttons (quote mouse-1–mouse-2))
;; (setq ecb-source-path (quote ("~/")))

;; (add-to-list 'load-path "~/.emacs.d/sites-lisp/ecb")
;; (require 'ecb)
;; (semantic-mode 1)


(load-file "~/.emacs.d/sites-lisp/smooth-scrolling.el")
(require 'smooth-scrolling)
;; scroll one line at a time (less "jumpy" than defaults)
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1))) ;; one line at a time


;;
;; load the go setup
;;
;;(load-file "~/.emacs.d/my-gochanges.el")


;;
;; load diredful (colors on dired mode)
;;
;;(require 'diredful)
(diredful-mode 1)

;;
;; yaml mode
;;
(require 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.yml\\'" . yaml-mode))
;; make enter <newline> with indent
(add-hook 'yaml-mode-hook
	  '(lambda ()
	     (define-key yaml-mode-map "\C-m" 'newline-and-indent)))

;;
;; remove the file menu bar at the top (annoying)
;;
(menu-bar-mode -1)

;;
;; docker file mode
;;
(require 'dockerfile-mode)
(add-to-list 'auto-mode-alist '("Dockerfile\\'" . dockerfile-mode))

;;
;; multiple cursors setup
;;
(require 'multiple-cursors)
;; add a cursor to each line in selected region
(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
;; add cursor not continuous lines (based on keywords in buffer
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)
;; get out of multiple cursor mode (press <return> or C-g)
;; If you want to insert a newline in multiple-cursors-mode, use C-j.


;;
;; emacs save buffers and history
;;
(desktop-save-mode 1)
(setq savehist-additional-variables              ;; also save...
      '(search-ring regexp-search-ring kill-ring);; ... my search entries
  savehist-file "~/.emacs.d/savehist")           ;; keep my home clean
(savehist-mode t)                                ;; do customization before activate
;; (add-to-list 'savehist-addition-variables 'kill-ring)


;;
;; use helm
;;
(require 'helm-config)
(require 'helm)
(helm-mode 1)
(projectile-global-mode)
(setq projectile-completion-system 'helm)
(helm-projectile-on)


;;
;; Company mode (complete anything)
;;
(add-hook 'after-init-hook 'global-company-mode)
;; add python completion for company mode
(add-hook 'python-mode-hook 'anaconda-mode)

;;
;; autopep8 (auto format python code)
;; (something goofy was going on here - overwrote all my changes to the file on save with the formater.)
;;
;; (defcustom python-autopep8-path (executable-find "autopep8")
;;   "autopep8 executable path."
;;   :group 'python
;;   :type 'string)

;; (defun python-autopep8 ()
;;   "Automatically formats Python code to conform to the PEP 8 style guide.
;; $ autopep8 --in-place --aggressive --aggressive <filename>"
;;   (interactive)
;;   (when (eq major-mode 'python-mode)
;;     (shell-command
;;      (format "%s --in-place --aggressive %s" python-autopep8-path
;;              (shell-quote-argument (buffer-file-name))))
;;     (revert-buffer t t t)))

;; (global-set-key (kbd "C-c C-r") 'python-autopep8)

;; (eval-after-load 'python
;;   '(if python-autopep8-path
;;        (add-hook 'before-save-hook 'python-autopep8)))


;;
;; flycheck
;;
;; (use-package flycheck
;;   :ensure t
;;   :init (global-flycheck-mode))
(add-hook 'after-init-hook #'global-flycheck-mode)


;;
;; virtualenvs setup
;;
(require 'virtualenvwrapper)
(venv-initialize-interactive-shells) ;; if you want interactive shell support
(venv-initialize-eshell) ;; if you want eshell support
;; note that setting `venv-location` is not necessary if you
;; use the default location (`~/.virtualenvs`), or if the
;; the environment variable `WORKON_HOME` points to the right place
(setq venv-location "/home/cp16net/.virtualenvs/")


;;
;; jedi-mode setup
;;
(setq jedi:environment-virtualenv (list (expand-file-name "~/.emacs.d/.python-environments/")))


(put 'upcase-region 'disabled nil)

;;; my-hacks.el ends here

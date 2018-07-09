;;; package --- my-hacks
;;; Commentary:
;;; (DEPRECATED)
;;; this is whats left of my hacks for my EMACS init script.
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


;;
;; set the font size
;;
(set-face-attribute 'default nil :height 105)


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


;;
;; zencoding - nice add for adding code
;;
;; (add-to-list 'load-path "~/.emacs.d/zencoding/")
;; (require 'zencoding-mode)
;; (add-hook 'sgml-mode-hook 'zencoding-mode) ;; Auto-start on any markup modes



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


;;
;; load the go setup
;;
;;(load-file "~/.emacs.d/my-gochanges.el")


;;
;; load diredful (colors on dired mode)
;;
;;(require 'diredful)
;;(diredful-mode 1)


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



;;; my-hacks.el ends here

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 ;;'(custom-enabled-themes (quote (tango-dark)))
 ;; '(ecb-options-version "2.40")
 ;; '(ecb-primary-secondary-mouse-buttons (quote mouse-1--C-mouse-1))
 '(font-use-system-font t)
 '(inhibit-startup-screen t)
)

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

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
;; CLOSE emacs for REAL?
;;
(defun ask-before-closing ()
  "Ask whether or not to close, and then close if y was pressed"
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
;; (add-to-list 'auto-mode-alist '("\\.\\(org\\|org_archive\\)$" . org-mode))
;; (require 'org)
;; ;; Standard key bindings
;; (global-set-key "\C-cl" 'org-store-link)
;; (global-set-key "\C-ca" 'org-agenda)
;; (global-set-key "\C-cb" 'org-iswitchb)
;; ;; TODO keywords list setup
;; (setq org-todo-keywords
;;       (quote ((sequence "TODO(t)" "NEXT(n)" "IN PROGRESS(i)" "|" "DONE(d)")
;;               (sequence "WAITING(w@/!)" "HOLD(h@/!)" "|" "CANCELLED(c@/!)" "PHONE" "MEETING"))))
;; (setq org-todo-keyword-faces
;;       (quote (("TODO" :foreground "red" :weight bold)
;;               ("NEXT" :foreground "blue" :weight bold)
;;               ("IN PROGRESS" :foreground "green" :weight bold)
;;               ("DONE" :foreground "forest green" :weight bold)
;;               ("WAITING" :foreground "orange" :weight bold)
;;               ("HOLD" :foreground "magenta" :weight bold)
;;               ("CANCELLED" :foreground "forest green" :weight bold)
;;               ("MEETING" :foreground "forest green" :weight bold)
;;               ("PHONE" :foreground "forest green" :weight bold))))



;;
;; load up the packaging goodness
;;
(require 'package)
(package-initialize)
(load "~/.emacs.d/my-loadpackages.el")


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
;;
;; (require 'yalinum)
;; (add-hook 'yalinum-mode 'python-mode)
;; (global-yalinum-mode t)
;; (setq yalinum-format "%4d ")


;; auto complete enabled
;; (require 'auto-complete-config)
;; (add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")
;; (ac-config-default)

(defmacro after (mode &rest body)
  `(eval-after-load ,mode
     '(progn ,@body)))

(after 'auto-complete
       (add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")
       (setq ac-use-menu-map t)
       (define-key ac-menu-map "\C-n" 'ac-next)
       (define-key ac-menu-map "\C-p" 'ac-previous))

(after 'auto-complete-config
      (ac-config-default)
      (when (file-exists-p (expand-file-name "~/.emacs.d/sites-lisp/Pymacs"))
        (ac-ropemacs-initialize)
        (ac-ropemacs-setup)))

(after 'auto-complete-autoloads
       (autoload 'auto-complete-mode "auto-complete" "enable auto-complete-mode" t nil)
       (add-hook 'python-mode-hook
                 (lambda ()
                   (require 'auto-complete-config)
                   (add-to-list 'ac-sources 'ac-source-ropemacs)
                   (auto-complete-mode))))


;; 80 character bar limit
(require 'fill-column-indicator)
(setq fci-rule-column 80)
(setq fci-rule-color "darkgrey")
(add-hook 'after-change-major-mode-hook 'fci-mode)


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

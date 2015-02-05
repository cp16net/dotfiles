(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes (quote (tango-dark)))
 '(ecb-options-version "2.40")
 '(ecb-primary-secondary-mouse-buttons (quote mouse-1--C-mouse-1))
 '(font-use-system-font t)
 '(inhibit-startup-screen t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; ecb config
;; check OS type
(cond
 ((string-equal system-type "darwin")   ; Mac OS X
  (setq ecb-source-path
      (quote
       (("~/code/private/Cloud-Database" "Cloud-Database"))))
  )
 ((string-equal system-type "gnu/linux") ; linux
  (setq ecb-source-path
      (quote
       (("~/code" "code")
	("/home/cp16net/code/etherpy" "etherpy")
	)))
  )
 )
(setq ecb-layout-window-sizes
      (quote
       (("left8"
	 (ecb-directories-buffer-name 0.1865671641791045 . 0.2911392405063291)
	 (ecb-sources-buffer-name 0.1865671641791045 . 0.24050632911392406)
	 (ecb-methods-buffer-name 0.1865671641791045 . 0.2911392405063291)
	 (ecb-history-buffer-name 0.1865671641791045 . 0.16455696202531644)))))

;; CLOSE emacs for REAL?
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
(add-to-list 'load-path (expand-file-name "~/code/org-mode/lisp"))
(add-to-list 'auto-mode-alist '("\\.\\(org\\|org_archive\\)$" . org-mode))
(require 'org)
;; Standard key bindings
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)
;; TODO keywords list setup
(setq org-todo-keywords
      (quote ((sequence "TODO(t)" "NEXT(n)" "IN PROGRESS(i)" "|" "DONE(d)")
              (sequence "WAITING(w@/!)" "HOLD(h@/!)" "|" "CANCELLED(c@/!)" "PHONE" "MEETING"))))
(setq org-todo-keyword-faces
      (quote (("TODO" :foreground "red" :weight bold)
              ("NEXT" :foreground "blue" :weight bold)
	      ("IN PROGRESS" :foreground "green" :weight bold)
              ("DONE" :foreground "forest green" :weight bold)
              ("WAITING" :foreground "orange" :weight bold)
              ("HOLD" :foreground "magenta" :weight bold)
              ("CANCELLED" :foreground "forest green" :weight bold)
              ("MEETING" :foreground "forest green" :weight bold)
              ("PHONE" :foreground "forest green" :weight bold))))



;; load up the packaging goodness
(require 'package)
(package-initialize)
(load "~/.emacs.d/my-loadpackages.el")


;; pretty diff view of whats changed in a file
(global-diff-hl-mode)


;; zencoding - nice add for adding code
(add-to-list 'load-path "~/.emacs.d/zencoding/")
(require 'zencoding-mode)
(add-hook 'sgml-mode-hook 'zencoding-mode) ;; Auto-start on any markup modes


;; Load up my custom changes here
(load "~/.emacs.d/my-hacks.el")


;; load my-keys after init
(add-hook 'after-init-hook '(lambda ()
  (load "~/.emacs.d/my-keys.el")
))

;; Load up my custom changes here

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
;; (package-initialize)


(load "~/.emacs.d/my-hacks.el")
;; (load "~/.emacs.d/prelude/init.el")

;; using the my-hack.el to set this
;;(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
;; '(inhibit-startup-screen t))

;;(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
;; )
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
 '(org-agenda-files (quote ("~/org/work.org" "~/org/personal.org")))
 '(org-export-backends (quote (ascii html icalendar latex md confluence)))
 '(package-selected-packages
   (quote
    (yaml-mode yalinum workgroups2 vue-mode virtualenvwrapper use-package tangotango-theme smex pandoc ox-pandoc nyan-mode multiple-cursors monokai-theme magit lua-mode jedi helm-projectile git-gutter-fringe git-gutter-fringe+ flycheck-pyflakes fill-column-indicator exec-path-from-shell emojify elpy dockerfile-mode diredful diff-hl company-shell company-jedi company-anaconda color-theme-tango ac-python))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

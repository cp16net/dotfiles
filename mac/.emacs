;;; .emacs configuration file

;;; code
;(load-file "~/.emacs.d/prelude/init.el")
 
;;; adding multiple-cursors
;(require 'multiple-cursors)
;(global-set-key (kbd "C-c C-e") 'mc/edit-lines)
;(global-set-key (kbd "C-c .") 'mc/mark-next-like-this)
;(global-set-key (kbd "C-c ,") 'mc/mark-previous-like-this)
;(global-set-key (kbd "C-c C-a") 'mc/mark-all-like-this)


;(provide '.emacs)
;;; .emacs ends here
(setq ido-enable-flex-matching t)
;(setq ido-everywhere t)
(ido-mode 1)

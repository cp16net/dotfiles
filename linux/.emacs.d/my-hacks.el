;;(add-to-list 'load-path "~/.emacs.d")    ; This may not be appeared if you have already added.

(add-hook 'before-save-hook 'delete-trailing-whitespace)
(load-theme 'zenburn t)
(require 'yalinum)
;;(add-hook 'yalinum-mode 'python-mode)
(global-yalinum-mode t)

;; auto complete enabled
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")
(ac-config-default)

(require 'fill-column-indicator)
(setq fci-rule-column 80)
(setq fci-rule-color "darkgrey")
(add-hook 'after-change-major-mode-hook 'fci-mode)


(defun smart-beginning-of-line ()
  "Move point to first non-whitespace character or beginning-of-line.

Move point to the first non-whitespace character on this line.
If point was already at that position, move point to beginning of line."
  (interactive)
  (let ((oldpos (point)))
    (back-to-indentation)
    (and (= oldpos (point))
         (beginning-of-line))))
(global-set-key [s-right] 'move-end-of-line)
(global-set-key [s-left] 'smart-beginning-of-line)


;; (require 'ecb)
;; (setq stack-trace-on-error nil) ;;don’t popup Backtrace window
;; ;;(setq ecb-tip-of-the-day nil)
;; (setq ecb-auto-activate t)
;; (setq ecb-layout-name "left6")
;; (setq ecb-options-version "2.40")
;; (setq ecb-primary-secondary-mouse-buttons (quote mouse-1–mouse-2))
;; (setq ecb-source-path (quote ("~/")))

(add-to-list 'load-path "~/.emacs.d/sites-lisp/ecb")
(require 'ecb)

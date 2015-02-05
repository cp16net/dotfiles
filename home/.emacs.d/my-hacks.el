;;(add-to-list 'load-path "~/.emacs.d")    ; This may not be appeared if you have already added.

(add-hook 'before-save-hook 'delete-trailing-whitespace)
(load-theme 'zenburn t)
(require 'yalinum)
;;(add-hook 'yalinum-mode 'python-mode)
(global-yalinum-mode t)

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
       (when (file-exists-p (expand-file-name "/Users/craig.vyvial/.emacs.d/sites-lisp/Pymacs"))
         (ac-ropemacs-initialize)
         (ac-ropemacs-setup)))

(after 'auto-complete-autoloads
       (autoload 'auto-complete-mode "auto-complete" "enable auto-complete-mode" t nil)
       (add-hook 'python-mode-hook
                 (lambda ()
                   (require 'auto-complete-config)
                   (add-to-list 'ac-sources 'ac-source-ropemacs)
                   (auto-complete-mode))))



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
(semantic-mode 1)

(load-file "~/.emacs.d/sites-lisp/smooth-scrolling.el")
(require 'smooth-scrolling)


;; scroll one line at a time (less "jumpy" than defaults)
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1))) ;; one line at a time

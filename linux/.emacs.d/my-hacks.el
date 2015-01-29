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

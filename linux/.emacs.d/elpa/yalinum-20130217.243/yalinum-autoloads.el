;;; yalinum-autoloads.el --- automatically extracted autoloads
;;
;;; Code:
(add-to-list 'load-path (or (file-name-directory #$) (car load-path)))

;;;### (autoloads nil "yalinum" "yalinum.el" (21702 61674 728410
;;;;;;  211000))
;;; Generated autoloads from yalinum.el

(autoload 'yalinum-mode "yalinum" "\
Toggle display of line numbers in the left margin.

\(fn &optional ARG)" t nil)

(defvar global-yalinum-mode nil "\
Non-nil if Global-Yalinum mode is enabled.
See the command `global-yalinum-mode' for a description of this minor mode.
Setting this variable directly does not take effect;
either customize it (see the info node `Easy Customization')
or call the function `global-yalinum-mode'.")

(custom-autoload 'global-yalinum-mode "yalinum" nil)

(autoload 'global-yalinum-mode "yalinum" "\
Toggle Yalinum mode in all buffers.
With prefix ARG, enable Global-Yalinum mode if ARG is positive;
otherwise, disable it.  If called from Lisp, enable the mode if
ARG is omitted or nil.

Yalinum mode is enabled in all buffers where
`yalinum-on' would do it.
See `yalinum-mode' for more information on Yalinum mode.

\(fn &optional ARG)" t nil)

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; End:
;;; yalinum-autoloads.el ends here

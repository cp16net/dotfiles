;;; ac-python.el --- Simple Python Completion Source for Auto-Complete

;; Author: Chris Poole <chris@chrispoole.com>
;; URL: http://chrispoole.com/project/ac-python
;; Version: 20110519
;; Package-Requires: ((auto-complete "1.4"))
;; Copyright (C) Chris Pool

(defun ac-get-python-symbol-at-point ()
  "Return python symbol at point.

Assumes symbol can be alphanumeric, `.' or `_'."
  (let ((end (point))
        (start (ac-python-start-of-expression)))
    (buffer-substring-no-properties start end)))

(defun ac-python-completion-at-point ()
  "Returns a possibly empty list of completions for the symbol at
point."
  (python-symbol-completions (ac-get-python-symbol-at-point)))

(defun ac-python-start-of-expression ()
  "Return point of the start of python expression at point.

Assumes symbol can be alphanumeric, `.' or `_'."
  (save-excursion
    (and (re-search-backward
          (rx (or buffer-start (regexp "[^[:alnum:]._]"))
              (group (1+ (regexp "[[:alnum:]._]"))) point)
          nil t)
         (match-beginning 1))))

(defvar ac-source-python
  '((candidates . ac-python-completion-at-point)
    (prefix . ac-python-start-of-expression)
    (symbol . "f")
    (requires . 2))
  "Source for python completion.")

(add-hook 'python-mode-hook (lambda () (add-to-list 'ac-sources 'ac-source-python)))

(provide 'ac-python)

;;; ac-python.el ends here

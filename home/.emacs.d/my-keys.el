; ~/.emacs.d/my-keys.el

;; Wind-move
(global-set-key (kbd "C-c C-j") 'windmove-left)
(global-set-key (kbd "C-c C-k") 'windmove-down)
(global-set-key (kbd "C-c C-l") 'windmove-up)
(global-set-key (kbd "C-c C-;") 'windmove-right)

(defun smart-beginning-of-line ()
  "Move point to first non-whitespace character or beginning-of-line.

Move point to the first non-whitespace character on this line.
If point was already at that position, move point to beginning of line."
  (interactive)
  (let ((oldpos (point)))
    (back-to-indentation)
    (and (= oldpos (point))
         (beginning-of-line))))
;; (global-set-key [s-right] 'move-end-of-line)
;; (global-set-key [s-left] 'smart-beginning-of-line)
(global-set-key [home] 'smart-beginning-of-line)
(global-set-key (kbd "C-a") 'smart-beginning-of-line)


(global-set-key (kbd "C-c C-f") 'find-grep-dired)

(defvar grep-and-find-map (make-sparse-keymap))
 (define-key global-map "\C-xf" grep-and-find-map)
 (define-key global-map "\C-xfg" 'find-grep-dired)
 (define-key global-map "\C-xff" 'find-name-dired)
 (define-key global-map "\C-xfl" (lambda (dir pattern)
        (interactive "DFind-name locate-style (directory):
                     \nsFind-name locate-style (filename wildcard): ")
        (find-dired dir (concat "-name '*" pattern "*'"))))
 (define-key global-map "\C-xg" 'grep)

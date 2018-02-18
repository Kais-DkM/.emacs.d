(require 'cl-lib)
(require 'dash)

(defun altistic-test-func1 () (interactive) (message "test func 1"))
(defun altistic-test-func2 () (interactive) (message "test func 2"))
(defun altistic-test-func3 () (interactive) (message "test func 3"))

(defvar altistic-map
  (let ((map (make-sparse-keymap)))
    (let ((target-char ?a))
      (while (<= target-char ?z)
	(let ((literal-char (help-key-description (vector target-char) nil)))
	  (define-key map (kbd literal-char) (kbd (concat "M-" literal-char))))
	(setq target-char (1+ target-char))))
    map)
  "Keymap for altistic mode")
(defvar altistic-ignore-self-insert t
  "Make altistic mode ignore self-insert command")
(make-variable-buffer-local 'altistic-ignore-self-insert)

(defun altistic-toggle-self-insert ()
  (interactive)
  (setq altistic-ignore-self-insert (not altistic-ignore-self-insert)))

(defun altistic--upper-p (key)
  (let ((key-string (help-key-description (list key) nil)))
    (let ((first-char (elt key-string 0))
	  (last-char (elt key-string (1- (length key-string)))))
      (cond
       ;; special key storke
       ((and (eql first-char ?<) (eql last-char ?>)) nil)
       ;; A-Z
       ((and (>= last-char ?A) (<= last-char ?Z)) t)
       ;; a-z
       ((and (>= last-char ?a) (<= last-char ?z)) t)
       ;; other cases
       (t nil)))))

(defun altistic-process-key ()
  "Handle key inputs in altistic way"
  (interactive)
  (setf (alist-get 'altistic-mode minor-mode-map-alist) (make-sparse-keymap))
  (let* ((first-key (aref (this-command-keys-vector)
			  (- (length (this-command-keys-vector)) 1)))
	 (binding (altistic-lookup-command first-key nil)))
    (setf (alist-get 'altistic-mode minor-mode-map-alist) altistic-map)
    (let ((binding-key (cdr binding))
	  (binding-command (car binding)))
      (if binding-command
	  (progn
	    (setq
	     this-command-keys-shift-translated (altistic--upper-p first-key)
	     this-command binding-command
	     this-original-command binding-command
	     real-this-command binding-command)
	    (if (commandp binding-command t)
		(call-interactively binding-command)
	      (execute-kbd-macro binding-command)))
	(message "Altistic: no key binding found for %s" binding-key)))))

(defun altistic-lookup-command (key prev-keys)
  (let* ((current-key (or key
			  (read-event (apply 'altistic--concat-with-space
					     prev-keys))))
	 (current-key-string
	  (replace-regexp-in-string "M-" ""
				    (help-key-description `(,current-key) nil)))
	 (all-keys (append prev-keys `(,current-key-string)))
	 (all-key-combinations (altistic--all-combinations all-keys "M-")))
    (or (seq-some (lambda (k)
		    (let ((binding (key-binding (read-kbd-macro k))))
		      (when (and (commandp binding)
				 (not (eq 'altistic-process-key binding))
				 (or (not altistic-ignore-self-insert)
				     (not (eq binding 'self-insert-command))))
			(cons k binding))))
		  all-key-combinations)
	(when (seq-some (lambda (k)
			  (let ((binding (key-binding (read-kbd-macro k))))
			    (keymapp binding)))
			all-key-combinations)
	  (altistic-lookup-command nil all-keys))
	(cons nil (apply 'altistic--concat-with-space all-keys)))))

(defun altistic--all-combinations (keys prefix)
  (let ((combination (mapcar (lambda (k) (list k (concat prefix k))) keys)))
    (cond ((eql (length keys) 0) nil)
	  ((eql (length keys) 1) (elt combination 0))
	  (t (apply '-table-flat 'altistic--concat-with-space combination)))))

(defun altistic--concat-with-space (&rest strings)
  (apply 'concat (mapcar (lambda (s) (concat s " ")) strings)))

;;;###autoload
(define-minor-mode altistic-mode
  "Toggle altistic mode"
  :global t
  :lighter " Altistic"
  :keymap altistic-map)

(define-key altistic-map (kbd "C-<return>") 'altistic-process-key)

(provide 'altistic)

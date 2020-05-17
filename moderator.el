(require 'dash)
(require 'subr-x)

(setq moderator-mode-stack '(original))
(setq original-global-map global-map)
(setq navigate-global-map (make-sparse-keymap))
(setq insert-global-map (make-sparse-keymap))
(use-local-map (make-sparse-keymap))

(setq moderator-prefix "C-")

(defun moderator-get-mode ()
  (car moderator-mode-stack))

(defun moderator-set-mode (mode)
  (setcar moderator-mode-stack mode)
  (cond ((eq mode 'navigate) (use-global-map navigate-global-map))
	((eq mode 'insert) (use-global-map insert-global-map))
	((eq mode 'original) (use-global-map original-global-map))))

(defun moderator-toggle-mode ()
  (interactive)
  (let ((moderator-mode (moderator-get-mode)))
    (cond ((eq moderator-mode 'navigate) (moderator-set-mode 'insert))
	  ((eq moderator-mode 'insert) (moderator-set-mode 'navigate))
	  ((eq moderator-mode 'original) (moderator-set-mode 'navigate)))))

(defun moderator-push-mode (mode)
  (push mode moderator-mode-stack)
  (moderator-set-mode mode))

(defun moderator-pop-mode ()
  (pop moderator-mode-stack)
  (moderator-set-mode (moderator-get-mode)))

(defun moderator--generate-key (prefix keys)
  (apply '-table-flat
	 (lambda (&rest keys) (string-join keys " "))
	 (--map (list it (concat prefix it)) keys)))

(defun moderator-set-key (key command &optional is-special)
  ;; Show a warning if `moderator-prefix` is used
  (when (string-match-p (regexp-quote moderator-prefix) key)
    (message "\"%s\" is not allowed for moderator key sequence! [%s]"
	     moderator-prefix key))
  ;; Calculate all combinations of keys with and without the modifier
  (let* ((key-list (split-string key))
	 (full-keys (moderator--generate-key moderator-prefix key-list))
	 (modified-first-key (concat moderator-prefix (car key-list)))
	 (partial-keys (moderator--generate-key moderator-prefix
						(cdr key-list))))
    (--map (define-key navigate-global-map (kbd it) command) full-keys)
    (--map (define-key insert-global-map (kbd it) command)
	   (cond (is-special full-keys)
		 ((null partial-keys) (list modified-first-key))
		 (t (--map (concat modified-first-key " " it)
			   partial-keys))))))

(defun moderator-set-special-key (key command)
  (moderator-set-key key command t))

;; Automatically switch to insert mode on some modes
(add-hook 'minibuffer-setup-hook (lambda () (moderator-push-mode 'insert)))
(add-hook 'minibuffer-exit-hook (lambda () (moderator-pop-mode)))

;; Bind keys for inserting characters
(map-keymap (lambda (event value)
	      (when (eq value 'self-insert-command)
		;; TODO: define keys for navigate map
		(define-key insert-global-map (vector event) value)))
	    original-global-map)

;; Bind special keys
(moderator-set-special-key "<mouse-1>" 'mouse-set-point)
(moderator-set-special-key "<mouse-4>" 'mwheel-scroll)
(moderator-set-special-key "<mouse-5>" 'mwheel-scroll)
(moderator-set-special-key "<left>" 'left-char)
(moderator-set-special-key "<right>" 'right-char)
(moderator-set-special-key "<up>" 'previous-line)
(moderator-set-special-key "<down>" 'next-line)
(moderator-set-special-key "DEL" 'delete-backward-char)
(moderator-set-special-key "<delete>" 'delete-char)
(moderator-set-special-key "TAB" 'indent-for-tab-command)
(moderator-set-special-key "RET" 'newline)
(moderator-set-special-key "<home>" 'move-beginning-of-line)
(moderator-set-special-key "<end>" 'move-end-of-line)
(moderator-set-special-key "<prior>" 'scroll-down)
(moderator-set-special-key "<next>" 'scroll-up)
(moderator-set-special-key "<escape>" 'keyboard-escape-quit)

;; Bind mode toggle keys
(moderator-set-key "k" 'moderator-toggle-mode)
(moderator-set-key "s" 'moderator-toggle-mode)

;; Bind commands
(moderator-set-key "SPC" 'execute-extended-command)

;; Change to navigate mode
(moderator-set-mode 'navigate)

(provide 'moderator)

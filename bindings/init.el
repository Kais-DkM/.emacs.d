(require 'f)
(require 's)

(setq binding-root (f-dirname (f-this-file)))

(defun load-binding (key)
  (load (if (f-directory? (f-join binding-root key))
	    (f-join binding-root key "init.el")
	  (f-join binding-root (concat key ".el")))))

(defun define-key-with-modifier (modifier keymap ignore-first key func)
  (let* (
	 (key-sequence (--map (list it (concat modifier it)) (split-string key)))
	 (key-combination (--map (s-join " " it)
				 (-if-let (comb (apply '-table-flat 'list key-sequence))
					  comb
					  (-map 'list (-flatten key-sequence))))))
    (--each key-combination
      (if (or (not ignore-first) (s-starts-with? modifier it))
	  (define-key keymap (kbd it) func)))))

;; global key bindings
;;; empty all keymaps
(setq original-global-map global-map)
(setq global-map (make-sparse-keymap))
(use-global-map global-map)
(use-local-map (make-sparse-keymap))

;;; minibuffer key definition
(substitute-key-definition 'self-insert-command
			   'self-insert-command
			   minibuffer-local-map
			   original-global-map)
(define-key minibuffer-local-map (kbd "DEL") 'delete-backward-char)
(define-key minibuffer-local-map (kbd "<delete>") 'delete-forward-char)
(define-key minibuffer-local-map (kbd "ESC ESC") 'abort-recursive-edit)

;;; mode changing key definitions
;;(define-key evil-normal-state-map (kbd "SPC") 'evil-insert)
;;(define-key evil-insert-state-map (kbd "M-SPC") 'evil-normal-state)
;;(define-key evil-insert-state-map (kbd "ESC ESC") 'evil-normal-state)

;;; basic global key definitions
(substitute-key-definition 'self-insert-command
			   'self-insert-command
			   global-map
			   original-global-map)
(global-set-key (kbd "<mouse-1>") 'mouse-set-point)
(global-set-key (kbd "<mouse-4>") 'mwheel-scroll)
(global-set-key (kbd "<mouse-5>") 'mwheel-scroll)
(global-set-key (kbd "<vertical-scroll-bar> <mouse-1>")
		'scroll-bar-toolkit-scroll)

;;; normal map key definition
(global-set-key (kbd "<left>") 'backward-char)
(global-set-key (kbd "<right>") 'forward-char)
(global-set-key (kbd "<up>") 'previous-line)
(global-set-key (kbd "<down>") 'next-line)
(global-set-key (kbd "M-s") 'backward-char)
(global-set-key (kbd "M-f") 'forward-char)
(global-set-key (kbd "M-e") 'previous-line)
(global-set-key (kbd "M-d") 'next-line)
(global-set-key (kbd "M-j") 'evil-scroll-column-left)
(global-set-key (kbd "M-l") 'evil-scroll-column-right)
(global-set-key (kbd "M-i") 'scroll-down-line)
(global-set-key (kbd "M-k") 'scroll-up-line)
(global-set-key (kbd "DEL") 'delete-backward-char)
(global-set-key (kbd "<delete>") 'delete-char)
(global-set-key (kbd "M-t") 'delete-backward-char)
(global-set-key (kbd "M-y") 'delete-char)
(global-set-key (kbd "TAB") 'indent-for-tab-command)
(global-set-key (kbd "RET") 'newline)
(global-set-key (kbd "M-u") 'undo)
(global-set-key (kbd "M-b") 'execute-extended-command)
(global-set-key (kbd "<home>") 'move-beginning-of-line)
(global-set-key (kbd "<end>") 'move-end-of-line)
(global-set-key (kbd "<prior>") 'scroll-down)
(global-set-key (kbd "<next>") 'scroll-up)
(global-set-key (kbd "M-h s") 'move-beginning-of-line)
(global-set-key (kbd "M-h f") 'move-end-of-line)
(global-set-key (kbd "M-h e") 'scroll-down)
(global-set-key (kbd "M-h d") 'scroll-up)
(global-set-key (kbd "<C-prior>") 'previous-buffer)
(global-set-key (kbd "<C-next>") 'next-buffer)
(global-set-key (kbd "M-g j") 'previous-buffer)
(global-set-key (kbd "M-g l") 'next-buffer)
(global-set-key (kbd "M-g o") 'find-file)
(global-set-key (kbd "M-g RET") 'save-buffer)
(global-set-key (kbd "M-h w") 'kill-this-buffer)
(global-set-key (kbd "M-C-SPC") 'set-mark-command)
(global-set-key (kbd "M-v") 'kill-ring-save)
(global-set-key (kbd "M-V") 'kill-region)
(global-set-key (kbd "M-n") 'yank)
(global-set-key (kbd "M-c") 'isearch-backward)
(global-set-key (kbd "M-m") 'isearch-forward)

(global-set-key (kbd "M-h 1") 'delete-other-windows)

(global-set-key (kbd "M-? v") 'describe-variable)
(global-set-key (kbd "M-? f") 'describe-function)
(global-set-key (kbd "M-? k") 'describe-key)

(provide 'bindings-init)

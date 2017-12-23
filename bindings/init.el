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

(provide 'bindings-init)

(require 'f)
(require 'req-package)

(setq use-package-always-ensure t)

(dolist (file (f-files (f-dirname (f-this-file))))
  (when (and (f-ext? file "el")
	     (not (string= file (f-this-file))))
    (load file)))

(req-package-finish)

(provide 'packages-init)

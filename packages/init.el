(require 'f)
(require 'req-package)

(setq use-package-always-ensure t)

;; turn on evil mode (evil keymap is critical for this setting, so we manually turn it on)
(require 'evil)
(load-binding "evil")
(evil-mode t)
(setq evil-move-beyond-eol t)

(dolist (file (f-files (f-dirname (f-this-file))))
  (when (and (f-ext? file "el")
	     (not (string= file (f-this-file))))
    (load file)))

(req-package-finish)

(provide 'packages-init)

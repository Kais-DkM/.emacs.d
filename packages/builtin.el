(require 'req-package)
(require 'bindings-init)

(req-package windmove
  :config
  (load-binding "windmove"))

;; TODO : disable linum on specified modes
(req-package linum
  :config
  (global-linum-mode t))

(req-package whitespace
  :config
  (global-whitespace-mode t)
  (setq whitespace-style
 	'(face
 	  tabs lines-tail trailing space-before-tab indentation tab-mark))
  (setq whitespace-global-modes '(not help-mode messages-buffer-mode)))

(req-package electric
  :config
  (electric-pair-mode t)
  (electric-layout-mode t))

(req-package autorevert
  :config
  (global-auto-revert-mode t))

(provide 'packages-builtin)

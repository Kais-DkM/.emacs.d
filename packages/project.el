(require 'req-package)

(req-package perspective
  :config
  (persp-mode))

(req-package projectile
  :require dash pkg-info perspective
  :config
  (projectile-global-mode))

(req-package persp-projectile
  :require perspective projectile)

(req-package desktop
  :config
  (desktop-save-mode t))

(provide 'packages-project)

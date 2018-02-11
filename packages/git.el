(require 'req-package)
(require 'bindings-init)

(req-package magit
  :config
  (load-binding "magit"))

;; magithub

(provide 'packages-git)

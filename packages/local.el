(require 'req-package)
(require 'bindings-init)

(req-package minimap
  :ensure nil
  :load-path "scripts")

(req-package altistic
  :ensure nil
  :load-path "scripts"
  :config
  (load-binding "altistic")
  (altistic-mode t)
  (add-hook 'minibuffer-setup-hook (lambda ()
				     (when altistic-ignore-self-insert
				       (altistic-toggle-self-insert)))))

(provide 'packages-local)

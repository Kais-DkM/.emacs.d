(require 'req-package)
(require 'bindings-init)

(req-package company
  :config
  (load-binding "company")
  (setq company-idle-delay 0.1)
  (global-company-mode t))

(req-package company-flx
  :require company flx
  :config
  (company-flx-mode t))

(req-package yasnippet
  :require cl-lib)

(provide 'packages-autocomplete)

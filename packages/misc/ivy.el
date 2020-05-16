(require 'req-package)

(req-package ivy
  :custom
  (ivy-count-format "(%d/%d) ")
  :config
  (ivy-mode t)
  (setq ivy-re-builders-alist '((t . ivy--regex-fuzzy))))

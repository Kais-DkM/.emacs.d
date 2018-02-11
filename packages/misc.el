(require 'req-package)
(require 'bindings-init)

(req-package paradox
  :config
  (paradox-enable))

(req-package undo-tree
  :config
  (load-binding "undo-tree")
  (global-undo-tree-mode t))

(req-package helpful
  :config
  (load-binding "helpful"))

(req-package tabbar
  :config
  (load-binding "tabbar")
  (tabbar-mode t))

(req-package hlinum
  :require linum)

(req-package hl-line
  :config
  (global-hl-line-mode t))

(req-package highlight-parentheses
  :config (global-highlight-parentheses-mode t))

;; TODO : add configurations
(req-package anzu
  :config
  (global-anzu-mode t))

(req-package ivy
  :require flx
  :config
  (load-binding "ivy")
  (ivy-mode 1)
  (setq ivy-re-builders-alist
 	'((t . ivy--regex-fuzzy)))
  (setq ivy-count-format "(%d/%d) "))

(req-package minimap
  :loader :path
  :load-path "~/.emacs.d/scripts/")

(provide 'packages-misc)

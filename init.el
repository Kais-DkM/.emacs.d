;(package-initialize)

(setq load-prefer-newer t)

(require 'package)

(setq package-archives
      '(("marmalade" . "https://marmalade-repo.org/packages/")
	("melpa-stable" . "https://stable.melpa.org/packages/")
	("melpa" . "https://melpa.org/packages/")
	("gnu" . "https://elpa.gnu.org/packages/")))
(setq package-archive-priorities
      '(("melpa-stable" . 30)
	("marmalade" . 20)
	("gnu" . 10)
	("melpa" . 0)))
(package-initialize)

(unless package-archive-contents (package-refresh-contents))

(setq package-selected-packages '(req-package evil f s dash))
(package-install-selected-packages)


(require 'f)

(setq init-dir (f-dirname (f-this-file)))
(load (f-join init-dir "bindings" "init.el"))
(add-to-list 'load-path (f-join init-dir "scripts"))

;; turn on evil mode (evil keymap is critical for this setting, so we manually turn it on)
(require 'evil)
(load-binding "evil")
(evil-mode t)
(setq evil-move-beyond-eol t)

(require 'req-package)

(req-package minimap
  :loader :path)

(req-package paradox)

(req-package undo-tree
  :config
  (load-binding "undo-tree")
  (global-undo-tree-mode t))

(req-package help-fns+
  :config
  (load-binding "help-fns-plus"))

(req-package tabbar
  :config
  (load-binding "tabbar")
  (tabbar-mode t))

(req-package windmove
  :config
  (load-binding "windmove"))

;; TODO : disable linum on specified modes
(req-package linum
  :config
  (global-linum-mode t))

(req-package hlinum
  :require linum
  :config
  (hlinum-activate))

(req-package hl-line
  :config
  (global-hl-line-mode t))

(req-package whitespace
  :config
  (global-whitespace-mode t)
  (setq whitespace-style
	'(face
	  tabs lines-tail trailing space-before-tab indentation tab-mark))
  (setq whitespace-global-modes '(not help-mode messages-buffer-mode)))

(req-package flx)

(req-package ivy
  :require flx
  :config
  (load-binding "ivy")
  (ivy-mode 1)
  (setq ivy-re-builders-alist
	'((t . ivy--regex-fuzzy)))
  (setq ivy-count-format "(%d/%d) "))

(req-package company
  :config
  (load-binding "company")
  (setq company-idle-delay 0.1)
  (global-company-mode t))

(req-package company-flx
  :require company flx
  :config
  (company-flx-mode t))
(req-package-finish)

(setq gc-cons-threshold 20000000)

(setq inhibit-startup-message t)
(tool-bar-mode -1)
(menu-bar-mode -1)

;; (setq-default tab-always-indent 'complete)

(let ((backup-dir (f-slash (f-join init-dir "backup"))))
  (unless (f-directory? backup-dir) (f-mkdir backup-dir))
  (setq backup-directory-alist `((".*" . ,backup-dir))))
(let ((autosave-dir (f-slash (f-join init-dir "autosave"))))
  (unless (f-directory? autosave-dir) (f-mkdir autosave-dir))
  (setq auto-save-file-name-transforms `((".*" ,autosave-dir t)))
  (setq auto-save-list-file-prefix (f-join autosave-dir ".save-list")))
(setq backup-by-copying t
      version-control t
      delete-old-versions t
      kept-new-versions 6
      kept-old-versions 2)

(setq scroll-step 1)
(setq frame-resize-pixelwise t)

(setq custom-file (f-join init-dir "custom.el"))
(load custom-file 'noerror)

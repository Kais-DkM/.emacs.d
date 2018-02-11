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

(load (f-join user-emacs-directory "bindings" "init.el"))
(add-to-list 'load-path (f-join user-emacs-directory "scripts"))
(load (f-join user-emacs-directory "themes" "init.el"))
(load (f-join user-emacs-directory "packages" "init.el"))
(load-theme 'base t)

(line-number-mode t)
(column-number-mode t)

(setq gc-cons-threshold 20000000)

(setq inhibit-startup-message t)
(tool-bar-mode -1)
(menu-bar-mode -1)

;; (setq-default tab-always-indent 'complete)

(let ((backup-dir (f-slash (f-join user-emacs-directory "backup"))))
  (unless (f-directory? backup-dir) (f-mkdir backup-dir))
  (setq backup-directory-alist `((".*" . ,backup-dir))))
(let ((autosave-dir (f-slash (f-join user-emacs-directory "autosave"))))
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

(setq custom-file (f-join user-emacs-directory "custom.el"))
(load custom-file 'noerror)

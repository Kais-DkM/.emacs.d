;(package-initialize)

(setq load-prefer-newer t)

(require 'package)
(setq package-archives
      '(("melpa-stable" . "https://stable.melpa.org/packages/")
	("melpa" . "https://melpa.org/packages/")
	("gnu" . "https://elpa.gnu.org/packages/")))
(setq package-archive-priorities
      '(("melpa-stable" . 20)
	("gnu" . 10)
	("melpa" . 0)))
(package-initialize)

(unless package-archive-contents (package-refresh-contents))

(setq package-selected-packages '(f))
(package-install-selected-packages)

(require 'f)

(setq inhibit-startup-screen t)
(line-number-mode t)
(column-number-mode t)
(tool-bar-mode -1)
(menu-bar-mode -1)

(let ((backup-dir (f-join user-emacs-directory "backup")))
  (unless (f-exists? backup-dir) (f-mkdir backup-dir))
  (setq backup-directory-alist `((".*" . ,backup-dir))))
(let ((autosave-dir (f-slash (f-join user-emacs-directory "autosave"))))
  (unless (f-exists? autosave-dir) (f-mkdir autosave-dir))
  (setq auto-save-file-name-transforms `((".*" ,autosave-dir t)))
  (setq auto-save-list-file-prefix (f-join autosave-dir ".saves")))
(setq backup-by-copying t
      version-control t
      delete-old-versions t
      kept-new-versions 6
      kept-old-versions 2)

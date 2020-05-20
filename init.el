;(package-initialize)

(setq load-prefer-newer t)
(setq gc-cons-threshold (* 100 1024 1024))

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

(setq package-selected-packages '(dash f req-package))
(package-install-selected-packages)

(require 'f)
(require 'req-package)

(defun load-directory (dir)
  "Load all emacs lisp files in `dir` recursively"
  (dolist (file (f-entries dir))
    (cond ((f-directory? file) (load-directory file))
	  ((f-ext? file "el") (load file)))))

(setq inhibit-startup-screen t)
(line-number-mode t)
(column-number-mode t)
(tool-bar-mode -1)
(menu-bar-mode -1)
(set-scroll-bar-mode 'right)

(load (f-join user-emacs-directory "moderator.el"))
(load-directory (f-join user-emacs-directory "packages"))

(setq use-package-always-ensure t)
(req-package-finish)

(let ((backup-dir (f-slash (f-join user-emacs-directory "backup"))))
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

(setq custom-theme-directory (f-join user-emacs-directory "themes"))
(load-directory custom-theme-directory)
(load-theme 'remagpie t)

(setq custom-file (f-join user-emacs-directory "custom.el"))
(load custom-file 'noerror)

(eval-when-compile (require 'cl-lib))

(defvar minimap--current-buffer nil "Internal variable to keep track on current buffer")

(make-variable-frame-local (defvar minimap-window nil "Window to show minimap"))

(make-variable-buffer-local (defvar minimap-enable t "Flag to turn the minimap on"))

(defgroup minimap nil "Minimap for emacs" :group 'convenience)

(defcustom minimap-width 17
  "Width of minimap window"
  :type 'number
  :group 'minimap)

(defcustom minimap-font-size 40
  "Font size of minimap"
  :type 'number
  :group 'minimap)

(defcustom minimap-buffer-prefix " *Minimap-"
  "Prefix for minimap buffers"
  :type 'string
  :group 'minimap)

(defcustom minimap-target-modes '(prog-mode)
  "List of major modes to show minimap"
  :type '(repeat symbol)
  :group 'minimap)

(defun minimap-buffer-name (&optional frame)
  "Returning name of buffer for minimap of currently selected frame"
  ;; TODO: remove argument
  (concat minimap-buffer-prefix (cdr (assq 'window-id (frame-parameters frame)))))

(defun minimap--is-enabled ()
  "Predicate for determining minimap is enabled for this buffer"
  (and minimap-enable (apply 'derived-mode-p minimap-target-modes)))

(defun minimap--create-window (&optional frame)
  (with-selected-frame (if frame frame (selected-frame))
    (split-window-horizontally (- minimap-width))
    (setq minimap-window (window-in-direction 'right))
    (set-window-parameter minimap-window 'no-other-window t)
    (set-window-fringes minimap-window 0 0))) 

(defun minimap--create-buffer (&optional buffer)
  (cl-assert (not (get-buffer (minimap-buffer-name))) nil "Minimap buffer already exists!")
  (make-indirect-buffer (if buffer buffer (current-buffer)) (minimap-buffer-name))
  (with-current-buffer (minimap-buffer-name)
    ;; setup misc settings on buffer
    (setq vertical-scroll-bar nil)
    (setq truncate-lines t)
    (setq buffer-read-only t)
    ;; create overlay with small font size
    (let ((minimap-text-overlay (make-overlay (point-min) (point-max) nil t t)))
      (overlay-put minimap-text-overlay
		   'face `((:family ,(face-attribute 'default :family) :height ,minimap-font-size)))
      (overlay-put minimap-text-overlay 'priority 1)))
  (setq minimap--current-buffer (current-buffer)))

(defun minimap--kill-buffer (&optional frame preserve-state)
  (kill-buffer (minimap-buffer-name frame))
  (unless preserve-state (setq minimap--current-buffer nil)))

(defun minimap--kill-window (&optional frame)
  (with-selected-frame (if frame frame (selected-frame))
    (when (window-live-p minimap-window) (delete-window minimap-window))
    (setq minimap-window nil)))

(defun minimap--create-minimap (&optional frame buffer)
  (with-selected-frame (if frame frame (selected-frame))
    (minimap--create-window)
    (minimap--create-buffer (if buffer buffer (current-buffer)))
    (set-window-dedicated-p minimap-window nil)
    (set-window-buffer minimap-window (minimap-buffer-name))
    (set-window-dedicated-p minimap-window t)))

(defun minimap--kill-minimap (&optional frame preserve-state)
  (with-selected-frame (if frame frame (selected-frame))
    (minimap--kill-buffer (selected-frame) preserve-state)
    (minimap--kill-window)))

(defun minimap--update-minimap ()
  (when (and minimap-mode (not (active-minibuffer-window)))
    ;; kill/recreate window if minimap should be disabled
    (if (minimap--is-enabled)
	(unless (get-buffer (minimap-buffer-name))
	  (minimap--create-minimap))
      (when (get-buffer (minimap-buffer-name))
	(minimap--kill-minimap)))
    ;; update minimap content
    (when (and (not (eq minimap--current-buffer (current-buffer)))
	       (get-buffer-window (minimap-buffer-name)))
      (set-window-dedicated-p minimap-window nil)
      (minimap--kill-buffer)
      (minimap--create-buffer)
      (set-window-buffer minimap-window (minimap-buffer-name))
      (set-window-dedicated-p minimap-window t))))

;;;###autoload
(define-minor-mode minimap-mode
  "Toggle minimap mode"
  :global t
  :group 'minimap
  :lighter " Minimap"
  (if minimap-mode
      (progn
	(dolist (frame (frame-list)) (minimap--create-minimap frame))
	(add-hook 'post-command-hook 'minimap--update-minimap))
    (dolist (frame (frame-list)) (minimap--kill-minimap frame))
    (remove-hook 'post-command-hook 'minimap--update-minimap)))

(provide 'minimap)

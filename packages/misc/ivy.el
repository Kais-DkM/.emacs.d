(require 'req-package)
(require 'moderator)

(req-package ivy
  :custom
  (ivy-count-format "(%d/%d) ")
  :config
  ;;(setq ivy-mode-map (make-sparse-keymap))
  ;;(setq ivy-minibuffer-map (make-sparse-keymap))
  ;;(moderator-set-key "<mouse-1>" 'ivy-mouse-done)
  ;;(moderator-set-key "<mouse-3>" 'ivy-mouse-dispatching-done)
  ;;(moderator-set-key )
  ;; ivy-backward-delete-char
  ;; ivy-scroll-up-command
  ;; ivy-scroll-down-command
  ;; ivy-forward-char
  ;; ivy-delete-char
  ;; ivy-next-line
  ;; ivy-previous-line
  ;; ivy-reverse-i-search
  ;; ivy-next-line-or-history
  ;; ivy-beginning-of-buffer
  ;; ivy-end-of-buffer
  ;; ivy-backward-kill-word
  ;; ivy-yank-word
  ;; ivy-kill-word
  ;; ivy-kill-ring-save
  ;; ivy-done
  ;; ivy-partial-or-done
  (ivy-mode t)
  (setq ivy-re-builders-alist '((t . ivy--regex-fuzzy))))

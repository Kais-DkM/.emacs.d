(require 'company)
(require 'evil)

(define-key-with-modifier "M-" evil-insert-state-map nil "C-;" 'company-complete-common)
(setq company-active-map (make-sparse-keymap))
(define-key company-active-map (kbd "ESC ESC") 'company-abort)
(define-key-with-modifier "M-" company-active-map nil "C-e" 'company-select-previous-or-abort)
(define-key-with-modifier "M-" company-active-map nil "C-d" 'company-select-next-or-abort)
(define-key-with-modifier "M-" company-active-map nil "TAB" 'company-complete-common)
(define-key-with-modifier "M-" company-active-map nil "RET" 'company-complete-selection)

(provide 'bindings-company)

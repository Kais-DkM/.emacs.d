(require 'tabbar)

(setf (cdr tabbar-mode-map) nil)

(define-key tabbar-mode-map (kbd "M-g j") 'tabbar-backward-tab)
(define-key tabbar-mode-map (kbd "M-g l") 'tabbar-forward-tab)
(define-key tabbar-mode-map (kbd "M-g i") 'tabbar-backward-group)
(define-key tabbar-mode-map (kbd "M-g k") 'tabbar-forward-group)
(define-key tabbar-mode-map (kbd "<C-prior>") 'tabbar-backward-tab)
(define-key tabbar-mode-map (kbd "<C-next>") 'tabbar-forward-tab)
(define-key tabbar-mode-map (kbd "<C-home>") 'tabbar-backward-group)
(define-key tabbar-mode-map (kbd "<C-end>") 'tabbar-forward-group)

(provide 'bindings-tabbar)

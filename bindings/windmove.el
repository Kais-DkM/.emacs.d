(require 'bindings-evil)
(require 'windmove)

(satan-define-key nil "J" 'windmove-left)
(satan-define-key nil "L" 'windmove-right)
(satan-define-key nil "I" 'windmove-up)
(satan-define-key nil "K" 'windmove-down)

(provide 'bindings-windmove)

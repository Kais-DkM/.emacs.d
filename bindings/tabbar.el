(require 'bindings-evil)

(setq tabbar-mode-map (make-sparse-keymap))
(setq tabbar-prefix-map (make-sparse-keymap))

(satan-define-key nil "g j" 'tabbar-backward-tab)
(satan-define-key nil "g l" 'tabbar-forward-tab)
(satan-define-key nil "g i" 'tabbar-backward-group)
(satan-define-key nil "g k" 'tabbar-forward-group)
(satan-define-key t   "<C-prior>" 'tabbar-backward-tab)
(satan-define-key t   "<C-next>" 'tabbar-forward-tab)
(satan-define-key t   "<C-home>" 'tabbar-backward-group)
(satan-define-key t   "<C-end>" 'tabbar-forward-group)

(provide 'bindings-tabbar)

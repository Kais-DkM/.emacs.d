(require 'bindings-evil)
(require 'undo-tree)

(setq undo-tree-map (make-sparse-keymap))

(satan-define-key nil "u" 'undo-tree-undo)
(satan-define-key nil "r" 'undo-tree-redo)

(provide 'bindings-undo-tree)

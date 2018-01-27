(require 'bindings-evil)
(require 'undo-tree)

(setq undo-tree-map (make-sparse-keymap))

(satan-define-key nil "u" 'undo-tree-undo)
(satan-define-key nil "r" 'undo-tree-redo)
(satan-define-key nil "U" 'undo-tree-visualize)
(satan-define-key nil "R" 'undo-tree-visualize)

(provide 'bindings-undo-tree)

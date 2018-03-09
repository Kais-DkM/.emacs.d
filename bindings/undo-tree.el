(require 'undo-tree)

(setq undo-tree-map (make-sparse-keymap))

(define-key undo-tree-map [remap undo] 'undo-tree-undo)
(define-key undo-tree-map (kbd "M-u") 'undo-tree-undo)
(define-key undo-tree-map (kbd "M-r") 'undo-tree-redo)
(define-key undo-tree-map (kbd "M-U") 'undo-tree-visualize)
(define-key undo-tree-map (kbd "M-R") 'undo-tree-visualize)

(provide 'bindings-undo-tree)

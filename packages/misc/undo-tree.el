(require 'req-package)
(require 'moderator)

(req-package undo-tree
  :config
  (setq undo-tree-map (make-sparse-keymap))
  ;; (setq undo-tree-visualizer-mode-map (make-sparse-keymap))
  ;; (setq undo-tree-visualizer-selection-mode-map (make-sparse-keymap))
  (define-key undo-tree-map [remap undo] 'undo-tree-undo)
  (define-key undo-tree-map [remap redo] 'undo-tree-redo)
  (global-undo-tree-mode t))

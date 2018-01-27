(require 'themes-init)

(deftheme base "Base Theme")

(custom-theme-set-faces
 'base
 '(default ((t :background "black" :foreground "gray97")))
 '(cursor ((t :background "light gray")))
 `(region ((t :background ,(rgba-to-rgb "#DDF0FF33" "#000000"))))
 ;; font-lock-warning-face
 ;; todo : add italic
 '(font-lock-function-name-face ((t :foreground "#89BDFF")))
 '(font-lock-variable-name-face ((t :foreground "#3E87E3")))
 '(font-lock-keyword-face ((t :foreground "#E28964")))
 '(font-lock-comment-face ((t :foreground "dark gray")))
 ;; font-lock-comment-delimiter-face
 '(font-lock-type-face ((t :foreground "#99CF50")))
 '(font-lock-constant-face ((t :foreground "#3387CC")))
 '(font-lock-builtin-face ((t :foreground "#DAD085")))
 ;; font-lock-preprocessor-face
 '(font-lock-string-face ((t :foreground "#65B042")))
 ;; font-lock-doc-face
 ;; font-lock-negation-char-face
)

(provide-theme 'base)

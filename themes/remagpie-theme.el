(deftheme remagpie "Remagpie Custom Theme")

(custom-theme-set-faces
 'remagpie
 '(default ((t :background "black" :foreground "white")))
 '(cursor ((t :background "gray")))
 '(region ((t :background "gray20")))
 '(font-lock-function-name-face ((t :foreground "#A6E22E")))
 ;;font-lock-variable-name-face
 '(font-lock-keyword-face ((t :foreground "#F92672")))
 '(font-lock-comment-face ((t :foreground "#75712E")))
 '(font-lock-type-face ((t :foreground "#66D9EF")))
 '(font-lock-constant-face ((t :foreground "#AE81FF")))
 '(font-lock-string-face ((t :foreground "#E6DB74")))
 '(scroll-bar ((t :background "#090B0D" :foreground "#1B2123"))))

(provide-theme 'remagpie)

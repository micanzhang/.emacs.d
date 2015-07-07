(require-package 'w3m)

(setq gnus-mime-display-multipart-related-as-mixed nil)
(setq mm-text-html-renderer 'w3m)
(setq mm-inline-text-html-with-images t)
(setq mm-inline-text-html-with-w3m-keymap nil)

(provide 'init-w3m)

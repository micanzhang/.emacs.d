(require-package 'go-mode)
(add-hook 'before-save-hook 'gofmt-before-save)

(provide 'init-go)

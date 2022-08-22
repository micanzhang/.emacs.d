;;; golang configuration.
(require-package 'go-mode)

(defun set-default-goenv ()
  (interactive)
  (when (memq window-system '(mac ns))
    (exec-path-from-shell-initialize)
    (exec-path-from-shell-copy-env "GOPATH")
    (exec-path-from-shell-copy-env "GOPRIVATE")
    (exec-path-from-shell-copy-env "GOPROXY")
    (exec-path-from-shell-copy-env "CGO_ENABLED")))

(set-default-goenv)

(add-hook 'go-mode-hook 'lsp-deferred)
(add-hook 'go-mode-hook (lambda ()
                          (if (not (string-match "go" compile-command))
                              (set (make-local-variable 'compile-command)
                                   "go test -v"))
                          (local-set-key (kbd "C-c C-c") 'compile)
                          (local-set-key (kbd "C-c C-e") 'gorun)
                          (add-hook 'before-save-hook #'lsp-format-buffer t t)
                          (add-hook 'before-save-hook #'lsp-organize-imports t t)))

(defun gorun ()
  (interactive)
  (shell-command (format "go run %s"  (buffer-file-name))))

(provide 'init-go)
;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; init-go ends here

;;; golang configuration.
(defun set-default-goenv ()
  (interactive)
  (when (memq window-system '(mac ns))
    (exec-path-from-shell-initialize)
    (exec-path-from-shell-copy-env "GOPATH")
    (exec-path-from-shell-copy-env "GOPRIVATE")
    (exec-path-from-shell-copy-env "GOPROXY")
    (exec-path-from-shell-copy-env "CGO_ENABLED")))

(set-default-goenv)

(defun my-eglot-organize-imports () (interactive)
       (eglot-code-actions nil nil "source.organizeImports" t))


(add-hook 'go-mode-hook 'eglot-ensure)
(add-hook 'go-mode-hook (lambda ()
                          (if (not (string-match "go" compile-command))
                              (set (make-local-variable 'compile-command)
                                   "go test -v"))
                          (setq tab-width 4)
                          (setq-default eglot-workspace-configuration
                                        '((:gopls .
                                                  ((staticcheck . t)
                                                   (usePlaceholders . t)
                                                   (env . ((GOFLAGS . "-tags=integration,smoke,smoketf")))
                                                   (analyses .
                                                             ((unusedparams . t)
                                                              (unusedvariable . t)
                                                              (nilness . t)))))))
                          (local-set-key (kbd "C-c C-c") 'compile)
                          (local-set-key (kbd "C-c C-e") 'gorun)
                          (add-hook 'before-save-hook 'my-eglot-organize-imports nil t)
                          (add-hook 'before-save-hook #'eglot-format-buffer -10 t)
                          ))

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

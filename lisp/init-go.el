;;;init mode for google golang code which
;;;depend on http://tleyden.github.io/blog/2014/05/22/configure-emacs-as-a-go-editor-from-scratch/
;;; make sure all those go packages installed or just install as followed:
;;; go get -u github.com/stamblerre/gocode
;;; go get -u golang.org/x/tools/cmd/guru
;;; go get -u github.com/rogpeppe/godef
;;; go get -u golang.org/x/tools/cmd/goimports
;;; go get -u golang.org/x/tools/cmd/gorename
;;;
;;; make sure $PATH include $GOPATH/bin
;;; export PATH=$PATH:$GOPATH/bin
(require-package 'go-mode)
(require-package 'lsp-mode)
(require-package 'lsp-ui)

(defun set-default-goenv ()
  (interactive)
  (when (memq window-system '(mac ns))
    (exec-path-from-shell-initialize)
    (exec-path-from-shell-copy-env "GOPATH")
    (exec-path-from-shell-copy-env "GOPRIVATE")
    (exec-path-from-shell-copy-env "CGO_ENABLED")))

(set-default-goenv)


(add-hook 'go-mode-hook 'lsp-deferred)
(add-hook 'go-mode-hook (lambda ()
                          (if (not (string-match "go" compile-command))
                              (set (make-local-variable 'compile-command)
                                   "go test -v"))
                          (setq lsp-ui-doc-delay 1
                                lsp-ui-doc-max-height 8
                                lsp-ui-sideline-delay 2
                                lsp-ui-sideline-show-code-actions nil
                                lsp-ui-sideline-show-hover nil)
                          ;;   ;; call gofmt before saving
                          ;;(add-hook 'before-save-hook 'gofmt-before-save)
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

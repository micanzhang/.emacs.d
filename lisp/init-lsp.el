;;; init-lsp.el --- language server configs -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

(require-package 'lsp-mode)

(with-eval-after-load 'lsp-mode
  (setq lsp-completion-provider :capf
        lsp-keep-workspace-alive nil
        lsp-auto-guess-root t
        lsp-file-watch-threshold 65535)
  (dolist (dir '(
                 "[/\\\\]bazel-*"
                 "[/\\\\]\\.cache"
                 "[/\\\\]\\.cover"
                 "[/\\\\]vendor"
                 "[/\\\\]mod" ;;; ignore $GOPATH/pkg/mod
                 ))
    (push dir lsp-file-watch-ignored)))

(provide 'init-lsp)
;;; init-lsp.el ends here

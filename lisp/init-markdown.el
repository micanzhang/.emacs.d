(when (maybe-require-package 'markdown-mode)
  (after-load 'whitespace-cleanup-mode
    (push 'markdown-mode whitespace-cleanup-mode-ignore-modes)))

(maybe-require-package 'gh-md)
(maybe-require-package 'markdown-preview-mode)
(provide 'init-markdown)

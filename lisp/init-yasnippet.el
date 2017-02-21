(require-package 'yasnippet)

;; customize snippet dirs
(let ((snippets-dir "~/Documents/keep/snippets"))
  (when (file-exists-p snippets-dir)
    (setq yas-snippet-dirs '(snippets-dir yas-installed-snippets-dir))))

;; enable global mode
(yas-global-mode 1)

(provide 'init-yasnippet)

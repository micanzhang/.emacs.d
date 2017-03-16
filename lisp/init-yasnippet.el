(require-package 'yasnippet)

;; customize snippet dirs
(let ((snippets-dir "~/Dropbox/keep/snippets"))
  (when (file-exists-p snippets-dir)
    (setq yas-snippet-dirs '("~/Dropbox/keep/snippets" yas-installed-snippets-dir))))

;; enable global mode
(yas-global-mode 1)

(provide 'init-yasnippet)

(require-package 'yasnippet)
(require-package 'yasnippet-snippets)

;; customize snippet dirs
(let ((snippets-dir "~/Google Drive/keep/snippets"))
  (when (file-exists-p snippets-dir)
    (setq yas-snippet-dirs '("~/Google Drive/keep/snippets" yasnippet-snippets-dir))))

;; enable global mode
(yas-global-mode 1)

(provide 'init-yasnippet)

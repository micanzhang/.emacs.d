(require-package 'elfeed)
(require-package 'elfeed-org)

(when (file-exists-p "~/Dropbox/keep/feed.org")
  (setq rmh-elfeed-org-files (list "~/Dropbox/keep/feed.org")))

(provide 'init-feed)

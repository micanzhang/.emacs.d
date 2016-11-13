;;; package --- Summary
;;; Commentary:
;;; Code:
(require-package 'bbdb)
(require-package 'bbdb-china)


(add-hook 'gnus-group-mode-hook 'gnus-topic-mode)
(setq bbdb-file "~/.bbdb.db")
(bbdb-initialize 'message 'gnus)
(bbdb-mua-auto-update-init 'message 'gnus) ;; use 'gnus for incoming messages too
(setq bbdb-update-records-p 'create)
(setq bbdb-mua-auto-update-p 'create) ;; or 'create to create without asking
(setq bbdb-ignore-message-alist '((("To" "CC") . "jira@qiniu.com|noreply@email.qiniu.com|ci@qiniu.com|builds@travis-ci.com")))


(add-hook 'gnus-startup-hook 'bbdb-insinuate-gnus)
(add-hook 'message-mode-hook
          '(lambda ()
             (flyspell-mode t)
             (local-set-key "<TAB>" 'bbdb-complete-name)))
(add-hook 'message-mode-hook
          (lambda ()
            (local-set-key "\C-c\M-o" 'org-mime-htmlize)))

(setq gnus-score-find-score-files-function
      '(gnus-score-find-hierarchical gnus-score-find-bnews bbdb/gnus-score))


(provide 'init-gnus)
;;; init-gnus ends here

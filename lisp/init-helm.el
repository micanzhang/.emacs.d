(require-package 'helm)
(require 'helm-config)

(require-package 'helm-ag)

(global-set-key (kbd "M-x")  #'helm-M-x)
(global-set-key (kbd "C-x C-f") #'helm-find-files)
;;(global-set-key (kbd "C-x M-f") #'find-alternate-file)
(provide 'init-helm)


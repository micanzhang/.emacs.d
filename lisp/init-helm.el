(require-package 'helm)
(require 'helm-config)

(require-package 'ag)
(require-package 'helm-ag)
(require-package 'helm-gtags)

(with-eval-after-load 'helm-gtags
  (define-key helm-gtags-mode-map (kbd "C-c g a") 'helm-gtags-tags-in-this-function)
  (define-key helm-gtags-mode-map (kbd "C-j") 'helm-gtags-select)
  (define-key helm-gtags-mode-map (kbd "M-.") 'helm-gtags-dwim)
  (define-key helm-gtags-mode-map (kbd "M-,") 'helm-gtags-pop-stack)
  (define-key helm-gtags-mode-map (kbd "C-c <") 'helm-gtags-previous-history)
  (define-key helm-gtags-mode-map (kbd "C-c >") 'helm-gtags-next-history))

(global-set-key (kbd "M-x")  #'helm-M-x)
(global-set-key (kbd "C-x C-f") #'helm-find-files)
;;(global-set-key (kbd "C-x M-f") #'find-alternate-file)
(provide 'init-helm)


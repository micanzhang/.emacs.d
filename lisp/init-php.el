(require-package 'php-mode)
(require-package 'ac-php)

(add-hook 'php-mode-hook
          '(lambda ()
             (require 'company-php)
             (company-mode t)
             (add-to-list 'company-backends 'company-ac-php-backend)
             ;; set key binding
             (local-set-key (kbd "M-.") 'ac-php-find-symbol-at-point)
             (local-set-key (kbd "M-,") 'ac-php-location-stack-back)
             (local-set-key (kbd "C-c C-g") 'ac-php-remake-tags-all)
             ))

(provide 'init-php)

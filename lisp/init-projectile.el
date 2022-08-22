;;; init-projectile.el --- Use Projectile for navigation within projects -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

(when (maybe-require-package 'projectile)
  (add-hook 'after-init-hook 'projectile-mode)

  ;; Shorter modeline
  (setq-default projectile-mode-line-prefix " Proj")

  (when (executable-find "rg")
    (setq-default projectile-generic-command "rg --files --hidden"))

  (with-eval-after-load 'projectile
    (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map))

  (maybe-require-package 'ibuffer-projectile))


(eval-after-load "projectile"
  '(setq magit-repository-directories
         (mapcar
          #'directory-file-name
          (cl-remove-if-not
           (lambda (project)
             (file-directory-p (concat project "/.git/")))
           (projectile-relevant-known-projects)))
         magit-repository-directories-depth 1
         projectile-switch-project-action 'projectile-dired))


(provide 'init-projectile)
;;; init-projectile.el ends here

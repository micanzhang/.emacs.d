(when (maybe-require-package 'projectile)
  (add-hook 'after-init-hook 'projectile-mode)

  ;; Shorter modeline
  (setq-default projectile-mode-line-prefix " Proj")

  (after-load 'projectile
    (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map))

  (maybe-require-package 'ibuffer-projectile))

(projectile-mode +1)

;; (require-package 'projectile-mode)
;; ;; use os native index method for best perfpormance
;; (setq projectile-indexing-method 'native)
;; ;; jump to root directory of project instead of open project file
;; (setq projectile-switch-project-action 'projectile-dired)
;; ;; set grizzl as default completion option
;; (setq projectile-completion-system 'ivy)
;; (setq projectile-enable-caching t)
;; ;; The following code means you get a menu if you hit "C-c p" and wait
;; ;; (after-load 'guide-key
;; ;;   (add-to-list 'guide-key/guide-key-sequence "C-c p"))
;; (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
;; (projectile-mode +1)

(eval-after-load "projectile"
  '(setq magit-repository-directories (mapcar #'directory-file-name
                                              (cl-remove-if-not (lambda (project)
                                                                  (file-directory-p (concat project "/.git/")))
                                                                (projectile-relevant-known-projects)))
         projectile-completion-system 'ivy
         magit-repository-directories-depth 1
         projectile-switch-project-action 'projectile-dired
         ))


(provide 'init-projectile)

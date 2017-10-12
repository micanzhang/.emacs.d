(require-package 'grizzl)

(when (maybe-require-package 'projectile)
  (add-hook 'after-init-hook 'projectile-mode)

  ;; use os native index method for best performance
  (setq projectile-indexing-method 'native)

  ;; jump to root directory of project instead of open project file
  (setq projectile-switch-project-action 'projectile-dired)

  ;; set grizzl as default completion option
  (setq projectile-completion-system 'grizzl)

  ;; The following code means you get a menu if you hit "C-c p" and wait
  (after-load 'guide-key
    (add-to-list 'guide-key/guide-key-sequence "C-c p"))

  ;; Shorter modeline
  (after-load 'projectile
    (setq-default
     projectile-mode-line
     '(:eval
       (if (file-remote-p default-directory)
           " Pr"
         (format " Pr[%s]" (projectile-project-name)))))))

(eval-after-load "projectile"
  '(setq magit-repository-directories (mapcar #'directory-file-name
                                              (cl-remove-if-not (lambda (project)
                                                                  (file-directory-p (concat project "/.git/")))
                                                                (projectile-relevant-known-projects)))

         magit-repository-directories-depth 1))


(provide 'init-projectile)

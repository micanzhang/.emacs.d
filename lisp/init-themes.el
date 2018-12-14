(add-to-list 'custom-theme-load-path (concat user-emacs-directory "/theme"))
(require-package 'color-theme-sanityinc-solarized)
(require-package 'color-theme-sanityinc-tomorrow)
(require-package 'material-theme)
(require-package 'ample-theme)
(require-package 'afternoon-theme)
(require-package 'leuven-theme)
(require-package 'emojify)
(load-theme 'me t t)

;; If you don't customize it, this is the theme you get.
(setq-default custom-enabled-themes '(sanityinc-tomorrow-night))


;; Ensure that themes will be applied even if they have not been customized
(defun reapply-themes ()
  "Forcibly load the themes listed in `custom-enabled-themes'."
  (dolist (theme custom-enabled-themes)
    (unless (custom-theme-p theme)
      (load-theme theme)))
  (custom-set-variables `(custom-enabled-themes (quote ,custom-enabled-themes))))

(add-hook 'after-init-hook 'reapply-themes)


;;------------------------------------------------------------------------------
;; Toggle between light and dark
;;------------------------------------------------------------------------------
(defun light ()
  "Activate a light color theme."
  (interactive)
  (setq custom-enabled-themes '(sanityinc-tomorrow-day))
  (reapply-themes))

(defun dark ()
  "Activate a dark color theme."
  (interactive)
  (setq custom-enabled-themes '(sanityinc-tomorrow-bright))
  (reapply-themes))


(when (maybe-require-package 'dimmer)
  (setq-default dimmer-fraction 0.15)
  (add-hook 'after-init-hook 'dimmer-mode)
  ;; TODO: file upstream as a PR
  (after-load 'dimmer
    (advice-add 'frame-set-background-mode :after (lambda (&rest args) (dimmer-process-all)))))


;;------------------------------------------------------------------------------
;; Toggle next theme recyclying
;;------------------------------------------------------------------------------
(defun next-theme ()
  "Activate next theme."
  (interactive)
  (let* ((themes (custom-available-themes))
         (count (length themes))
         (index 0))
    (setq index (+ 1 (position (car custom-enabled-themes) themes)))
    (when (equal index count)
      (setq index 0))
    (let ((themes (custom-available-themes)))
      (while themes
        (disable-theme (car themes))
        (setq themes (cdr themes))))
    (let ((theme (nth index themes)))
      (load-theme theme t nil))))



;;------------------------------------------------------------------------------
;; Set theme interactively
;;------------------------------------------------------------------------------

(defun set-theme (theme)
  (interactive (list
                (intern (completing-read "Set theme: "
                                         (mapcar 'symbol-name
                                                 (custom-available-themes))))))
  (unless (memq theme custom-enabled-themes)
    ;; disable all themes
    (let ((themes custom-enabled-themes))
      (while themes
        (disable-theme (car themes))
        (setq themes (cdr themes))))
    (load-theme theme t nil)))

(provide 'init-themes)

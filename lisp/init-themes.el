(add-to-list 'custom-theme-load-path (concat user-emacs-directory "/theme"))

(when (< emacs-major-version 24)
  (require-package 'color-theme))


(require-package 'color-theme-sanityinc-solarized)
(require-package 'color-theme-sanityinc-tomorrow)
(require-package 'material-theme)
(require-package 'ample-theme)
(load-theme 'me t)
;;(require-package 'arjen-grey)

;; If you don't customize it, this is the theme you get.
(setq-default custom-enabled-themes '(me))

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
  (color-theme-sanityinc-solarized-light))

(defun dark ()
  "Activate a dark color theme."
  (interactive)
  (color-theme-sanityinc-solarized-dark))

;;--------------------------------------------------------------------------------
;; cycle all avaiable themes by C-c C-t
;;--------------------------------------------------------------------------------
;;(setq cycle-themes-theme-list (custom-available-themes)) ; default set themes with all available themes
;; TODO bugfix cycle-themes-get-next-valid-theme: No valid themes in cycle-themes-theme-list
;;(setq cycle-themes-theme-list '(me color-theme-sanityinc-solarized-light color-theme-sanityinc-solarized-dark color-theme-sanityinc-tomorrow-night))
;; (require-package 'cycle-themes)
;; (cycle-themes-mode)

(provide 'init-themes)

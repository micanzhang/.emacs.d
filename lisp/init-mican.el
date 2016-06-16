;;; all my customrize emacs lisp code

;;================================================================================
;;       set proxy
;;================================================================================
;; http://aaronaddleman.com/articles/setting-your-proxy-server-variable-in-emacs/
;; looks like this approach more useable.
;; (setq url-proxy-services
;;       '(("no_proxy" . "^\\(localhost\\|10.*\\)")
;;         ("http" . "localhost:8016")
;;         ("https" . "localhost:8016")))


(defun toggle-proxy ()
  (interactive)
  ;;toggle proxy setting for emacs use, skip localhost
  (if url-proxy-services (setq url-proxy-services nil)
    (setq url-proxy-services
          '(("no_proxy" . "^\\(localhost\\|10.*\\)")
            ("http" . "127.0.0.1:8016")
            ("https" . "127.0.0.1:8016")))
    )
  )

;;(toggle-proxy)
(require-package 'powerline)
(powerline-default-theme)

(provide 'init-mican)

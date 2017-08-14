;; tutorial: https://medium.com/@kirang89/emacs-as-email-client-with-offlineimap-and-mu4e-on-os-x-3ba55adc78b6
(add-to-list 'load-path "/usr/local/share/emacs/site-lisp/mu/mu4e")

(autoload 'mu4e "mu4e" "mu for Emacs." t)
(setq mu4e-date-format-long "%Y-%m-%d %H:%M:%S")
(setq mu4e-headers-date-format "%y%m%d %H:%M:%S")
(setq mu4e-view-show-images t)

;; Silly mu4e only shows names in From: by default. Of course we also
;; want the addresses.
(setq mu4e-view-show-addresses t)

;;; Default html2text is no good. Can't use shr since I don't link
;;; Emacs with libxml2. So use w3m instead.
(setq mu4e-html2text-command "w3m -I utf8 -O utf8 -T text/html")

(setq mu4e-maildir       "~/Mail"   ;; top-level Maildir
      mu4e-sent-folder   "/Mu4e/sent"       ;; folder for sent messages
      mu4e-drafts-folder "/Mu4e/drafts"     ;; unfinished messages
      mu4e-trash-folder  "/Mu4e/trash"      ;; trashed messages
      mu4e-refile-folder "/Mu4e/archive"
      mu4e-sent-messages-behavior 'delete
      mu4e-get-mail-command "offlineimap"
      mu4e-mu-binary "/usr/local/bin/mu"
      )


;;To set gmail smtp details
(defun setGmail ()
  (interactive)
  (message "from: "  (message-field-value "From"))
  (message "to: "  (message-field-value "to"))
  (message "subject: "  (message-field-value "Subject"))
  (message "send by gmail")
  (setq user-mail-address "micanzhang@gmail.com")
  (setq user-full-name "Mican Zhang")
  (setq message-send-mail-function 'smtpmail-send-it
        smtpmail-default-smtp-server "smtp.gmail.com"
        smtpmail-smtp-server "smtp.gmail.com"
        smtpmail-smtp-service 587
        smtpmail-local-domain "gmail.com"))


;;(add-hook 'message-send-hook 'setQiniu)
;;Select automatically while replying
(add-hook 'message-send-hook
          '(lambda ()
             (message "from: "  (message-field-value "from"))
             (message "to: "  (mail-fetch-field "to"))
             (message "subject: "  (message-fetch-field "subject"))
             (let ((from (message-fetch-field "from")))
               (if (and from (string-match "qiniu" from))
                   (setQiniu)
                 (setGmail)))))

(global-set-key (kbd "C-x M-m") 'mu4e)

(provide 'init-mu4e)

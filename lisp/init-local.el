(defun setenviron (list)
  (interactive)
  ;;; setenv by source bashrc
  (while list
    (setq key (car list))
    (setq value (concat "source ~/.bashrc; echo -n $" key))
    (if key
        (setenv key (shell-command-to-string value)))
    (setq list (cdr list))))

(defun copy-file-name-on-clipboard ()
  "Put the current file name on the clipboard"
  (interactive)
  (let ((filename (if (equal major-mode 'dired-mode)
                      default-directory
                    (buffer-file-name))))
    (when filename
      (with-temp-buffer
        (insert filename)
        (clipboard-kill-region (point-min) (point-max)))
      (message filename))))

(defun set-gopath (args &optional)
  ;;;set gopath directly or by concat existed envs
  (setq args (cl-remove-if-not 'stringp args))
  (setenv "GOPATH"
          (mapconcat 'concat
                     (mapcar '(lambda (x) (if (getenv x) (getenv x) x)) args)
                     ":")))


(defun font-config ()
  (interactive)
  ;;english font test
  ;;中方字体测试
  ;;English Font
  (set-default-font "PT Mono-18")
  ;;(set-default-font "Monaco-18")
  (dolist (charset '(kana han symbol cjk-misc bopomofo))
    (set-fontset-font (frame-parameter nil 'font)
                      charset
                      (font-spec :family "Source Han Sans CN" :size 18)
                      )))
(defun sugar ()
  ;;autofill bracket pairs
  (electric-pair-mode 1))

;; mac switch meta key
(defun mac-switch-meta nil
  "switch meta between Option and Command"
  (interactive)
  (setq mac-option-modifier 'meta)
  (setq mac-command-modifier 'hyper)
  )

(sugar)
;; Save all tempfiles in $TMPDIR/emacs$UID/
(defconst emacs-tmp-dir (format "%s/%s%s/" temporary-file-directory "emacs" (user-uid)))
(setq backup-directory-alist
      `((".*" . ,emacs-tmp-dir)))
(setq auto-save-file-name-transforms
      `((".*" ,emacs-tmp-dir t)))
(setq auto-save-list-file-prefix
      emacs-tmp-dir)

;;(global-linum-mode t)
(mac-switch-meta)
(font-config)
(maximize-frame)

;;(require 'color-theme-tomorrow)
;;(color-theme-tomorrow--define-theme night)

(provide 'init-local)

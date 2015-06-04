(defun setenviron (list)
  (interactive)
  ;;; setenv by source bashrc
  (while list
    (setq key (car list))
    (setq value (concat "source ~/.bashrc; echo -n $" key))
    (if key 
        (setenv key (shell-command-to-string value)))
    (setq list (cdr list))))

(defun set-gopath (args &optional)
  (interactive "environiable or path:")
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
  (set-face-attribute 'default nil :family "Monaco")
  (set-face-attribute 'default nil :height 160)
  ;; Chinese Font
  (when (string-equal system-type "windows-nt")
    (dolist (charset '(kana han symbol cjk-misc bopomofo))
      (set-fontset-font (frame-parameter nil 'font)
                        charset
                        (font-spec :family "Noto Sans S Chinese" :size 14)))))

;;toggle GNU linux full screen
(defun toggle-gnu-linux-fullscreen ()
  (x-send-client-message nil 0 nil "_NET_WM_STATE" 32
                         '(2 "_NET_WM_STATE_MAXIMIZED_VERT" 0))
  (x-send-client-message nil 0 nil "_NET_WM_STATE" 32
                         '(2 "_NET_WM_STATE_MAXIMIZED_HORZ" 0)))

;;toggle windows nt full screen
(defun toggle-windows-nt-fullscreen ()
  (message "%s" system-type)
  (w32-send-sys-command 61488))

(defun toggle-fullscreen ()
  (interactive)
  ;;maxinum
  (if (string-equal system-type "windows-nt")
      (toggle-windows-nt-fullscreen)
    (if (string-equal system-type "darwin") (toggle-frame-maximized) (toggle-gnu-linux-fullscreen))))

(defun sugar ()
  ;;autofill bracket pairs
  (electric-pair-mode 1))
;(setenviron (list "GOHOME" "MYGOHOME" "QBASE" "QPORTAL" "QADMINPATH" "QPORTALPATH"))

(setq exec-path-from-shell-variables '("GOHOME" "MYGOHOME" "QBASE" "QPORTAL" "QADMINPATH" "QPORTALPATH"))
(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))

;(sugar)
(font-config)
(toggle-fullscreen)

(provide 'init-local)

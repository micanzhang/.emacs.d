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
  "Put the current file name on the clipboard."
  (interactive)
  (let ((filename (if (equal major-mode 'dired-mode)
                      default-directory
                    (buffer-file-name))))
    (when filename
      (with-temp-buffer
        (insert filename)
        (clipboard-kill-region (point-min) (point-max)))
      (message filename))))

(defun font-config ()
  (interactive)
  ;;english font test
  ;;中方字体测试
  ;; set default font size
  (set-face-attribute 'default nil :height 180)
  ;; set default font family
  (when (member "PT-Mono" (font-family-list))
    (set-face-attribute 'default nil :family "PT-Mono"))
  ;;(set-default-font "DejaVu Sans Mono-18")
  ;; set font family for unicode charset
  (when (member  "Noto Sans Mono CJK SC" (font-family-list))
    (dolist (charset '(kana han symbol cjk-misc bopomofo))
      (set-fontset-font (frame-parameter nil 'font)
                        charset
                        ;;(font-spec :family "SimHei" :size 22)
                        (font-spec :family "Noto Sans Mono CJK SC" :size 22)
                        ;;(font-spec :family "DejaVu Sans Mono" :size 14)
                        )))
  )
(defun sugar ()
  ;;autofill bracket pairs
  (electric-pair-mode 1))

;; mac switch meta key
(defun mac-switch-meta nil
  "Switch meta between Option and Command."
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

(mac-switch-meta)
(font-config)
(toggle-frame-fullscreen)
(global-hl-line-mode)
(menu-bar-mode -1)

(provide 'init-local)

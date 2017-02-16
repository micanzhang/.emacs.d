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
  (let ((font-family "DejaVu Sans Mono")
        (chinese-font-family "Source Han Sans CN")
        (font-size 18)
        (chinese-font-size 22)
        )
    (when *is-a-mac*
      (setq font-family "PT Mono")
      (setq chinese-font-family "PingFang SC")
      )
    ;;set english font
    (when (member font-family (font-family-list))
      (set-frame-font (format "%s:pixelsize=%d" font-family font-size))
      )
    ;;set chinese font
    (when (member chinese-font-family (font-family-list))
      (dolist (charset '(kana han symbol cjk-misc bopomofo))
        (set-fontset-font
         (frame-parameter nil 'font)
         charset
         (font-spec :name chinese-font-family
                    :weight 'normal
                    :slant 'normal
                    :size chinese-font-size))))))

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

;; Save all tempfiles in $TMPDIR/emacs$UID/
(defconst emacs-tmp-dir (format "%s/%s%s/" temporary-file-directory "emacs" (user-uid)))
(setq backup-directory-alist
      `((".*" . ,emacs-tmp-dir)))
(setq auto-save-file-name-transforms
      `((".*" ,emacs-tmp-dir t)))
(setq auto-save-list-file-prefix
      emacs-tmp-dir)

(when *is-a-mac*
  (mac-switch-meta))
(sugar)
(font-config)
(toggle-frame-fullscreen)
(global-hl-line-mode)
(menu-bar-mode -1)

(provide 'init-local)

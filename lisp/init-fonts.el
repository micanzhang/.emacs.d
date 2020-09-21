;;; Changing font sizes

(require-package 'default-text-scale)
(add-hook 'after-init-hook 'default-text-scale-mode)


(defun sanityinc/maybe-adjust-visual-fill-column ()
  "Readjust visual fill column when the global font size is modified.
This is helpful for writeroom-mode, in particular."
  ;; TODO: submit as patch
  (if visual-fill-column-mode
      (add-hook 'after-setting-font-hook 'visual-fill-column--adjust-window nil t)
    (remove-hook 'after-setting-font-hook 'visual-fill-column--adjust-window t)))

(add-hook 'visual-fill-column-mode-hook
          'sanityinc/maybe-adjust-visual-fill-column)


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
      ;;(setq font-family "Fira Code")
      (setq font-family "PT Mono")
      ;;(setq font-family "Go Mono")
      (setq chinese-font-family "PingFang SC")
      )
    ;;set english font
    (when (member font-family (font-family-list))
      (set-frame-font (format "%s:pixelsize=%d" font-family font-size)))
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

(font-config)

(provide 'init-fonts)

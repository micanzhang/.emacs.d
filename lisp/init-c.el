;; refer to: https://www.youtube.com/watch?v=HTUE03LnaXA&list=PL-mFLc7R_MJet8ItKipCtYc7PWoS5KTfM
(require-package 'company-c-headers)
;;(require-package 'flymake-google-cpplint)
;;(require-package 'flymake-cursor)
(require-package 'google-c-style)
(require-package 'irony)
(require-package 'company-irony)
(require-package 'flycheck-irony)
(require-package 'irony-eldoc)
(require-package 'ggtags)
(require-package 'clang-format)

(add-hook 'c-mode-common-hook
          (lambda ()
            (when (derived-mode-p 'c-mode 'c++-mode)
              (ggtags-mode 1))))

;; auto format
(add-hook 'c-mode-common-hook
          (function (lambda ()
                      (add-hook 'before-save-hook
                                'clang-format-buffer))))

;; add `company-c-headers' library to load-path
(defun my:company-c-headers ()
  (add-to-list 'company-backends 'company-c-headers))
(add-hook 'c-mode-hook 'my:company-c-headers)

;; (when (and *is-a-mac* (file-exists-p "/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/lib/clang/13.0.0/include/"))
;;   (add-to-list 'company-c-headers-path-system "/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/lib/clang/13.0.0/include/"))
;; install cpplint by run: sudo pip install cpplint
;;(add-hook 'c-mode-hook 'flymake-google-cpplint-load)
;; default flymake-google-cpplint-command is cpplint.py
;; (custom-set-variables
;;  '(flymake-google-cpplint-command "cpplint"))

(eval-after-load 'company
  '(add-to-list 'company-backends 'company-irony))

(add-hook 'c-mode-common-hook 'google-set-c-style)
(add-hook 'c-mode-common-hook 'google-make-newline-indent)
;; gtags required, https://gist.github.com/carakan/60496e0f05033417be2352419639fcc5


(add-hook 'c-mode-hook 'irony-mode)

(provide 'init-c)

;; refer to: https://www.youtube.com/watch?v=HTUE03LnaXA&list=PL-mFLc7R_MJet8ItKipCtYc7PWoS5KTfM
(require-package 'company-c-headers)
(require-package 'flymake-google-cpplint)
(require-package 'flymake-cursor)
(require-package 'google-c-style)
(require-package 'irony)
(require-package 'company-irony)
(require-package 'flycheck-irony)
(require-package 'irony-eldoc)

;; add `company-c-headers' library to load-path
(add-to-list 'company-backends 'company-c-headers)
;; TODO: handle different os
(add-to-list 'company-c-headers-path-system "/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/../lib/clang/8.0.0/include")

;; install cpplint by run: sudo pip install cpplint
(add-hook 'c-mode-hook 'flymake-google-cpplint-load)
;; default flymake-google-cpplint-command is cpplint.py
(custom-set-variables
 '(flymake-google-cpplint-command "cpplint"))

(add-hook 'c-mode-common-hook 'google-set-c-style)
(add-hook 'c-mode-common-hook 'google-make-newline-indent)
(add-hook 'c-mode-hook 'irony-mode)

;; replace the `completion-at-point' and `complete-symbol' bindings in
;; irony-mode's buffers by irony-mode's function
(defun my-irony-mode-hook ()
  (define-key irony-mode-map [remap completion-at-point]
    'irony-completion-at-point-async)
  (define-key irony-mode-map [remap complete-symbol]
    'irony-completion-at-point-async))
(add-hook 'irony-mode-hook 'my-irony-mode-hook)
(add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)

(provide 'init-c)

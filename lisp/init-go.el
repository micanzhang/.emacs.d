;;;init mode for google golang code which
;;;depend on http://tleyden.github.io/blog/2014/05/22/configure-emacs-as-a-go-editor-from-scratch/

;; go-mode 
(require-package 'go-mode)

;; go-autocomplete
(require-package 'go-autocomplete)
(require 'auto-complete-config)
(ac-config-default)

(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize)
  (exec-path-from-shell-copy-env "GOPATH"))
;; for windows user 
;(defun set-exec-path-from-shell-PATH ()
;  (let ((path-from-shell (replace-regexp-in-string
;                          "[ \t\n]*$"
;                          ""
;                          (shell-command-to-string "$SHELL --login -i -c 'echo $PATH'"))))
;    (setenv "PATH" path-from-shell)
;    (setq eshell-path-env path-from-shell) ; for eshell users
;    (setq exec-path (split-string path-from-shell path-separator))))
;
;(when window-system (set-exec-path-from-shell-PATH))

;;make sure run ~$go get golang.org/x/tools/cmd/oracle
;;load oracle.el
(load-file "$GOPATH/src/golang.org/x/tools/cmd/oracle/oracle.el")

;;firstly, please esure godef existed,if not, run go get -v github.com/rogpeppe/godef
;;for some reason,you cannot run godef at emacs, a way to fix that is make a soft link to binary of godef

(defun my-go-mode-hook ()
  ;Call Gofmt before saving
  (add-hook 'before-save-hook 'gofmt-before-save)
  ; Customize compile command to run go build
  (if (not (string-match "go" compile-command))
      (set (make-local-variable 'compile-command)
           "go build -v && go test -v && go vet"))
  ; Godef jump key binding
  (local-set-key (kbd "C-x C-g") 'godef-jump)
  (local-set-key (kbd "C-x M-g") 'godef-jump-other-window)
  )
(add-hook 'go-mode-hook 'my-go-mode-hook)

(provide 'init-go)
;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; go-mode-load.el ends here

;;;init mode for google golang code which
;;;depend on http://tleyden.github.io/blog/2014/05/22/configure-emacs-as-a-go-editor-from-scratch/

(require-package 'go-mode)

(defun set-exec-path-from-shell-PATH ()
  (let ((path-from-shell (replace-regexp-in-string
                          "[ \t\n]*$"
                          ""
                          (shell-command-to-string "$SHELL --login -i -c 'echo $PATH'"))))
    (setenv "PATH" path-from-shell)
    (setq eshell-path-env path-from-shell) ; for eshell users
    (setq exec-path (split-string path-from-shell path-separator))))

(when window-system (set-exec-path-from-shell-PATH))

(setenv "GOPATH" "/Users/micanzhang/Code/golang")

(setq exec-path (cons "/usr/local/go/bin" exec-path))
(add-to-list 'exec-path "/Users/micanzhang/Code/golang/bin")
(add-hook 'before-save-hook 'gofmt-before-save)

(load-file "$GOPATH/src/golang.org/x/tools/cmd/oracle/oracle.el")

(defun my-go-mode-hook ()
  ; Godef jump key binding
  (local-set-key (kbd "F5") 'go-oracle-callers)
  (local-set-key (kbd "F6") 'go-oracle-callees)
  )

(add-hook 'go-mode-hook 'my-go-mode-hook)


;;firstly, please esure godef existed,if not, run go get -v github.com/rogpeppe/godef
;;for some reason,you cannot run godef at emacs, a way to fix that is make a soft link to binary of godef
(defun my-go-mode-hook ()
  ; Call Gofmt before saving
  (add-hook 'before-save-hook 'gofmt-before-save)
  ; Godef jump key binding
  (local-set-key (kbd "M-.") 'godef-jump))
(add-hook 'go-mode-hook 'my-go-mode-hook)

(load-file "$GOPATH/src/github.com/nsf/gocode/emacs/go-autocomplete.el")
;;(require 'go-autocomplete)
(require 'auto-complete-config)
(ac-config-default)

(defun my-go-mode-hook ()
  ;Call Gofmt before saving
  (add-hook 'before-save-hook 'gofmt-before-save)
  ; Customize compile command to run go build
  (if (not (string-match "go" compile-command))
      (set (make-local-variable 'compile-command)
           "go build -v && go test -v && go vet"))
  ; Godef jump key binding
  (local-set-key (kbd "M-.") 'godef-jump))
(add-hook 'go-mode-hook 'my-go-mode-hook)

(provide 'init-go)
;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; go-mode-load.el ends here

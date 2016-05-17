;;;init mode for google golang code which
;;;depend on http://tleyden.github.io/blog/2014/05/22/configure-emacs-as-a-go-editor-from-scratch/

;; set env
(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize)
  (exec-path-from-shell-copy-env "GOPATH"))

;; go-mode 
(require-package 'go-mode)

;; set GOPATH by run .env shell scripts
(defun set-current-gopath
    ()
  (interactive)
  (let (current-dir env_dir)
    (setq current-dir (file-name-directory buffer-file-name))
    (setq env-dir (locate-dominating-file current-dir ".env"))
    (let ((path-from-shell (replace-regexp-in-string "[ \t\n]*$" "" (shell-command-to-string (concat "$SHELL --login -i -c 'cd " env-dir ";source .env;echo $GOPATH'") ))))
      (setenv "GOPATH" path-from-shell)
      (message (getenv "GOPATH")))
    ))

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

;;make sure run: go get -u golang.org/x/tools/cmd/oracle
;;load oracle.el
(load-file "$GOPATH/src/golang.org/x/tools/cmd/oracle/oracle.el")

;;firstly, please ensure godef existed,if not, run go get -v github.com/rogpeppe/godef
;;for some reason,you cannot run godef at emacs, a way to fix that is make a soft link to binary of godef

;; go-autocomplete
;; run go get -u github.com/nsf/gocode
(load-file "$GOPATH/src/github.com/nsf/gocode/emacs/go-autocomplete.el")
;;(require-package 'go-autocomplete)
(require 'auto-complete-config)
(ac-config-default)

;;(require-package 'go-rename)

(defun my-go-mode-hook ()
  ;; Call Gofmt before saving
  ;; go get -u golang.org/x/tools/cmd/goimports
  (setq gofmt-command "goimports")
  (add-hook 'before-save-hook 'gofmt-before-save)
  ;; Customize compile command to run go build
  ;; TODO compile support makefile
  (if (not (string-match "go" compile-command))
      (set (make-local-variable 'compile-command)
           "go build -p 4 -v -race && go test -v -race"))
  ; Godef jump key binding
  (local-set-key (kbd "C-x C-g") 'godef-jump)
  (local-set-key (kbd "C-x M-g") 'godef-jump-other-window)
  (local-set-key (kbd "M-*") 'pop-tag-mark)
  (local-set-key (kbd "C-c C-g") 'set-current-gopath)
  (local-set-key (kbd "C-c C-c") 'compile)
  ; go-rename key binding
  ;;(local-set-key (kbd "C-c C-r") 'go-rename)
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

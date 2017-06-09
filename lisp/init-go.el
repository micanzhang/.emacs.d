;;;init mode for google golang code which
;;;depend on http://tleyden.github.io/blog/2014/05/22/configure-emacs-as-a-go-editor-from-scratch/
;;; make sure all those go packages installed or just install as followed:
;;; go get -u github.com/nsf/gocode
;;; go get -u golang.org/x/tools/cmd/guru
;;; go get -u github.com/rogpeppe/godef
;;; go get -u golang.org/x/tools/cmd/goimports
;;; go get -u golang.org/x/tools/cmd/gorename
;;;
;;; make sure $PATH include $GOPATH/bin
;;; export PATH=$PATH:$GOPATH/bin

;; install all pacakges 
(require-package 'go-mode)
(require-package 'go-guru)
(require-package 'company-go)
(require-package 'go-eldoc)
(require-package 'go-rename)
(require-package 'go-dlv)

;; set GOPATH by run .env shell scripts
(defun get-env (path)
  (cond ((or (string-equal path "/") (not (file-exists-p path))) nil)
        ((file-exists-p (concat path "/.env")) (concat path "/.env"))
        ((file-exists-p (concat path "/env.sh")) (concat path "/env.sh"))
        (t (get-env (file-name-directory (directory-file-name path))))))

(defun set-gopath (path)
  (let ((gopath (get-env path)))
    (unless gopath
      (setq gopath (concat (getenv "HOME") "/.profile")))
    (setenv "GOPATH" (string-trim (shell-command-to-string (concat "$SHELL --login -i -c 'cd " (file-name-directory (directory-file-name gopath)) ";source " gopath "; echo $GOPATH;'"))))))

(defun set-current-gopath ()
  (interactive) 
  (set-gopath (buffer-file-name))
  (message (getenv "GOPATH")))

(defun set-default-gopath ()
  (interactive)
  (when (memq window-system '(mac ns))
    (exec-path-from-shell-initialize)
    (exec-path-from-shell-copy-env "GOROOT")
    (exec-path-from-shell-copy-env "GOPATH")))

(set-default-gopath)

(defun my-go-mode-hook () 
  ;; use goimports instead gofmt which help fix packages import
  (setq gofmt-command "goimports")
  ;; call gofmt before saving
  (add-hook 'before-save-hook 'gofmt-before-save)
  ;; set compile command (C-c C-c)
  (if (not (string-match "go" compile-command))
      (set (make-local-variable 'compile-command)
           "go test -v"))
  (local-set-key (kbd "C-c C-c") 'compile)
  ;; jump to definition
  (local-set-key (kbd "M-.") 'godef-jump)
  ;; jump to definition by open other window
  (local-set-key (kbd "C-x M-.") 'godef-jump-other-window)
  ;; jump back
  (local-set-key (kbd "M-,") 'pop-tag-mark)
  ;; set gopath for current project
  (local-set-key (kbd "C-c C-g") 'set-current-gopath)
  ;; use default gopath
  (local-set-key (kbd "C-c C-r") 'go-rename)
  )

;; customrize config
(add-hook 'go-mode-hook 'my-go-mode-hook)
;; company auto complete
(add-hook 'go-mode-hook (lambda ()
                          (set (make-local-variable 'company-backends) '(company-go))
                          (company-mode)))
;; eldoc setup
(add-hook 'go-mode-hook 'go-eldoc-setup)

(provide 'init-go)
;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; init-go ends here

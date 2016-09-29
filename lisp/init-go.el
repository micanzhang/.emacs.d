;;;init mode for google golang code which
;;;depend on http://tleyden.github.io/blog/2014/05/22/configure-emacs-as-a-go-editor-from-scratch/

(defun set-default-gopath ()
  (interactive)
  (when (memq window-system '(mac ns))
    (exec-path-from-shell-initialize)
    (exec-path-from-shell-copy-env "GOPATH")
    )
  )

;; set GOPATH env
(set-default-gopath)

;; go-mode 
(require-package 'go-mode)
(require-package 'company-go)
(require-package 'go-eldoc)

;; set GOPATH by run .env shell scripts
(defun set-current-gopath
    ()
  (interactive)
  (when buffer-file-name
    (let (current-dir env-dir)
      (setq current-dir (file-name-directory buffer-file-name))
      (setq env-dir (locate-dominating-file current-dir ".env"))
      (when env-dir
        (let ((path-from-shell (replace-regexp-in-string "[ \t\n]*$" "" (shell-command-to-string (concat "$SHELL --login -i -c 'cd " env-dir ";source .env;echo $GOPATH'") ))))
          (setenv "GOPATH" path-from-shell)
          )
        )
      )
    )
  (message (getenv "GOPATH"))
  )


;;make sure run: go get -u golang.org/x/tools/cmd/guru
(let ((guru-path (concat (getenv "GOPATH") "/src/golang.org/x/tools/cmd/guru/go-guru.el")))
  (if  (file-exists-p guru-path)
      (load guru-path)
    (message "load " guru-path " failed")
    )
  )

;;(add-hook 'go-mode-hook 'go-oracle-mode)
;;firstly, please ensure godef existed,if not, run go get -v github.com/rogpeppe/godef
;;for some reason,you cannot run godef at emacs, a way to fix that is make a soft link to binary of godef

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
           "go build -p 4 -v -race && go test -v -race -cover && go vet"))
  (local-set-key (kbd "M-.") 'godef-jump) ; Godef jump key binding
  (local-set-key (kbd "C-x M-.") 'godef-jump-other-window)
  (local-set-key (kbd "M-,") 'pop-tag-mark)
  (local-set-key (kbd "C-c C-g") 'set-current-gopath)
  (local-set-key (kbd "C-c M-g") 'set-default-gopath)
  (local-set-key (kbd "C-c C-c") 'compile)
  )
(add-hook 'go-mode-hook (lambda ()
                          (set (make-local-variable 'company-backends) '(company-go))
                          (company-mode)))
(add-hook 'go-mode-hook 'go-eldoc-setup)
(add-hook 'go-mode-hook 'my-go-mode-hook)

(provide 'init-go)
;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; go-mode-load.el ends here

;;; init-rust --- config scripts for rust programming language

;; major mode
(require-package 'rust-mode)
;; racer supports code completaion of variables,functions and modules - https://github.com/racer-rust/emacs-racer
(require-package 'racer)
;; minor mode for cargo - https://github.com/kwrooijen/cargo.el
(require-package 'cargo)
;; flycheck supports - https://github.com/flycheck/flycheck-rust
(require-package 'flycheck-rust)

(defun cargo-process-script ()
  "Run the Cargo build command.
With the prefix argument, modify the command's invocation.
Cargo: Compile the current project."
  (interactive)
  (cargo-process--start "Script" (concat "cargo script " (buffer-file-name))))

(defun my:rust-hook ()
  (setq rust-format-on-save t
        company-tooltip-align-annotations t)
  (define-key rust-mode-map (kbd "TAB") #'company-indent-or-complete-common)
  (define-key rust-mode-map (kbd "C-c C-r") 'cargo-process-script))

(add-hook 'rust-mode-hook #'my:rust-hook)
(add-hook 'rust-mode-hook #'racer-mode)
(add-hook 'racer-mode-hook #'eldoc-mode)
(add-hook 'rust-mode-hook 'cargo-minor-mode)
(add-hook 'flycheck-mode-hook #'flycheck-rust-setup)

(provide `init-rust)

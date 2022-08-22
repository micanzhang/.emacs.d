;;; init-utils.el --- Elisp helper functions and commands -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

(define-obsolete-function-alias 'after-load 'with-eval-after-load "")

;;----------------------------------------------------------------------------
;; Handier way to add modes to auto-mode-alist
;;----------------------------------------------------------------------------
(defun add-auto-mode (mode &rest patterns)
  "Add entries to `auto-mode-alist' to use `MODE' for all given file `PATTERNS'."
  (dolist (pattern patterns)
    (add-to-list 'auto-mode-alist (cons pattern mode))))

;; Like diminish, but for major modes
(defun sanityinc/set-major-mode-name (name)
  "Override the major mode NAME in this buffer."
  (setq-local mode-name name))

(defun sanityinc/major-mode-lighter (mode name)
  (add-hook (derived-mode-hook-name mode)
            (apply-partially 'sanityinc/set-major-mode-name name)))

;;----------------------------------------------------------------------------
;; String utilities missing from core emacs
;;----------------------------------------------------------------------------
(defun sanityinc/string-all-matches (regex str &optional group)
  "Find all matches for `REGEX' within `STR', returning the full match string or group `GROUP'."
  (let ((result nil)
        (pos 0)
        (group (or group 0)))
    (while (string-match regex str pos)
      (push (match-string group str) result)
      (setq pos (match-end group)))
    result))


;;----------------------------------------------------------------------------
;; Delete the current file
;;----------------------------------------------------------------------------
(defun delete-this-file ()
  "Delete the current file, and kill the buffer."
  (interactive)
  (unless (buffer-file-name)
    (error "No file is currently being edited"))
  (when (yes-or-no-p (format "Really delete '%s'?"
                             (file-name-nondirectory buffer-file-name)))
    (delete-file (buffer-file-name))
    (kill-this-buffer)))


;;----------------------------------------------------------------------------
;; Rename the current file
;;----------------------------------------------------------------------------
(defun rename-this-file-and-buffer (new-name)
  "Renames both current buffer and file it's visiting to NEW-NAME."
  (interactive "sNew name: ")
  (let ((name (buffer-name))
        (filename (buffer-file-name)))
    (unless filename
      (error "Buffer '%s' is not visiting a file!" name))
    (progn
      (when (file-exists-p filename)
        (rename-file filename new-name 1))
      (set-visited-file-name new-name)
      (rename-buffer new-name))))

;;----------------------------------------------------------------------------
;; Browse current HTML file
;;----------------------------------------------------------------------------
(defun browse-current-file ()
  "Open the current file as a URL using `browse-url'."
  (interactive)
  (let ((file-name (buffer-file-name)))
    (if (and (fboundp 'tramp-tramp-file-p)
             (tramp-tramp-file-p file-name))
        (error "Cannot open tramp file")
      (browse-url (concat "file://" file-name)))))

;;----------------------------------------------------------------------------
;; Create tmp file
;;----------------------------------------------------------------------------
(defun create-temp-file ()
  "Create new temp file with specific extension."
  (interactive)
  (let* ((user-ext (read-string "Extension of file:"))
         (ext (if (> (length user-ext) 0) (format ".%s" user-ext) ""))
         (file-name (if (string= ext ".go")
                        (concat (getenv "GOPATH") "/src/playground/" (format-time-string "%Y%m%d%H%M%S") ".go")
                      (make-temp-file (format-time-string "%Y%m%d%H%M%S") nil ext))))
    (find-file file-name)))


(defconst execute-mode-map '(("emacs-lisp-mode" . "emacs")
                             ("go-mode" . "go run")
                             ("rust-mode" . "cargo script")
                             ("python-mode" . "python")
                             ))

;;----------------------------------------------------------------------------
;; Execute current buffer with customized command
;;----------------------------------------------------------------------------
(defun execute-current-buffer ()
  "Execute buffer with custom execute command."
  (interactive)
  (let* ((current-mode (format "%s" major-mode))
         (execute-command-prefix (cdr (assoc current-mode execute-mode-map))))
    (cond ((not execute-command-prefix) (message (format "Invalid major mode: %s" current-mode)))
          ((string-equal execute-command-prefix "emacs") (eval-current-buffer))
          (t (shell-command (format "%s %s" execute-command-prefix (buffer-file-name))))
          )))


(defun insert-coursescript-id ()
  "Auto generate coursescript id with current timestamp in usec."
  (interactive)
  (insert (number-to-string (floor (* 1000000 (float-time (current-time)))))))

(global-set-key (kbd "C-c M-t") 'create-temp-file)
;; (global-set-key (kbd "C-c C-e") 'execute-current-buffer)
(global-set-key (kbd "C-c i") 'insert-coursescript-id)


(provide 'init-utils)

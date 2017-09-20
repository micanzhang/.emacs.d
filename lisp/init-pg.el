;; please git clone from https://github.com/ProofGeneral/PG into site-lisp/PG
(when (file-exists-p "~/.emacs.d/site-lisp/PG/generic/proof-site")
  (load "~/.emacs.d/site-lisp/PG/generic/proof-site")
  (require-package 'company-coq)

  (add-hook 'coq-mode-hook #'company-coq-mode))
(provide 'init-pg)

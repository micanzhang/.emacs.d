(require-package 'plantuml-mode)

(setq plantuml-jar-path (expand-file-name "~/Tools/plantuml.jar"))
(add-to-list 'org-src-lang-modes '("plantuml" . plantuml))

(provide 'init-plantuml)

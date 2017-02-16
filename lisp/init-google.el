(require-package 'google-translate)

(setq-default google-translate-default-target-language "zh-CN")
(setq-default google-translate-default-source-language "en")

(global-set-key "\C-ct" 'google-translate-at-point)
(global-set-key "\C-cT" 'google-translate-query-translate)

(provide 'init-google)

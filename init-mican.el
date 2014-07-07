(set-face-attribute 'default nil :height 140)
(set-face-attribute 'default nil :family "monaco")

(defun toggle-fullscreen ()
(interactive)
(x-send-client-message nil 0 nil "_NET_WM_STATE" 32
'(2 "_NET_WM_STATE_MAXIMIZED_VERT" 0))
(x-send-client-message nil 0 nil "_NET_WM_STATE" 32
'(2 "_NET_WM_STATE_MAXIMIZED_HORZ" 0))
)
(toggle-fullscreen)

(provide 'init-mican)

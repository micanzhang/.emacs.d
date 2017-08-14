(defun sdird ()
  (interactive)
  (dired (format "/ssh:%s:~/" (read-string "Host:"))))

(defun ssdird ()
  (interactive)
  (let ((host (read-string "Host:")))
    (dired (format "/ssh:%s|sudo:%s:~/" host host))))

(provide 'init-devops)

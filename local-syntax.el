;;(defmacro def-syntax-mode (name base-mode extension))
(require 'funcs)

(require 'sibilant-mode )
;; (add-hook 'sibilant-mode-hook
;;           #'(lambda ()
;;               (split-window-right-and-focus)
;;               (shell)
;;               (rename-uniquely (concatenate buffer-file-name "-shellj"))
;;               (isend-associate )))

;;;###autoload
(add-to-list 'auto-mode-alist (cons "\\.sibilant\\'" 'sibilant-mode))

(provide 'local-syntax)

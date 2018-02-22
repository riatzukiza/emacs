

(add-to-list 'load-path "/home/aaron/devel/emacs/isend-mode.el")
(require 'isend)

(load "./sibilant-mode.el")

(global-company-mode)

  ;;;Tern starts here.

(add-to-list 'load-path "/usr/local/node/lib/node_modules/tern/emacs/")

(autoload 'tern-mode "tern.el" nil t)
(add-hook 'javascript (lambda () (tern-mode t)))

(defmacro config-layers (&rest body)
  `(setq-default dotspacemacs-configuration-layers ,@body))

(setq-default dotspacemacs-configuration-layers
              '((shell :variables shell-default-shell 'eshell)))



;;(set-frame-parameter (selected-frame) 'alpha '(90 . 50))



;; (find-file "~/.sibilant")
;; (split-window-right-and-focus  "~/devel/packages.emacs/local-packages.el")

(defvar active-projects (make-hash-table))
(defun shell-split ()
  (interactive)
  (split-window-below-and-focus)
  (shell))


(defun sibilant-associate ()
  (interactive)
  (let* ((current-project-name (projectile-project-name))
         (current-buffer-name filename)
         (current-project (gethash project-name active-projects nil)))

    (unless current-project
      (setf current-project (make-hash-table))
      (puthash current-project-name project))))



(sp-local-pair 'emacs-lisp-mode "'" nil :actions :rem)
(sp-pair "'" nil :actions :rem)

(sp-local-pair 'emacs-lisp-mode "`" nil :actions :rem)
(sp-pair "`" nil :actions :rem)

(add-to-list 'company-backends 'company-tern)

(provide 'mine)

;;(desktop-revert)

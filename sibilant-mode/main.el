(require 'cl-lib)

(add-to-list 'load-path "~/devel/emacs/sibilant-mode")
(load "./macros")

(load "./company-mod.el")
(load "./keybinds.el")
(load "./syntax-table.el")

(load "./font-lock.el")

(add-to-list 'auto-mode-alist (cons "\\.sibilant\\'" 'sibilant-mode))

(defvar sibilant-projects (make-hash-table ))
;; (defvar test-hash-table (make-hash-table :test #'equal))

;; (puthash "foo" "tomatos" test-hash-table)
;; (gethash "foo" test-hash-table)

(defun open-sibilant-repl (name)

  (async-shell-command "sibilant")
  (set-buffer "*Async Shell Command*")
  (interactive "Bname")
  (rename-buffer name))
;; (file-name-nondirectory default-directory)
(defun get-project-name ()

  )

(defun find-sibilant-project-repl ()

  (let (name (current-buffer))
    (neotree-find-project-root)))

(defun send-sibilant-to-project-repl ())

(defun associate-file-with-project-shell (path))

;; (def-sona Lisp-monkey
;;   (loves .programming .bananas
;;          ;; .drugs
;;          )
;;   (likes .cats .healthy-foods
;;          ;; .sex
;;          .storms
;;          )
;;   (dislikes .making-sense
;;             .low-pressure
;;             .programming))

;;;###autoload
(define-derived-mode sibilant-mode lisp-mode "SibilantJS"

  "Major mode for Sibilant"


  ;; Need to figure out a highlighting for functors



  ;; (defmacro macro (name arg &body body)
  ;;   `(defmacro ,name ,arg ,@body))

  ;; (defmacro macro-alias (name copy-name)
  ;;        `(macro ,copy-name (&rest args) `(,,name @(unquote args))))
  ;; (macro-alias def defun)

  ;;(open-sibilant-process )



  (dolist '(lambda (char) (modify-syntax-entry char "w" sibilant-mode-syntax-table))
    '(?_ ?~ ?. ?- ?> ?< ?! ??))

  (setq font-lock-defaults '(sibilant-font-lock-defaults))

  ;; (split-window-right-and-focus)
  ;; (neotree-find-project-root)
  )

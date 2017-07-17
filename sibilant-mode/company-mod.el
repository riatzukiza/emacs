
(defun company-advanced--make-candidate (candidate)
  (let ((text (car candidate))
        (meta (cadr candidate)))
    (propertize text 'meta meta)))

(defun company-advanced--candidates (prefix)
  (let (res)
    (dolist (item company-advanced-keywords)
      (when (string-prefix-p prefix (car item))
        (push (company-advanced--make-candidate item) res)))
    res))

(defun company-advanced--meta (candidate)
  (format "This will use %s of %s"
          (get-text-property 0 'meta candidate)
          (substring-no-properties candidate)))

(defun company-advanced--annotation (candidate)
  (format " (%s)" (get-text-property 0 'meta candidate)))

(defun company-advanced (command &optional arg &rest ignored)
  (interactive (list 'interactive))
  (cl-case command
    (interactive (company-begin-backend 'company-advanced))
    (prefix (company-grab-symbol-cons "\\.\\|->" 2))
    (candidates (company-advanced--candidates arg))
    (annotation (company-advanced--annotation arg))
    (meta (company-advanced--meta arg))))

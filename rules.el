(require 'lisp-mode)
(require 'font-lock)
(require 'rx)

(defmacro rule (regex &rest highlighting)
  `(list (rx ,@regex)
    ,@highlighting))

(defmacro function-def-words (&rest names)
  `(rule
    ( "(" (group (or (one-or-more (or "\n" whitespace)) (or ,@names) ))
      (one-or-more (or "\n" whitespace))
      (group (one-or-more (or "-" word "_" ".")));;the name of the function
      (one-or-more (or "\n" whitespace)) "(" (group  (zero-or-more (or "{" "}" "[" "]" "," ":" "."
                                     (one-or-more (or "-" word "_" "."))
                                     "\n" whitespace))) ")")

    '(1 font-lock-keyword-face)
    '(2 font-lock-function-name-face)
    '(3 font-lock-variable-name-face)))
(defmacro anonymous-expressions (&rest names)
  `(rule ( "(" (zero-or-more whitespace "\n")
           (group (or (one-or-more (or "\n" whitespace)) (or ,@names) ));;keywords that indicate a function
           (one-or-more (or "\n" whitespace))


           "(" (zero-or-more whitespace "\n")
           (group  (zero-or-more  (or "{" "}" "[" "]" "," ":" "." (one-or-more (or "-" word "_" ".")) "\n" whitespace)))
           ")") ;;the arguements of the function

         '(1 font-lock-keyword-face)
         '(2 font-lock-variable-name-face)))
(defmacro variable-assignment (&rest names)
  `(rule
    ( "(" (zero-or-more whitespace "\n")
      (group (or ,@names))
      (one-or-more (or "\n" whitespace)) (group (one-or-more (one-or-more (or "-" word "_" ".")))))
    '(1 font-lock-keyword-face)
    '(2 font-lock-variable-name-face)))
(defmacro keywords (&rest names)
  `(rule ("(" (group (or ,@names)))
         '(1 font-lock-keyword-face)))
(defmacro non-expression-keywords (&rest names)
  `(rule ( bow (group (or ,@names)))
         '(1 font-lock-keyword-face)))

(provide 'rules)

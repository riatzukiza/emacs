
;;(defmacro def-syntax-mode (name base-mode extension))
(require 'funcs)
(defvar word-boundry
  '(one-or-more (or "\n" whitespace))
  )
(defvar arg-expression
  '(group  (zero-or-more
            (or "{" "}"
                "(" ")"
                "[" "]"

                "," ":" "."

                (one-or-more (or "-" word "_" "."))

                "\n"

                whitespace))))

(defvar valid-word
  '(one-or-more (or "-" word "_" ".")))

(defmacro rule (regex &rest highlighting)
  `(list (rx ,@regex)
    ,@highlighting))

(defmacro def-rule (name &rest body)
  `(defmacro ,name (&rest names)
     (let ((body '(,@body)))
       `(rule ,@body))))

(def-rule function-def-words

  ( "(" (group (or ,word-boundtry (or ,@names) ))
    ,word-boundry
    (group ,valid-word);;the name of the function

    ,word-boundry

    "(" ,arg-expression ")")

  '(1 font-lock-keyword-face)
  '(2 font-lock-function-name-face)
  '(3 font-lock-variable-name-face))



(def-rule anonymous-expressions

  ( "(" (zero-or-more whitespace "\n")
         (group (or ,word-boundry (or ,@names) ));;keywords that indicate a function

         ,word-boundry

         "(" ,arg-expression ")")

  '(1 font-lock-keyword-face)
  '(2 font-lock-variable-name-face))

(defmacro variable-assignment (&rest names)

  `(rule
    ( "(" (zero-or-more whitespace "\n")
      (group (or ,@names))
      (one-or-more (or "\n" whitespace))
      (group (one-or-more (one-or-more (or "-" word "_" ".")))))

    '(1 font-lock-keyword-face)
    '(2 font-lock-variable-name-face)))

(defmacro keywords (&rest names)
  `(rule ("(" (group (or ,@names)))
         '(1 font-lock-keyword-face)))
(defmacro non-expression-keywords (&rest names)
  `(rule ( bow (group (or ,@names)))
         '(1 font-lock-keyword-face)))

(defface func-face
  `((((type graphic )
      (class color)
      (background dark))
     (:foreground "blue"))

    (((type graphic)
      (class color)
      (background light))
     (:foreground "lightblue"))
    (t (:background "white" :foreground "blue")))
  "Basic face for highlighting the region."
  :group 'basic-faces)

(defmacro def-list (name &rest elements)
  `(defvar ,name (list ,@elements)))

;; Need to figure out a highlighting for functors

(def-list sibilant-font-lock-defaults

  ;;base
  (function-def-words  "macro" "def" )

  ;;added
  (function-def-words "function" "fn" "method" "mth" "gmth")

  ;;base
  (anonymous-expressions  "lambda" "#" "let" )

  ;; added
  (anonymous-expressions "=>")

  ;; Sibilant comes with these
  (variable-assignment "var" "get" "set" "assign")

  ;; I added these ones
  (variable-assignment "let" "|>" "#->"
                       "of"
                       "mth" "gmth"
                       "getter" "gett" "setter" "sett"
                       "alias" "module" "exports" "methods"  "from"
                       "type" "specify" "const" "where" "default")

  ;; base keywords
  (keywords

   ;;comparsion
   "if" "unless" "when" "ternary"

   "this" "console" "pipe"  "#>"
   "return"

   ;; module system
   "require" "include" "import-namespace" "namespace"
   ;; error handling
   "try" "throw"
   ;; comparison operators
   "="  ">" "<" ">=" "<=" "instanceof"
   ;; Numeric operators
   "+" "-" "*" "/"
   ;; logical operators
   "and" "not" "or")
  ;; These are keywords because I added them to the language
  (keywords "literal" 
            "catch" ">>" "is" "then"
            "on" "once"
            ;; object operators
            "create" "extend"

            "print" "maybe" ".then" ".catch" )

  (non-expression-keywords "true" "false" "this")

  ;; any expression that does not match a rule will have
  ;; its first element highlighted

  ;; (rule ("(" (zero-or-more (or "\n" whitespace))
  ;;        (group (one-or-more (or "-" word "_" ".")))
  ;;        (zero-or-more (or "\n" whitespace)))

  ;;       '(1 font-lock-variable-name-face))
  )

;;;###autoload
(define-derived-mode sibilant-mode lisp-mode "SibilantJS"

  "Major mode for Sibilant"

  (dolist '(lambda (char)
             (modify-syntax-entry char "w" sibilant-mode-syntax-table))
    '(?_ ?~ ?. ?- ?> ?< ?! ??))

  (setq font-lock-defaults '(sibilant-font-lock-defaults)))

;;;###autoload
(add-to-list 'auto-mode-alist (cons "\\.sibilant\\'" 'sibilant-mode))
(provide 'sibilant-mode)

(provide 'local-syntax)

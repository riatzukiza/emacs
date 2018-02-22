(defvar valid-word
  '(one-or-more (or "-" word "_" "." "*" )))

(defvar arg-expression
  `(group  "(" (zero-or-more
                (or "{" "}"
                    "[" "]"
                    ""

                    "," ":" "."

                    ,valid-word

                    "\n"

                    whitespace)) ")"))

(defvar word-boundry
  '(one-or-more (or "\n" whitespace)))

(defmacro rule (regex &rest highlighting)
  `(list (rx ,@regex)
         ,@highlighting))

(defmacro function-def-words (&rest names)

  `(rule
    ( "(" (group (and (or ,@names) (or (zero-or-more ,valid-word))) )

      ,word-boundry

      (group (one-or-more (or "-" word "_" "."))) ;;the name of the function

      ,word-boundry

      ;;,arg-expression
      )

    '(1 font-lock-keyword-face)
    '(2 font-lock-function-name-face)
    ;;'(3 font-lock-variable-name-face)
    )
  )

(defmacro generic-combinators (&rest names)
  `(rule
    ( "(" (group ,@names )

      ,word-boundry

      (group (one-or-more (or "-" word "_" "."))) ;;the name of the function


      ,word-boundry

      ,arg-expression

      ,arg-expression
      )

    '(1 font-lock-keyword-face)
    '(2 font-lock-function-name-face)
    '(4 font-lock-variable-name-face)))

(defmacro anonymous-expressions (&rest names)
  `(rule ( "(" (group (and (or ,@names) (or (zero-or-more ,valid-word))) );;keywords that indicate a function
           ,word-boundry


           ;;,arg-expression

           ) ;;the arguements of the function

         '(1 font-lock-keyword-face)
         ;;'(2 font-lock-variable-name-face)
         ))

(defmacro variable-assignment (&rest names)
  `(rule ( "(" (group (or ,@names))
           ,word-boundry
           (group  ,valid-word))
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


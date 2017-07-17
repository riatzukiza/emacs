(require 'lisp-mode)
(require 'font-lock)
(require 'rx)

(defface font-lock-func-face
  '((nil (:foreground "#7F0055" :weight bold))
    (t (:bold t :italic t)))
  "Font Lock mode face used for function calls."
  :group 'font-lock-highlighting-faces)

(defmacro func-name-highlighting (mode-name)
       `(font-lock-add-keywords
         (quote ,mode-name)
         (quote (("(\\s-*\\(\\_<\\(?:\\sw\\|\\s_\\)+\\)\\_>"
                  1 'font-lock-func-face)))))

(defmacro match-from-list-head (&rest body)
  `(rx "(" ,@body))

(defmacro match-declaration (names)
  `(rx "("
   (group (or ,@names))
   (one-or-more (or "\n" whitespace)) (group (one-or-more word))))

(defun gen-word-seq-rule (&rest word-lists)
  (labels ((gen-word-rule (words)
                          `(group (or (one-or-more (or "\n" whitespace)) (or ,@words) )))))
  (map-car word-lists ))

(defmacro def-syntax-rule (&rest word-sets)
  `(rx "("
      (group (or (one-or-more (or "\n" whitespace)) (or ,@words) ));;keywords that indicate a function
      (one-or-more (or "\n" whitespace))

      (group (one-or-more (or "-" word "_" ".")));;the name of the function

      (one-or-more (or "\n" whitespace))

      "(" (group  (zero-or-more  (or "{" "}" "[" "]" "," ":" "." word "\n" whitespace)))
      ")"))

(defvar sibilant-words `(one-or-more (or "-" word "_" ".")))

(defvar whitespace `(one-or-more (or "\n" whitespace)))

(defmacro word (matches)
  ""
  `(group (or `whitespace (or ,@matches) )))


(defmacro sibilant-word (matches))


(defmacro argument ()
  `("(" (zero-or-more whitespace "\n")
    (group  (zero-or-more  (or "{" "}" "[" "]" "," ":" "."
                               (one-or-more (or "-" word "_" "."))
                               "\n" whitespace))) ")"))

(defmacro named-function (&rest possible-names)
  `(rx "(" , (words)
      ;;the name of the function
       `(word  ,possible-names)

      ;;the arguements of the function
      ,@(argument)))

(provide 'funcs)

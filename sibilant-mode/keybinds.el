
(require 'isend)
(defun sync-sibilant ()
  (save-excursion

    (set-buffer b)

    (insert (concatenate 'string "(meta (assign sibilant.dir \"" d "\") null)"))

    (insert (concatenate 'string "(add-to-module-lookup\"" d "\")"))
    (end-term-input)))

(defun unsync-sibilant ()
  (save-excursion
    (set-buffer b)
    (insert (concatenate 'string "(meta (assign sibilant.dir  \"./\") null)"))
    (end-term-input)))

(defmacro eval-sibilant (&rest expr)
  `(let ((b isend--command-buffer)
         (d default-directory))


     (sync-sibilant)

     ,@expr

     (unsync-sibilant)))

(defun sibilant-associate-main ()
  (interactive)
  (call-interactively isend-associate "*sibilant*"))

(defun end-term-input()
  (cond
   ;; Terminal buffer: specifically call `term-send-input'
   ;; to handle both the char and line modes of `ansi-term'.
   ((eq major-mode 'term-mode)
    (term-send-input))

   ;; Other buffer: call whatever is bound to 'RET'
   (t (funcall (key-binding (kbd "RET"))))))




(defun eval-sibilant-buffer ()

  (interactive)

  (eval-sibilant

   (mark-whole-buffer)
   (isend-send)))

(defun eval-sibilant-defun ()
  (interactive)

  (eval-sibilant
   (funcall isend-mark-defun-function)
   (isend-send)))

(defun close-sibilant-repl ())
(defun restart-sibilant-repl ())

(defmacro major-keysequence (mode sequence-string function-symbol)
  `(spacemacs/set-leader-keys-for-major-mode
     ,mode
     ,sequence-string
     ,function-symbol))

(major-keysequence 'sibilant-mode "e b" 'eval-sibilant-buffer)
(major-keysequence 'sibilant-mode "e f" 'eval-sibilant-defun)

(major-keysequence 'sibilant-mode "i a" 'sibilant-associate-main)
(major-keysequence 'sibilant-mode "i o" 'open-sibilant-repl)
(major-keysequence 'sibilant-mode "i c" 'close-sibilant-repl)

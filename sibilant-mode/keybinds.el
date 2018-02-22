
(require 'isend)
(defun sync-sibilant ()
  (save-excursion

    (set-buffer b)

    (let* ((path-elements (split-string d ":"))
           (path (if (eq (length path-elements) 3)
                     (car (last path-elements)) d)))

      (insert (concatenate 'string "(meta (assign sibilant.dir \"" path "\") null)"))

      (insert (concatenate 'string "(add-to-module-lookup\"" path "\")")))

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

     (unsync-sibilant)
     (deactivate-mark)
     ))

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
   (t (funcall (key-binding (kbd "RET"))))
   ))




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

;; (major-keysequence 'sibilant-mode "e b" 'eval-sibilant-buffer)
;; (major-keysequence 'sibilant-mode "e f" 'eval-sibilant-defun)

;; (major-keysequence 'sibilant-mode "i a" 'sibilant-associate-main)
;; (major-keysequence 'sibilant-mode "i o" 'open-sibilant-repl)
;; (major-keysequence 'sibilant-mode "i c" 'close-sibilant-repl)

(defun associate-sibilant-with-default-shell ()
  (interactive))

(defun associate-sibilant-with-default-async ()
  (interactive))

(defun associate-sibilant-with-last ()
  (interactive))

(defmacro def-key-binds (mode &rest forms)
  `(progn
     ,@(mapcar #'(lambda (form)
                    (let ((k (first form))
                          (f (second form)))
                      (print `(,mode ,k ,f))
                      `(major-keysequence ,mode ,k ,f)))
                forms)))
(def-key-binds 'sibilant-mode

  ("e b" 'eval-sibilant-buffer)
  ("e f" 'eval-sibilant-defun)

  ("a s" 'associate-sibilant-with-default-shell)
  ("a a" 'associate-sibilant-with-default-async)
  ("a l" 'associate-sibilant-with-last)

  ("i a" 'sibilant-associate-main)
  ("i o" 'open-sibilant-repl)
  ("i c" 'close-sibilant-repl))

(defvar *actors* (make-hash))
(defvar *entities*)

(defmacro actor (name &rest stats)
  `(defclass ,name () ,(append '(x y name) (get-vars stats)))
  `(set-hash *actors* ',name ',(get-vals stats)))

(defmacro make-actor (name actor x y)
  `(let ((new-actor (make-instance ,actor)))
     (setf (slot new-actor 'x) ,x)
     (setf (slot new-actor 'y) ,y)
     (setf (slot new-actor 'name) ',name)
     (make-actor-set-defaults new-actor ',actor
			      (cdr (cddr (get-slots ',actor)))
			      (get-hash *actors* ',actor))
     (setq *entities* (cons new-actor *entities*))
     new-actor))

(defun make-actor-set-defaults (new-actor name name-stats default-stats)
  (unless (null name-stats)
  (setf (slot new-actor (car name-stats)) (car default-stats))
  (make-actor-set-defaults new-actor name (cdr name-stats) (cdr default-stats))))

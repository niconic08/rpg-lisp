(defvar *damage-modifiers*)
(defvar *defence-modifiers*)
(defvar *hp-modifiers*)
(defvar *player*)

(defmacro check-collision (x y)
  `(let ((actors-in-cell (find-created-actors ((x ,x)(y ,y)))))
     (if (null actors-in-cell) nil (if (null (cdr actors-in-cell)) nil t))))
(defmacro is-actor-in-cell (x y)
  `(let ((actors-in-cell (find-created-actors ((x ,x)(y ,y)))))
    (if (null actors-in-cell) nil t)))

(defmacro find-created-actors (tests)
  `(inner-fca *entities* ',tests nil))

(defun inner-fca (hashes tests res)
  (if (null hashes) res
      (progn (when (= (inner-fca-do-all-tests (car hashes) tests) t)
	       (setq res (cons (car hashes) res)))
	     (inner-fca (cdr hashes) tests res))
  ))
(defun inner-fca-do-all-tests (hash tests)
  (if (null tests) t
      (if (null (inner-fca-do-test hash (car tests)))
	  nil
	  (inner-fca-do-all-tests hash (cdr tests)))))
(defun inner-fca-do-test (hash test)
  (let ((test-left (car test)) (test-right (cadr test)))
    (if (= (slot hash test-left) test-right) t nil)))

(defun actor-move (actor direction)
  t)
(defun actor-move-left (actor)
  (unless (is-actor-in-cell (- (slot actor 'x) 1) (slot actor 'y))
    (setf (slot actor 'x) (- (slot actor 'x) 1))
    t))
(defun actor-move-right (actor)
  (unless (is-actor-in-cell (+ (slot actor 'x) 1) (slot actor 'y))
    (setf (slot actor 'x) (+ (slot actor 'x) 1))
    t))
(defun actor-move-up (actor)
  (unless (is-actor-in-cell (slot actor 'x) (- (slot actor 'y) 1))
    (setf (slot actor 'y) (- (slot actor 'y) 1))
    t))
(defun actor-move-down (actor)
  (unless (is-actor-in-cell (slot actor 'x) (+ (slot actor 'y) 1))
    (setf (slot actor 'y) (+ (slot actor 'y) 1))
    t))
(defmacro add-dmg-mod (stat formula)
  ;Добавление формулы урона formula от характеристики stat
  ;в формулах использовать damage - урон с предыдущего вычисления
  ;value - значение самого stat
  `(setq *damage-modifiers*
	 (cons '(,stat .
		 (lambda (damage value)
		   ,formula))
	       *damage-modifiers*)))
(defmacro add-def-mod (stat formula)
  ;Добавление формулы защиты formula от характеристики stat
  `(setq *defence-modifiers*
	 (cons '(,stat .
		 (lambda (damage value)
		   ,formula))
	       *defence-modifiers*)))
(defmacro add-hp-mod (stat formula)
  ;Добавление формулы здоровья formula от характеристики stat
  `(setq *hp-modifiers*
	 (cons '(,stat .
		 (lambda (hp value)
		   ,formula))
	       *hp-modifiers*)))

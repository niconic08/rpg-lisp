(defvar *your-team-start-y*)
(defvar *your-team-end-y*)
(defvar *enemy-team-start-y*)
(defvar *enemy-team-end-y*)
(defvar *actions-start-y*)
(defvar *actions-end-y*)
(defvar *gui-y*)
(defvar *left-delta* 4)
(defvar *cursor-place-menu*)
(defvar *cursor-place-y*)
(defvar *selected-your-fighter*)
(defvar *selected-action*)
(defvar *selected-enemy-fighter*)
(defvar *your-turn* t)
(defvar *battle-key-pressed*)
(defun init-battle-gui ()
  (battle-gui-clear)
  (setq *gui-y* (update-fighters *left-delta* *gui-y*))
  (setq *gui-y* (update-actions *left-delta* *gui-y*))
  (your-turn)
  (place-cursor))
(defun update-battle-gui ()
  (battle-gui-clear)
  (setq *gui-y* (update-fighters *left-delta* *gui-y*))
  (setq *gui-y* (update-actions *left-delta* *gui-y*))
  (place-cursor))
(defun battle-gui-clear ()
  (console-clear)
  (setq *gui-y* 0))

(defun update-fighters (left-delta gui-y)
  (let ((your-team (car *battle-actors*)) (enemy-team (cdr *battle-actors*)))
    (draw-string 0 gui-y "YOUR TEAM")
    (setq gui-y (++ gui-y))
    (setq *your-team-start-y* gui-y)
    (while (not (null your-team))
      (when (get-hash (car your-team) 'alive)
	(draw-string left-delta gui-y
		     (concat
		      (concat
		       (symbol-name (get-hash (get-hash (car your-team) 'actor) 'name)) ": ")
		      (inttostr (get-hash (car your-team) 'hp))))
	(setq gui-y (++ gui-y)))
      (setq your-team (cdr your-team)))
    (setq *your-team-end-y* (- gui-y 1))
    (draw-string 0 gui-y "ENEMY TEAM")
    (setq gui-y (++ gui-y))
    (setq *enemy-team-start-y* gui-y)
    (while (not (null enemy-team))
      (when (get-hash (car enemy-team) 'alive)
	(draw-string left-delta gui-y
		     (concat
		      (concat
		       (symbol-name (get-hash (get-hash (car enemy-team) 'actor) 'name)) ": ")
		      (inttostr (get-hash (car enemy-team) 'hp))))
	(setq gui-y (++ gui-y)))
      (setq enemy-team (cdr enemy-team)))
    (setq *enemy-team-end-y* (- gui-y 1))
    gui-y))
(defun update-actions (left-delta gui-y)
  (draw-string 0 gui-y "ACTIONS")
  (setq gui-y (++ gui-y))
  (setq *actions-start-y* gui-y)
  (draw-string left-delta gui-y "attack")
  (setq *actions-end-y* gui-y)
  (setq gui-y (++ gui-y)))
(defun get-your-fighter (your-number)
  (let ((index 0) (search-team (car *battle-actors*)) (founded-fighter nil))
    (while (not (= index your-number))
      (when (get-hash (car search-team) 'alive)
	(setq index (++ index))
	(setq founded-fighter (car search-team)))
      (setq search-team (cdr search-team)))
    founded-fighter))
(defun get-enemy-fighter (enemy-number)
  (let ((index 0) (search-team (cdr *battle-actors*)) (founded-fighter nil))
    (while (not (= index enemy-number))
      (when (get-hash (car search-team) 'alive)
	(setq index (++ index))
	(setq founded-fighter (car search-team)))
      (setq search-team (cdr search-team)))
    founded-fighter))
(defun place-cursor ()
  (draw-string 1 *cursor-place-y* "-->"))
(defun cursor-place-menu-change (menu)
  (setq *cursor-place-menu* menu)
  (case *cursor-place-menu*
     ('your-team (setq *cursor-place-y* *your-team-start-y*))
    ('enemy-team (setq *cursor-place-y* *enemy-team-start-y*))
    ('actions (setq *cursor-place-y* *actions-start-y*))
    (otherwise t)))
(defun cursor-place-down ()
  (case *cursor-place-menu*
    ('your-team (if (< *cursor-place-y* *your-team-end-y*)
		    (setq *cursor-place-y* (+ *cursor-place-y* 1))
		    (setq *cursor-place-y* *your-team-start-y*)))
    ('enemy-team (if (< *cursor-place-y* *enemy-team-end-y*)
		     (setq *cursor-place-y* (+ *cursor-place-y* 1))
		     (setq *cursor-place-y* *enemy-team-start-y*)))
    ('actions (if (< *cursor-place-y* *actions-end-y*)
		     (setq *cursor-place-y* (+ *cursor-place-y* 1))
		     (setq *cursor-place-y* *actions-start-y*)))
    (otherwise t)))
(defun cursor-place-up ()
  (case *cursor-place-menu*
    ('your-team (if (> *cursor-place-y* *your-team-start-y*)
		    (setq *cursor-place-y* (- *cursor-place-y* 1))
		    (setq *cursor-place-y* *your-team-end-y*)))
    ('enemy-team (if (> *cursor-place-y* *enemy-team-start-y*)
		     (setq *cursor-place-y* (- *cursor-place-y* 1))
		     (setq *cursor-place-y* *enemy-team-end-y*)))
    ('actions (if (> *cursor-place-y* *actions-start-y*)
		    (setq *cursor-place-y* (- *cursor-place-y* 1))
		    (setq *cursor-place-y* *actions-end-y*)))
    (otherwise t)))
(defun cursor-place-select ()
  (case *cursor-place-menu*
    ('your-team (progn
		  (setq *selected-your-fighter*
			(get-your-fighter
			 (++ (- *cursor-place-y* *your-team-start-y*))))
		  (cursor-place-menu-change 'actions)))
    ('enemy-team (progn
		   (setq *selected-enemy-fighter*
			 (get-enemy-fighter
			  (++ (- *cursor-place-y* *enemy-team-start-y*))))
		   (execute-action)))
    ('actions (case (get-action (++(- *cursor-place-y* *actions-start-y*)))
		('attack (progn
			   (setq *selected-action* 'attack)
			   (cursor-place-menu-change 'enemy-team)))
		(otherwise 'error)))
    (otherwise t)))
(defun get-action (action-number)
  (case (- action-number (- *actions-end-y* *actions-start-y*))
    (1 'attack)
    (otherwise 'wrong-action)))
(defun execute-action ()
  (case *selected-action*
    ('attack (progn
	       (attack *selected-your-fighter* *selected-enemy-fighter*)
	       (enemy-turn)))
    (otherwise t)))
(defun your-turn ()
  (if (battle-not-ended)
      (progn (cursor-place-menu-change 'your-team)
	     (setq *your-turn* t))
      (battle-ended-gui)))
(defun enemy-turn ()
  (if (battle-not-ended)
      (let ((enemy-team (cdr *battle-actors*)))
	;(while (not (null enemy-team))
	  (app '(lambda (enemy-attacker) (attack enemy-attacker (get-your-fighter 1))) enemy-team)
	  ;(setq enemy-team (cdr enemy-team)))
    (your-turn))
  (battle-ended-gui)))
(defun battle-ended-gui ()
  (case (battle-ended)
    ('win (battle-gui-win))
    ('lose (battle-gui-lose))
    (otherwise (battle-gui-error))))
(defun battle-gui-win ()
  (console-clear)
  (draw-string 0 0 "BATTLE WIN"))
(defun battle-gui-lose ()
  (console-clear)
  (draw-string 0 0 "BATTLE LOSE"))
(defun battle-gui-error ()
  (console-clear)
  (draw-string 0 0 "BATTLE ERROR"))
(defun battle-input ()
  (battle-key-pressed)
  (battle-key-release))
(defun battle-key-pressed ()
    (let ((battle-key-not-pressed t))
      (while battle-key-not-pressed
	(when (key-pressed +key-up+)
	  (cursor-place-up)
	  (setq *battle-key-pressed* +key-up+)
	  (setq battle-key-not-pressed nil))
	(when (key-pressed +key-down+)
	  (cursor-place-down)
	  (setq *battle-key-pressed* +key-down+)
	  (setq battle-key-not-pressed nil))
	)))
(defun battle-key-release ()
  (while (key-pressed *battle-key-pressed*)))
    
	
  
  
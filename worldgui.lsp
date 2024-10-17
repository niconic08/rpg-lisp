(defvar *world*)

(defun create-world (width height)
  (let ((new-world (make-array width)))
    (for i 0 width
	 (seta new-world i (make-array height))
	       (for j 0 height
		    (if (or (= i 0) (= i (- width 1)) (= j 0) (= j (- height 1)))
			(seta (aref new-world i) j 'wall)
			(seta (aref new-world i) j 'empty))))
    (setq *world* new-world)
    (set-tiles '((wall . "#")(empty . "-")(player . "@")(enemy . "E")))))
(defun update-screen-world ()
  (set-screen *world*)
  (draw-screen))

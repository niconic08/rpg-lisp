;(set-cursor 0 0)
;(putchar "a")

;(actor Hero (STR 10) (DEX 20) (HP 100) (weapon 20))

;(setq k (make-actor karas hero 3 1))
;(setq k2 (make-actor karas hero 4 5))

;; (while t  
;;   (when (key-pressed +key-left+) (draw 0 0 "l"))
;;   (when (key-pressed +key-right+) (draw 0 0 "r"))
;;   (when (key-pressed +key-up+) (draw 0 0 "u"))
;;   (when (key-pressed +key-down+) (draw 0 0 "d"))
;;   (when (key-pressed +key-0+) (draw 0 0 "d"))
;; )




;; (create-world 5 5)
;; (set-screen #(#(WALL PLAT WALL PLAT)
;; 		#(PLAT WALL PLAT)))
;; (set-tiles '((WALL . "#") (PLAT . "-")))
;; (draw-screen)
;(set-screen *world*)
;(draw-screen)
;; (defvar *room-max-width* 15)
;; (defvar *room-max-height* 15)
;; (defvar *cell-width* 1)
;; (defvar *cell-height* 1)
;; (defun room-show ()
;;   (for i 0 *room-max-width*
;;        (for j 0 *room-max-height*
;; 	    (set-cursor (+ (* i *cell-width*) (/ *cell-width* 2))
;; 			(+ (* j *cell-height*) (/ *cell-height* 2)))
;; 	    (if (or (= i 0) (= i (- *room-max-width* 1)) (= j 0) (= j (- *room-max-height* 1))) (putchar "#") (putchar " ")))))
  ;(app '(lambda (x) (room-show-actor x)) *created-actors*))
;(room-show)
(actor Hero (STR 10) (DEX 20) (HP 100) (weapon 20))
(actor Enemy (STR 10) (DEX 20) (HP 100) (weapon 20))
(setq h1 (make-actor karas1 Hero 1 4))
(setq h2 (make-actor karas2 Enemy 2 3))
;(setq h3 (make-actor karas2 Enemy 3 3))

(add-dmg-mod str (* damage value))
(add-dmg-mod weapon (+ damage value))
(add-def-mod dex (/ damage value))
(add-hp-mod hp (+ hp value))
(set-battle-actors (list h1) (list h2))
;; (init-battle-gui)
;; (attack (caar *battle-actors*) (cadr *battle-actors*))
;; (attack (caar *battle-actors*) (cadr *battle-actors*))
;; (attack (caar *battle-actors*) (cadr *battle-actors*))
;; (attack (caar *battle-actors*) (cadr *battle-actors*))
;; (attack (caar *battle-actors*) (cadr *battle-actors*))
;; (attack (caar *battle-actors*) (cadr *battle-actors*))
;; (attack (caar *battle-actors*) (cadr *battle-actors*))
;; (attack (caar *battle-actors*) (cadr *battle-actors*))
;; (attack (caar *battle-actors*) (cadr *battle-actors*))
;; (attack (caar *battle-actors*) (cadr *battle-actors*))
;; (attack (caar *battle-actors*) (cadr *battle-actors*))
(init-battle-gui)
(for i 0 10
     (cursor-place-select)
     (cursor-place-select)
     (cursor-place-select))
(when (battle-not-ended) (update-battle-gui))
;(update-battle-gui)







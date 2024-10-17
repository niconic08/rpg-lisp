(actor Hero (STR 10) (DEX 20) (HP 100) (weapon 20))
(setq h1 (make-actor karas1 Hero 1 4))
(setq h2 (make-actor karas2 Hero 2 3))
(setq h3 (make-actor karas3 Hero 3 2))
(setq h4 (make-actor karas4 Hero 4 1))

(add-dmg-mod str (* damage value))
(add-dmg-mod weapon (+ damage value))
*damage-modifiers*
(add-def-mod dex (/ damage value))
*defence-modifiers*
(add-hp-mod hp (+ hp value))
*hp-modifiers*
(set-battle-actors (list h1 h2) (list h3 h4))
(attack (caar *battle-actors*) (cadr *battle-actors*))

















;(find-created-actor '(x 1))
;(slot h4 (car '(x 4)))

;(let ( (s h4) )
;  (when (= (slot s (car '(x 4))) (cadr '(x 4))) t))

;(let ( (s h4) (test-left (car '(x 4))) (test-right (cadr '(x 4))))
;  (print (slot s test-left))
;  (when (= (slot s test-left) test-right) t))
;(slot (hash-value h4) 'x)
;(if (= (slot h4 (car '(x 4))) (cadr '(x 4))) t nil)
;(inner-fca `(,h4 ,h3) '((x 4)) nil)
;(inner-fca *created-actors* '((x 4)) nil)
;(find-created-actors ((x 4)))

;(setq h11 (make-actor karas5 Hero 3 3))
;(setq h12 (make-actor karas6 Hero 3 3))
;(check-collision 3 3)
;(is-actor-in-cell 3 3)

;(set-seed 71313)
;(for i 0 1000
     ;(print (randint 1 2)))



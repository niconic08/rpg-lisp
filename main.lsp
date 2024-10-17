;(set-cursor 0 0)
;(putchar "a")

;(actor Hero (STR 10) (DEX 20) (HP 100) (weapon 20))

;(setq k (make-actor karas hero 3 1))
;(setq k2 (make-actor karas hero 4 5))

(while t  
  (when (key-pressed +key-left+) (draw 0 0 "l"))
  (when (key-pressed +key-right+) (draw 0 0 "r"))
  (when (key-pressed +key-up+) (draw 0 0 "u"))
  (when (key-pressed +key-down+) (draw 0 0 "d"))
  (when (key-pressed +key-0+) (draw 0 0 "d"))
)

;(create-world 15 15)
;(set-screen #(#(WALL PLAT WALL PLAT)
;		#(nil WALL nil)))
;(set-tiles '((WALL . "#") (PLAT . "-")))
;(draw-screen)




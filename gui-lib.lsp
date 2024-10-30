(defun draw (d-x d-y d-char)
  (set-cursor d-x d-y)
  (putchar d-char))

(defun draw-string (ds-x ds-y string)
  (for char-index 0 (string-size string)
       (draw (+ ds-x char-index) ds-y (char string char-index))))

(defun console-clear ()
  (draw 26 26 " "))

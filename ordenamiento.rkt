;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ordenamiento) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(define (eliminar n lista)
  (cond
    [(empty? lista) empty]
    [(= n (car lista))(cdr lista)]
    [else (cons (car lista)(eliminar n (cdr lista)))]))

(define (menor lista)
  (cond
    [(empty? lista) empty]
    [(empty? (cdr lista))(car lista)]
    [(< (car lista)(car(cdr lista)))(menor (cons (car lista)(cddr lista)))]
    [else (menor (cdr lista))]))

(define (ordenar lista)
  (cond
    [(empty? lista) empty]
    [else (cons (menor lista) (ordenar (eliminar (menor lista) lista)))]))

(eliminar (menor (list 5 13 6 23 1 6 3)) (list 5 13 6 23 1 6 3))

(ordenar (list 5 13 6 23 1 6 3))
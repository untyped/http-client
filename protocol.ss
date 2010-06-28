#lang typed/racket

(: write-request (Bytes Bytes Bytes Output-Port -> Void))
(define (write-request method server resource output)
  (write-bytes method output)
  (write-space output)
  (write-bytes #"HTTP/1.1" output)
  (write-crlf output))


;; Utilities

;; These constants are defined in the spec.
(define SP 32)
(define CR 13)
(define LF 10)

(define-syntax-rule (define-constant-writer (name op) expr ...)
  (begin
    (: name (case-lambda (-> Void) (Output-Port -> Void)))
    (define name
      (case-lambda:
        [() (name (current-output-port))]
        [([op : Output-Port]) expr ...]))))
  
(define-constant-writer (write-space output)
  (write-byte SP output))

(define-constant-writer (write-crlf output)
  (write-byte CR output)
  (write-byte LF output))


(provide
 write-request)
#lang typed/scheme

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

(define-type-alias constant-writer
  (case-lambda (-> Void) (Output-Port -> Void)))

(define-syntax-rule (define-constant-writer (name op) expr ...)
  (begin
    (: name constant-writer)
    (define (name [op (current-output-port)])
      expr ...)))
  
(define-constant-writer (write-space output)
  (write-byte output SP))

(define-constant-writer (write-crlf output)
  (write-byte output CR)
  (write-byte output LF))


(provide
 write-request)
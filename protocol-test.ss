#lang scheme/base

(require
 (planet schematics/schemeunit:3)
 "protocol.ss")

(define (request-bytes method server resource)
  (let ([bytes (open-output-bytes)])
    (write-request method server resource bytes)
    (get-output-bytes bytes)))

(define/provide-test-suite protocol-tests
  (test-case
   "Standard request line written correctly"
   (check-equal?
    (request-bytes #"GET" #"www.untyped.com" #"/index.html")
    #"GET /index.html HTTP/1.1\r\nHost: www.untyped.com")))


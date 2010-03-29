#lang scheme/base

(require
 (planet schematics/schemeunit:3/test)
 "protocol-test.ss")

(define/provide-test-suite all-tests
  protocol-tests
  )
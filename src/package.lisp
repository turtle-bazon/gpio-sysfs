;;;; -*- mode: lisp -*-

(defpackage #:ru.bazon.cl-gpio-sysfs
  (:nicknames #:gpio-sysfs #:gpio)
  (:use #:cl)
  (:export
   #:initialize-pin
   #:shutdown-pin
   #:write-pin))

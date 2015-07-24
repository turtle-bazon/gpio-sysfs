;;;; -*- mode: lisp -*-

(defpackage #:ru.bazon.cl-gpio-sysfs
  (:nicknames #:gpio-sysfs)
  (:use #:cl)
  (:export
   #:initialize-pin
   #:shutdown-pin
   #:write-pin))

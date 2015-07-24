;;;; -*- mode: lisp -*-

(in-package :ru.bazon.cl-gpio-sysfs)

(defparameter *gpio-sys-class-root* "/sys/class/gpio/")

(defun with-root (branch)
  (concatenate 'string *gpio-sys-class-root* branch))

(defun with-gpio (pin-number branch)
  (format nil "~a/gpio~a/~a" *gpio-sys-class-root* pin-number branch))

(defun check-gpio-availability ()
  (and (probe-file (with-root "export"))
       (probe-file (with-root "unexport"))))

(defun write-to (filename value)
  (with-open-file (s filename :direction :output :if-exists :overwrite)
    (princ value s)))

(defun direction-string (direction)
  (ecase direction
    (:out "out")
    (:in "in")))

(defun initialize-pin (pin-number direction value)
  (check-gpio-availability)
  (when (not (probe-file (with-gpio pin-number "")))
    (write-to (with-root "export") pin-number))
  (write-to (with-gpio pin-number "direction") (direction-string direction))
  (write-to (with-gpio pin-number "value") value))

(defun shutdown-pin (pin-number)
  (when (probe-file (with-gpio pin-number ""))
    (write-to (with-root "unexport") pin-number)))

(defun write-pin (pin-number value)
  (write-to (with-gpio pin-number "value") value))

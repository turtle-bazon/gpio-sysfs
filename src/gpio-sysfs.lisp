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

(defun read-from (filename)
  (with-open-file (s filename :direction :input)
    (read-line s)))

(defun direction-string (direction)
  (ecase direction
    (:out "out")
    (:in "in")))

(defun level-string (level)
  (ecase level
    (:low "0")
    (:high "1")))

(defun level-value (string)
  (cond ((equal string "0") :low)
        ((equal string "1") :high)
        (t (error "Only values 0 and 1 permitted."))))

(defun initialize-pin (pin-number)
  (check-gpio-availability)
  (when (probe-file (with-gpio pin-number ""))
    (write-to (with-root "unexport") pin-number))
  (write-to (with-root "export") pin-number))

(defun shutdown-pin (pin-number)
  (when (probe-file (with-gpio pin-number ""))
    (write-to (with-root "unexport") pin-number)))

(defun setup-direction (pin-number direction)
  (write-to (with-gpio pin-number "direction") (direction-string direction))
  :direction)

(defun set-level (pin-number level)
  (write-to (with-gpio pin-number "value") (level-string level))
  :level)

(defun get-level (pin-number)
  (level-value (read-from (with-gpio pin-number "value"))))


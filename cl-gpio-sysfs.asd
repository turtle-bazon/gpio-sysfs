;;;; -*- mode: lisp -*-

(defsystem :cl-gpio-sysfs
    :name "cl-gpio-sysfs"
    :author "Azamat S. Kalimoulline <turtle@bazon.ru>"
    :licence "Lessor Lisp General Public License"
    :version "0.0.1.0"
    :description "GPIO library via SYSFS"
    :components ((:module "src"
                          :components
                          ((:file "package")
                           (:file "gpio-sysfs" :depends-on ("package"))))))

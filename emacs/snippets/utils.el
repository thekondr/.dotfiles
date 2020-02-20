(defun tk/capitalize (s)
  "Convert the first character to upper case and leave the rest the same in S."
  (declare (side-effect-free t))
  (if (s-blank? s)
      ""
    (concat (upcase (substring s 0 1)) (substring s 1))))

(defun split-imports (string)
  (mapcar 's-trim (s-split "," string t)))

(defun generate-import (import)
  (format "import %s from './%s'" import import))

(defun generate-imports (imports)
  (s-join "\n" (mapcar 'generate-import imports)))

(defun generate-action-state (import)
  (format
   "import type { Action as %sAction, State as %sState } from './%s'"
   (s-upper-camel-case import) (s-upper-camel-case import) import))

(defun generate-actions-states (imports)
  (s-join "\n" (mapcar 'generate-action-state imports)))

(defun generate-reducers (imports)
  (s-join "\n" (mapcar '(lambda (i) (format "%s," i)) imports)))

(defun generate-actions (imports)
  (s-join "\n" (mapcar '(lambda (i) (format "| %sAction" (s-upper-camel-case i))) imports)))

(defun generate-states (imports)
  (s-join "\n" (mapcar '(lambda (i) (format "%s: %sState," i (s-upper-camel-case i))) imports)))

(provide 'snippets-utils)

(require 'emacs-config-base)

(defvar emacs-config/package|package-tag ":use-package")
(defvar emacs-config/package|keys
  (mapcar (lambda (x) (format "%s" x))
          use-package-keywords))

(defun emacs-config/package|map-subparts (obj types)
  (org-element-map (org-element-contents obj) types
    (lambda (o)
      (org-export-with-backend 'org-emacs-config-package o))
    nil nil types nil ))

(defun emacs-config/package|concat-subparts (obj)
  (apply 'concat (emacs-config/package|map-subparts obj '(headline src-block))))

(defun emacs-config/package|translate-headline (obj content props)
  (let* ((parts (split-string (org-element-property :raw-value obj) " "))
         (first (nth 0 parts)))
    (cond ((equal first emacs-config/package|package-tag)
           (concat "(use-package " (nth 1 parts) "\n"
                   (emacs-config/package|concat-subparts obj)
                   ")\n"))
          ((member first emacs-config/package|keys)
           (concat first " "
                   (apply 'concat (cdr parts)) "\n"
                   (emacs-config/package|concat-subparts obj)
                   "\n"))
          (t  (apply 'concat (emacs-config/package|map-subparts obj '(headline src-block)))))))

(defun emacs-config/package|translate-src-block (obj content props)
  (org-element-property :value obj))

(org-export-define-backend 'org-emacs-config-package
  '((headline . emacs-config/package|translate-headline)
    (src-block . emacs-config/package|translate-src-block)))

;;;###autoload
(defun emacs-config/package/tangle (target)
  (org-export-to-file 'org-emacs-config-package target nil))

(provide 'emacs-config-package)

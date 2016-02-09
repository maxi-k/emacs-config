
;; Should be ~/.emacs.d/user/
;; The base directory where all configuration takes place
(defvar emacs-config/dir (file-name-directory (or (buffer-file-name)
                                                    load-file-name)))
;; A non-version-controlled file in a subdirectory of the emacs config dir
;; For local setup. Gets loaded after the 'general' setup files in
;; emacs-config/dir
;; The directory where the actual elisp files are stored
(defvar emacs-config/elisp-dir (concat emacs-config/dir "elisp/"))
;; What org-mode property marks a file as emacs config
(defvar emacs-config/property-key "my-file-type")
(defvar emacs-config/file-type-map
  '(("emacs-config" . emacs-config/tangle)
    ("emacs-config-package" . emacs-config/package/tangle)))

(defvar emacs-config/languages '("emacs-lisp" "elisp"))

;; Set up an emacs-config-marker variable that may be used in a snippet to set
;; up emacs-config files
(defvar emacs-config-marker (concat "#+PROPERTY: " emacs-config/property-key " " (car (car emacs-config/file-type-map))))

(defmacro infile-no-traces (file &rest body)
  `(let ((no-traces|visited-p (get-file-buffer (expand-file-name ,file)))
         to-be-removed)
     (save-window-excursion
       (find-file ,file)
       (setq to-be-removed (current-buffer))
       ,@body)
     (unless no-traces|visited-p
       (kill-buffer to-be-removed))))

(put 'infile-no-traces 'lisp-indent-function 'defun)

(provide 'emacs-config-base)

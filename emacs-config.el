(require 'emacs-config-base)

(defun emacs-config/tangle (target)
  (org-babel-tangle nil target))

;;;###autoload
(defun emacs-config/tangle-file
    (file &optional quiet-error-p quiet-success-p keep-el-p)
  "Tangles given org-file to an elisp file in `emacs-config/elisp-dir`
if it is marked as emacs-config/file (#+PROPERTIES my-file-type emacs-config)
Also byte-compiles it"
  ;; Required for org tangling files
  (require 'org)
  (require 'ob-tangle)
  (require 'ox)
  (require 'emacs-config-package)
  (infile-no-traces file
    (let* ((file-type (assoc emacs-config/property-key org-file-properties))
           (config-type (assoc (cdr file-type)
                               emacs-config/file-type-map))
           (target (concat emacs-config/elisp-dir
                           (file-name-base file) ".el")))
      (when no-traces|visited-p
        (org-set-regexps-and-options))
      (if config-type
          (progn
            (funcall (cdr config-type) target)
            (byte-compile-file target nil)
            ;; Delete the .el file, only keep the .elc file
            (unless keep-el-p (delete-file target))
            (unless quiet-success-p
              (message (concat "Compiled and loaded " target))))
        (unless quiet-error-p
          (message (concat "File was not an emacs config file: " file)))))))

(defun emacs-config/tangle-current-file (&optional show-errors-p)
  (interactive "P")
  (emacs-config/tangle-file (buffer-file-name) (not show-errors-p)))

;;;###autoload
(defun emacs-config/compile (&optional delete-old-p)
  "Tangle all org mode files in the `emacs-config/dir` to
compiled elisp-files in the `emacs-config/elisp-dir` and load
them. Load the bootstrap file first, if it exists. Load the
local-config last. If called with a prefix argument, deletes the
content of the `emacs-config/elisp-dir` first."
  (interactive "P")
  ;; If called with prefix argument, the old elisp
  ;; directory is deleted first
  (when delete-old-p
    (delete-directory emacs-config/elisp-dir t nil))
  ;; If the elisp-directory does not exist, create
  ;; it and any missing parent directories
  (unless (file-exists-p emacs-config/elisp-dir)
    (make-directory emacs-config/elisp-dir t))
  ;; Tangle all the files in the emacs-config dir
  (let* ((general-config (directory-files emacs-config/dir t "\\.org$"))
         (local-config (if (has-local-config)
                           (directory-files emacs-config/local-dir t "\\.org$")
                         '())))
    (when (emacs-config/has-bootstrap-file)
        (emacs-config/tangle-file emacs-config/bootstrap-file)
        (require (intern
                  (file-name-base emacs-config/bootstrap-file))))
    (mapc #'emacs-config/tangle-file (append general-config local-config))))

;;;###autoload
(defun emacs-config/init ()
  "Add the folder with the tangled & compiled org-files
to the load-path"
  (add-to-list 'load-path emacs-config/elisp-dir)
  ;; If the elsip directory does not exist
  ;; (e.g if it was just pulled from git)
  ;; create it and compile the whole config
  (unless (file-exists-p emacs-config/elisp-dir)
    (emacs-config/compile))
  ;; Add all subdirectories of the config dir to the load-path
  (setq default-directory emacs-config/dir)
  (normal-top-level-add-subdirs-to-load-path))

(provide 'emacs-config)

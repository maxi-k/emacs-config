;;; emacs-config-autoloads.el --- automatically extracted autoloads
;;
;;; Code:


;;;### (autoloads nil "emacs-config" "emacs-config.el" (22197 12563
;;;;;;  0 0))
;;; Generated autoloads from emacs-config.el

(autoload 'emacs-config/tangle-file "emacs-config" "\
Tangles given org-file to an elisp file in `emacs-config/elisp-dir`
if it is marked as emacs-config/file (#+PROPERTIES my-file-type emacs-config)
Also byte-compiles it

\(fn FILE &optional QUIET-ERROR-P QUIET-SUCCESS-P KEEP-EL-P)" nil nil)

(autoload 'emacs-config/compile "emacs-config" "\
Tangle all org mode files in the `emacs-config/dir`
to compiled elisp-files in the `emacs-config/elisp-dir`
and load them.
If called with a prefix argument, deletes the content of
the `emacs-config/elisp-dir` first.

\(fn &optional DELETE-OLD-P)" t nil)

(autoload 'emacs-config/init "emacs-config" "\
Add the folder with the tangled & compiled org-files
to the load-path

\(fn)" nil nil)

;;;***

;;;### (autoloads nil "emacs-config-package" "emacs-config-package.el"
;;;;;;  (22196 35202 0 0))
;;; Generated autoloads from emacs-config-package.el

(autoload 'emacs-config/package/tangle "emacs-config-package" "\


\(fn TARGET)" nil nil)

;;;***

;;;### (autoloads nil nil ("emacs-config-base.el" "emacs-config-loaddefs.el")
;;;;;;  (22197 12566 897718 0))

;;;***

(provide 'emacs-config-autoloads)
;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; emacs-config-autoloads.el ends here

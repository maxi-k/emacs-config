;;; emacs-config-autoloads.el --- automatically extracted autoloads
;;
;;; Code:


;;;### (autoloads nil "emacs-config" "emacs-config.el" (22213 40283
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

;;;### (autoloads nil "emacs-config-base" "emacs-config-base.el"
;;;;;;  (22213 40394 0 0))
;;; Generated autoloads from emacs-config-base.el

(autoload 'has-local-config "emacs-config-base" "\
Returns non-nil if the file
`emacs-config/dir'/local/setup-local.org exists.

\(fn)" nil nil)

;;;***

;;;### (autoloads nil "emacs-config-package" "emacs-config-package.el"
;;;;;;  (22200 52546 0 0))
;;; Generated autoloads from emacs-config-package.el

(autoload 'emacs-config/package/tangle "emacs-config-package" "\


\(fn TARGET)" nil nil)

;;;***

;;;### (autoloads nil nil ("emacs-config-loaddefs.el" "emacs-config-pkg.el")
;;;;;;  (22213 40424 872468 0))

;;;***

(provide 'emacs-config-autoloads)
;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; emacs-config-autoloads.el ends here

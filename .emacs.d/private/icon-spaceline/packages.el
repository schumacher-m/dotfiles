(defconst icon-spaceline-packages
  '(all-the-icons
    spaceline
    spaceline-all-the-icons))

(defun icon-spaceline/init-all-the-icons ()
  (use-package all-the-icons
    :config (setq neo-theme 'icons)))

(defun icon-spaceline/init-spaceline ()
  (use-package spaceline))

(defun icon-spaceline/init-spaceline-all-the-icons ()
  (use-package spaceline-all-the-icons
    :after spaceline
    :config (progn
              (spaceline-all-the-icons-theme)
              (setq spaceline-all-the-icons-separator-type 'arrow))))

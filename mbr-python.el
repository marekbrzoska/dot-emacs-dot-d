(unless 
    (boundp 'mbr-python-settings-loaded) 
    (progn 
      (require 'pymacs)
      (setq mbr-python-settings-loaded t)
      (pymacs-load "ropemacs" "rope-") 

      ;; zezwól na autoimporty w pythonie
      (setq ropemacs-enable-autoimport 't)

      ;; pyflakes do sprawdzania pythona
      (setq python-check-command "pyflakes")

      ;;używanie pyflakes przy flymake mode
      (when (load "flymake" t) 
	(defun flymake-pyflakes-init () 
	  (let* ((temp-file (flymake-init-create-temp-buffer-copy 
			     'flymake-create-temp-inplace)) 
		 (local-file (file-relative-name 
			      temp-file 
			      (file-name-directory buffer-file-name)))) 
	    (list "pyflakes" (list local-file))))
	(add-to-list 'flymake-allowed-file-name-masks 
		     '("\\.py\\'" flymake-pyflakes-init)))
      (add-hook 'find-file-hook 'flymake-find-file-hook)


      (global-set-key (kbd "C-/") 'rope-code-assist) 
    )
)
(flymake-mode 1)

;;; Commentary:
;; package install eclim and company-emacs-eclim first
;;; Code:
(defun my-java-mode-hook ()
  (eclim-mode t)
  (company-emacs-eclim-setup)
  (company-mode t))
(add-hook 'java-mode-hook 'my-java-mode-hook)
(provide 'init-java)

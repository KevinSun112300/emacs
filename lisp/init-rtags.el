;;; Commentary:
;; package install eclim and company-emacs-eclim first
;;; Code:

;;(require 'rtags)
;;(require 'company)
;;(push 'company-rtags company-backends)
(defun setup-flycheck-rtags ()
  "Init rags flycheck."
  (interactive)
  (flycheck-select-checker 'rtags)

  ;; RTags creates more accurate overlays.
  (setq-local flycheck-highlighting-mode nil)
  (setq-local flycheck-check-syntax-automatically nil))

(defun init-rtags-mode-hook ()


  (when (require 'rtags nil :noerror)
    ;; make sure you have company-mode installed
    (require 'company)
    (define-key c-mode-base-map (kbd "M-.")
      (function rtags-find-symbol-at-point))
    (define-key c-mode-base-map (kbd "M-,")
      (function rtags-find-references-at-point))
    ;; disable prelude's use of C-c r, as this is the rtags keyboard prefix
    ;;(define-key prelude-mode-map (kbd "C-c r") nil)
    ;; install standard rtags keybindings. Do M-. on the symbol below to
    ;; jump to definition and see the keybindings.
    (rtags-enable-standard-keybindings)
    ;; comment this out if you don't have or don't use helm
    (setq rtags-use-helm t)
    ;; company completion setup
    (setq rtags-autostart-diagnostics t)
    (rtags-diagnostics)
    (setq rtags-completions-enabled t)
    (cl-pushnew 'company-rtags company-backends)
    (global-company-mode)
    (define-key c-mode-base-map (kbd "<C-tab>") (function company-complete))
    ;; use rtags flycheck mode -- clang warnings shown inline
    (require 'flycheck-rtags)
    ;; c-mode-common-hook is also called by c++-mode
    (add-hook 'c-mode-hook #'setup-flycheck-rtags)
    (add-hook 'c++-mode-hook #'setup-flycheck-rtags))

  )
(add-hook 'c-mode-hook #'init-rtags-mode-hook)
(add-hook 'c++-mode-hook #'init-rtags-mode-hook)

(provide 'init-rtags)

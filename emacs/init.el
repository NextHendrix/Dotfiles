;;; NextHendrix init file - actually no evil this time edition

;; Remove crusty UI
(tool-bar-mode 0)
(menu-bar-mode 0)
(scroll-bar-mode 0)

;; Startup
(setq inhibit-startup-screen t)
(setq initial-major-mode 'org-mode)
(setq initial-scratch-message "")

;; Stop emacs shitting files all over the place
(setq make-backup-files nil) ; stop creating backup~ files
(setq auto-save-default nil) ; stop creating #autosave# files
(setq custom-file "~/.emacs.d/custom.el") ; stop polluting my init file
(load custom-file 'noerror) ; and stop moaning about it

;; Package stuff
(require 'package)
(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                    (not (gnutls-available-p))))
       (url (concat (if no-ssl "http" "https") "://melpa.org/packages/")))
  (add-to-list 'package-archives (cons "melpa" url) t))
(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))
(package-initialize)

(unless (package-installed-p 'magit)
  (package-refresh-contents))

(defvar mypackages '(magit
		     ivy
		     counsel))
(dolist (p mypackages)
  (when (not (package-installed-p p))
    (package-install p)))

;; Ivy Mode
(ivy-mode 1)
(setq ivy-use-selectable-prompt t)
(global-set-key "\C-s" 'swiper)
(global-set-key (kbd "C-x C-f") 'counsel-find-file)
(global-set-key (kbd "M-x") 'counsel-M-x)
;; Org Mode
(require 'org)
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(setq org-log-done t)

;;; init --- Actually no evil-mode this time edition

;;; Commentary:
;; NextHendrix - Started 16/11/2017

;;; Code:
;; Remove crusty UI
(tool-bar-mode 0)
(menu-bar-mode 0)
(scroll-bar-mode 0)

;; Startup
(setq inhibit-startup-screen t) ; no splash
(setq initial-major-mode 'org-mode) ; scratch be org
(setq initial-scratch-message "") ; empty scratch
(setq vc-follow-symlinks t) ; don't prompt for following symlinks

;; Stop emacs shitting files all over the place
(setq make-backup-files nil) ; stop creating backup~ files
(setq auto-save-default nil) ; stop creating #autosave# files
(setq custom-file "~/.emacs.d/custom.el") ; stop polluting my init file
(load custom-file 'noerror) ; and stop moaning about it

;; Package stuff
(require 'package)
(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos)) ; add melpa
                    (not (gnutls-available-p))))
       (url (concat (if no-ssl "http" "https") "://melpa.org/packages/")))
  (add-to-list 'package-archives (cons "melpa" url) t))

(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))

(package-initialize) ; go!

(unless (package-installed-p 'magit) ; only refresh if nothing's installed
  (package-refresh-contents))

(defvar init--mypackages '(magit
		     ivy
		     counsel
		     flycheck))

(dolist (p init--mypackages) ; install my packages
  (when (not (package-installed-p p))
    (package-install p)))

;; Ivy Mode
(require 'ivy)
(ivy-mode 1) ; enable globally
(setq ivy-use-selectable-prompt t) ; select files not in list
(global-set-key "\C-s" 'swiper) ; improved i-search
(global-set-key (kbd "C-x C-f") 'counsel-find-file) ; better open files
(global-set-key (kbd "M-x") 'counsel-M-x) ; better run shit

;; Org Mode
(require 'org)
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(setq org-log-done t)

;; Flycheck
(global-flycheck-mode t)

(provide 'init)
;;; init.el ends here

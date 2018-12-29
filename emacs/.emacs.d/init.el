;;; NextHendrix init (innit)

;; Disregard tmpfiles
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

;; Custom file
(setq custom-file "~/.emacs.d/custom.el")
(load custom-file 'noerror)

;; Visual Tweaks
(menu-bar-mode 0)
(tool-bar-mode 0)
(tooltip-mode 0)
(scroll-bar-mode 0)
(column-number-mode t)
(line-number-mode t)
(show-paren-mode t)
(display-time-mode t)
(global-visual-line-mode)
(setq inhibit-startup-screen t)
(setq inhibit-startup-echo-area-message "chris")

;; Terminal Mouse Control
(when (eq window-system nil)
  (xterm-mouse-mode t))

;; Follow Symlinks
(setq vc-follow-symlinks t)

;; Package Memery
(require 'package)
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
			 ("gnu" . "http://elpa.gnu.org/packages/")))
(package-initialize)

;; Use use-package package
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(require 'use-package)

;; Flycheck
(use-package flycheck
  :ensure t
  :commands global-flycheck-mode
  :init
  (global-flycheck-mode))

;; Company
(use-package company
  :ensure t
  :commands global-company-mode
  :init
  (global-company-mode))

;; Guru Mode
(use-package guru-mode
  :ensure t
  :commands guru-global-mode
  :init
  (guru-global-mode))

;; RCIRC
(use-package rcirc
  :ensure t
  :commands irc
  :config
  (setq rcirc-server-alist
	'(("finickitively.co.uk"
	   :port 6697
	   :encryption tls))))

;; Swiper
(use-package swiper
  :ensure t
  :bind ("C-s" . swiper))

;; Ace Window
(use-package ace-window
  :ensure t
  :bind ("C-x o" . ace-window))
;; Magit
(use-package magit
  :ensure t)

;; IBuffer
(use-package ibuffer
  :bind ("C-x C-b" . ibuffer))

;; Smex
(use-package smex
  :ensure t
  :bind (("M-x" . smex)
	 ("M-X" . smex-major-mode-commands)
	 ("C-c C-c M-x" . execute-extended-command)))

  ;; Done!
(message "Nice one mate")

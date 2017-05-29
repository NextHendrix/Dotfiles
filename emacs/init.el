;;; NextHendrix --- init.el mk3: clean and tidy edition

;;; Commentary:
;; This is now the third full refresh of a proper Emacs init.el
;; I very much doubt it will be the last
;; This little commentary is only here because otherwise flycheck shits its pants
;; Anyway lets get on with it


;;; Code:
;; Initial Package Setup and Installation
; Add some package archives
(require 'package)
(add-to-list 'package-archives '("marmalade" . "https://marmalade-repo.org/packages/"))
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
;(package-refresh-contents)

; Set up list of packages to install if missing
(defvar chris-packages '(magit
			 smex
			 auctex
			 smartparens
			 evil-escape
			 evil-smartparens
			 haskell-mode
			 hindent
			 ivy
			 counsel
			 swiper
			 intero
			 js3-mode
			 web-mode
			 json-mode
			 flycheck
			 key-seq
			 flycheck-haskell
			 evil
			 gruvbox-theme
			 rainbow-delimiters
			 rainbow-blocks
			 rainbow-identifiers
			 ghc))

; Separate custom-set-variables now or package-install cocks it up
(setq custom-file "~/.emacs.d/custom.el")

; Download and install any missing packages
(package-initialize)
(dolist (p chris-packages)
  (when (not (package-installed-p p))
    (package-install p)))

;; General interface options
(column-number-mode t)
(display-time-mode t)
(tool-bar-mode 0)
(menu-bar-mode 0)
(scroll-bar-mode 0)

; Make sure Emacs doesn't chuck fucking mess everywhere
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

; And follow symlinks
(setq vc-follow-symlinks t)

; Taste the rainbow
(rainbow-delimiters-mode t)

;; Evil mode, must be first since it's used everywhere
; Enable and make sure keychords are on
(require 'evil)
(evil-mode t)
(evil-escape-mode t)
(key-chord-mode t)
(setq-default evil-escape-key-sequence "jk")

;; Company mode
(require 'company)
(require 'company-dabbrev)
(setq company-idle-delay 0)
(setq company-dabbrev-downcase 0)
(global-company-mode t)

;; Smartparens
(require 'smartparens)
(smartparens-global-mode t)

;; Ivy Mode
(require 'ivy)
(require 'counsel)
(require 'swiper)
(ivy-mode t)
(global-set-key (kbd "M-x") 'counsel-M-x)
(global-set-key (kbd "C-x C-f") 'counsel-find-file)

;; Speedbar
(require 'speedbar)
(speedbar-add-supported-extension ".hs")
(global-set-key (kbd "<f12>") 'sr-speedbar-toggle)
;; Flycheck Mode
; Enable globally
(require 'flycheck)
(global-flycheck-mode 1)

;; Haskell Mode
(setq haskell-stylish-on-save t)
(setq haskell-tags-on-save t)
(add-hook 'haskell-mode-hook 'hindent-mode)
(add-hook 'haskell-mode-hook 'interactive-haskell-mode)

;; Dired
(add-hook 'dired-hook 'evil-mode)
;; Web Mode
(add-to-list 'auto-mode-alist '("\\.html$" . web-mode))

;; Markdown Mode
(add-to-list 'auto-mode-alist `("\\.md$" . markdown-mode))

;; Javascript Mode
(add-to-list 'auto-mode-alist '("\\.js$" . js3-mode))
(setq-default flycheck-disabled-checkers
	     (append flycheck-disabled-checkers
		     '(javascript-jshint javascript-jscs javascript-eslint)))
;; Org Mode
(require 'org)
(setq org-format-latex-options (plist-put org-format-latex-options :scale 2.0))

; Fix horrible theme overlapping
(defadvice load-theme (before theme-dont-propagate activate)
 (mapc #'disable-theme custom-enabled-themes))

;; Appendages
(load custom-file)

; Load a theme -- has to go after load-custom-file
(load-theme 'gruvbox)

(add-to-list 'default-frame-alist '(font . "Fira Mono-10"))

(provide 'init)
;;; init.el ends here

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
(defvar chris-packages '(;exwm
			 magit
			 smex
			 auctex
			 smartparens
			 evil-smartparens
			 haskell-mode
			 hindent
			 intero
			 js3-mode
			 web-mode
			 json-mode
			 flycheck
			 key-seq
			 flycheck-haskell
			 evil
			 gruvbox-theme
			 rainbow-mode
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

; Sets up exwm, will need iffing out for non-X emacs
;(require 'exwm)
;(require 'exwm-config)
;(exwm-config-default)

;; General interface options
(column-number-mode t)
(display-time-mode t)
(tool-bar-mode 0)
(menu-bar-mode 0)
(scroll-bar-mode 0)

; New window split bindings
(global-set-key (kbd "C-x -") 'split-window-vertically)
(global-set-key (kbd "C-x |") 'split-window-horizontally)

; Make sure Emacs doesn't chuck fucking mess everywhere
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

;; Evil mode, must be first since it's used everywhere
; Enable and make sure keychords are on
(require 'evil)
(key-chord-mode t)

(key-seq-define-global "jk" 'evil-normal-state)

;; Smartparens
(require 'smartparens')
(smartparens-global-mode 1)
;; Ido Mode
; Enable and set up
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode 1)

; Enable guessing filenames at point
(setq ido-use-filename-at-point 'guess)

;; Smex Mode
; Initilalize and keybindings
(require 'smex)
(smex-initialize)
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)

;; Flycheck Mode
; Enable globally
(require 'flycheck)
(global-flycheck-mode 1)

;; Haskell Mode
;(autoload 'ghc-init "ghc" nil t)
;(autoload 'ghc-debug "ghc" nil t)
;(add-hook 'haskell-mode-hook (lambda () (ghc-init)))
(add-hook 'haskell-mode-hook (lambda () (hindent-mode 1)))
(add-hook 'haskell-mode-hook (lambda () (evil-mode 1)))
(add-hook 'haskell-mode-hook (lambda () (intero-mode 1)))
(add-hook 'haskell-mode-hook 'evil-smartparens-mode)

;; Dired
(add-hook 'dired-hook '(lambda () (evil-mode t)))
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

;; Appendages
(load custom-file)

; Load a theme -- has to go after load-custom-file
(load-theme 'gruvbox)

(add-to-list 'default-frame-alist '(font . "Fira Mono-10"))

(provide 'init)
;;; init.el ends here

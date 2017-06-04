;;; NextHendrix --- init.el mk3: clean and tidy edition

;;; Commentary:
;; This is now the third full refresh of a proper Emacs init.el
;; I very much doubt it will be the last
;; This little commentary is only here because otherwise flycheck shits its pants
;; Anyway lets get on with it


;;; Code:
;; Initial Package Setup and Installation
; Add some package archives
(add-to-list 'load-path "~/.emacs.d/lisp/")
(require 'package)
(add-to-list 'package-archives '("gnu" . "https://elpa.gnu.org/packages/"))
(add-to-list 'package-archives '("marmalade" . "https://marmalade-repo.org/packages/"))
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(package-refresh-contents)

; Set up list of packages to install if missing
(defvar chris-packages '(anaconda-mode
			 auctex
			 auctex-latexmk
			 company-anaconda
			 company-jedi
			 counsel
			 counsel-projectile
			 erc-image
			 erc-yt
			 evil
			 evil-escape
			 evil-magit
			 evil-org
			 evil-smartparens
			 flycheck
			 flycheck-haskell
			 ghc
			 haskell-mode
			 hindent
			 intero
			 ivy
			 jedi
			 js3-mode
			 json-mode
			 key-seq
			 magit
			 markdown-mode
			 py-yapf
			 python-mode
			 python
			 rainbow-delimiters
			 smartparens
			 spacemacs-theme
			 swiper
			 web-mode
			 yaml-mode))

; Separate custom-set-variables now or package-install cocks it up
(setq custom-file "~/.emacs.d/custom.el")

; Set exec path
(setq exec-path (append exec-path '("~/.local/bin/")))

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

;; ERC
(require 'erc)
(require 'erc-tex)
(require 'erc-image)
(require 'erc-yt)
(setq erc-image-inline-rescale "window")
(setq erc-tex-image-size 2.0)
(add-to-list 'erc-modules 'tex)
(add-to-list 'erc-modules 'youtube)
(add-to-list 'erc-modules 'image)
(erc-update-modules)
(setq-default erc-user-full-name "NextHendrix")
(setq-default erc-nick "NextHendrix")
(setq-default erc-server "nexthendr.tk")
(setq-default erc-port "5555")
(setq erc-interpret-controls-p t)
(setq erc-interpret-mirc-color t)
(add-hook 'erc-mode-hook 'erc-tex-mode)
(add-hook 'erc-mode-hook 'erc-colorize-mode)
(add-hook 'erc-mode-hook 'erc-image-mode)
(defun get-time()
  "Fetches the time"
  (shell-command-to-string "date"))
(defun get-uptime()
  "Fetches uptime"
  (shell-command-to-string "uptime"))
(defun get-uname()
  "Fetches uname -a"
  (shell-command-to-string "uname -a"))
(defun erc-cmd-TIME()
  "Sends the result of 'date' to erc buffer"
  (erc-send-message (get-time)))
(defun erc-cmd-UPTIME()
  "Sends the result of 'uptime' to erc buffer"
  (erc-send-message (get-uptime)))
(defun erc-cmd-UNAME()
  "Sends the result of 'uname -a' to erc buffer"
  (erc-send-message (get-uname)))
(defun fortune()
  "Gets a fortune"
  (shell-command-to-string "fortune -a"))
(defun erc-cmd-FORTUNE()
  "Send a fortune to ERC"
  (erc-send-message (fortune)))
(defun fortuno()
  "Gets a fortune"
  (shell-command-to-string "fortune -o"))
(defun erc-cmd-FORTUNO()
  "Send an offensive fortune to ERC"
  (erc-send-message (fortune)))

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
(require 'haskell)
(require 'haskell-interactive-mode)
(require 'haskell-process)
(setq haskell-stylish-on-save t)
(setq haskell-tags-on-save t)
(add-hook 'haskell-mode-hook 'interactive-haskell-mode)
(add-hook 'haskell-mode-hook 'hindent-mode)
(setq haskell-process-suggest-remove-import-lines t)
(setq haskell-process-auto-import-loaded-modules t)
(setq haskell-process-log t)
(setq haskell-process-type 'stack-ghci)

;; Dired
(add-hook 'dired-hook 'evil-mode)

;; Web Mode
(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.html$" . web-mode))

;; Markdown Mode
(require 'markdown-mode)
(add-to-list 'auto-mode-alist `("\\.md$" . markdown-mode))

;; Javascript Mode
(add-to-list 'auto-mode-alist '("\\.js$" . js3-mode))
(setq-default flycheck-disabled-checkers
	     (append flycheck-disabled-checkers
		     '(javascript-jshint javascript-jscs javascript-eslint)))
;; Org Mode
(require 'org)
(setq org-format-latex-options (plist-put org-format-latex-options :scale 2.0))

;; Latex Mode
(require 'auctex-latexmk)
(auctex-latexmk-setup)

;; Python Mode
(add-hook 'py-mode-hook 'anaconda-mode)
(add-hook 'py-mode-hook 'jedi-mode)

;; PDF Mode
(pdf-tools-install)
(add-to-list 'auto-mode-alist '("\\.pdf\\'" . pdf-view-mode))

;; Appendages
(load custom-file)

; Fix horrible theme overlapping
(defadvice load-theme (before theme-dont-propagate activate)
 (mapc #'disable-theme custom-enabled-themes))

; Load a theme -- has to go after load-custom-file
(load-theme 'spacemacs-dark)

(add-to-list 'default-frame-alist '(font . "Fira Mono-10"))

(provide 'init)
;;; init.el ends here

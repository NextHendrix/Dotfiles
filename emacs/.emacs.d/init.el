;;; init.el -- Post customise
;;; Commentary:
;; So long and thanks for all the fish.

;;; Code:
;; Set load path for extra stuff
(add-to-list 'load-path "~/.emacs.d/lisp")
(setq exec-path (append '("~/.local/bin/") exec-path))

;; Fuck off with your stupid~ #tmpfiles# bullshit
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

;; Package memery
(require 'package)
(package-initialize)
(setq package-enable-at-startup t)
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
			 ("melpa" . "https://melpa.org/packages/")))
(unless package-archive-contents
  (package-refresh-contents))

;; Visual Tweaks
(menu-bar-mode 0)
(tool-bar-mode 0)
(scroll-bar-mode 0)
(column-number-mode t)
(show-paren-mode t)
(setq inhibit-startup-screen t)
(setq inhibit-startup-echo-area-message "chris")

;; Let customise do its thing
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["#0d0d0d" "#cc6666" "#b5bd68" "#f0c674" "#81a2be" "#c9b4cf" "#8abeb7" "#ffffff"])
 '(custom-safe-themes
   (quote
    ("0598de4cc260b7201120b02d580b8e03bd46e5d5350ed4523b297596a25f7403" "891debfe489c769383717cc7d0020244a8d62ce6f076b2c42dd1465b7c94204d" "4597d1e9bbf1db2c11d7cf9a70204fa42ffc603a2ba5d80c504ca07b3e903770" "bbb4a4d39ed6551f887b7a3b4b84d41a3377535ccccf901a3c08c7317fad7008" "723e48296d0fc6e030c7306c740c42685d672fd22337bc84392a1cf92064788a" "4e21fb654406f11ab2a628c47c1cbe53bab645d32f2c807ee2295436f09103c6" "a866134130e4393c0cad0b4f1a5b0dd580584d9cf921617eee3fd54b6f09ac37" "242ed4611e9e78142f160e9a54d7e108750e973064cee4505bfcfc22cc7c61b1" "013c62a1fcee7c8988c831027b1c38ae215f99722911b69e570f21fc19cb662e" "53d1bb57dadafbdebb5fbd1a57c2d53d2b4db617f3e0e05849e78a4f78df3a1b" "aa0a998c0aa672156f19a1e1a3fb212cdc10338fb50063332a0df1646eb5dfea" "5715d3b4b071d33af95e9ded99a450aad674e308abb06442a094652a33507cd2" "c5d320f0b5b354b2be511882fc90def1d32ac5d38cccc8c68eab60a62d1621f2" "e11569fd7e31321a33358ee4b232c2d3cf05caccd90f896e1df6cab228191109" default)))
 '(display-time-mode t)
 '(fci-rule-color "#5c5e5e")
 '(jdee-db-active-breakpoint-face-colors (cons "#0d0d0d" "#41728e"))
 '(jdee-db-requested-breakpoint-face-colors (cons "#0d0d0d" "#b5bd68"))
 '(jdee-db-spec-breakpoint-face-colors (cons "#0d0d0d" "#5a5b5a"))
 '(package-selected-packages
   (quote
    (rainbow-mode yaml-mode unicode-fonts ace-window erc-hl-nicks erc-colorize doom-themes erc-image auctex auctex-lua counsel ivy magit guru-mode pdf-tools company company-ghc company-ghci haskell-mode flycheck hindent hlint-refactor zenburn-theme sr-speedbar)))
 '(unicode-fonts-fallback-font-list (quote ("Symbola" "Quivira" "Noto Sans Symbols")))
 '(unicode-fonts-skip-font-groups nil)
 '(vc-annotate-background "#0d0d0d")
 '(vc-annotate-color-map
   (list
    (cons 20 "#b5bd68")
    (cons 40 "#c8c06c")
    (cons 60 "#dcc370")
    (cons 80 "#f0c674")
    (cons 100 "#eab56d")
    (cons 120 "#e3a366")
    (cons 140 "#de935f")
    (cons 160 "#d79e84")
    (cons 180 "#d0a9a9")
    (cons 200 "#c9b4cf")
    (cons 220 "#ca9aac")
    (cons 240 "#cb8089")
    (cons 260 "#cc6666")
    (cons 280 "#af6363")
    (cons 300 "#936060")
    (cons 320 "#765d5d")
    (cons 340 "#5c5e5e")
    (cons 360 "#5c5e5e")))
 '(vc-annotate-very-old-color nil))
;; And fonts please
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Input Mono Narrow" :foundry "FBI " :slant normal :weight light :height 115 :width condensed))))
 '(erc-input-face ((t (:foreground "light sky blue"))))
 '(erc-my-nick-face ((t (:foreground "light sky blue" :weight extra-bold)))))

;; Install stuff
(dolist (package package-selected-packages)
  (unless (package-installed-p package)
    (package-install package)))

;; theme
(defvar my:theme 'doom-one)
(defvar my:theme-window-loaded nil)
(defvar my:theme-terminal-loaded nil)

(if (daemonp)
    (add-hook 'after-make-frame-functions
	      (lambda (frame)
		(select-frame frame)
		(if (window-system frame)
		    (unless my:theme-window-loaded
		      (if my:theme-terminal-loaded
			  (enable-theme my:theme)
			(load-theme my:theme t))
		      (setq my:theme-window-loaded t))
		  (unless my:theme-terminal-loaded
		    (if my:theme-window-loaded
			(enable-theme my:theme)
		      (load-theme my:theme t))
		    (setq my:theme-terminal-loaded t)))))
  (progn
    (load-theme my:theme t)
    (if (display-graphic-p)
        (setq my:theme-window-loaded t)
      (setq my:theme-terminal-loaded t))))

;; Guru Mode
(guru-global-mode t)

;; Unicode
(require 'unicode-fonts)
(unicode-fonts-setup)

;; Ace Windows
(require 'ace-window)
(global-set-key (kbd "M-o") 'ace-window)

;; Counsel
(require 'counsel)
(counsel-mode t)
(global-set-key (kbd "C-s") 'swiper)
(setq ivy-use-virtual-buffers t)
(setq enable-recursive-minibuffers t)

;; IBuffer
(global-set-key (kbd "C-x C-b") 'ibuffer)
(autoload 'ibuffer "ibuffer" "List Buffers." t)

;; Company
(require 'company)
(global-company-mode t)

;; Flycheck
(require 'flycheck)
(global-flycheck-mode t)
(setq flycheck-global-modes t)

;; PDF Tools
(require 'pdf-tools)
(pdf-tools-install)
(setq pdf-view-use-imagemagick t)
(setq pdf-view-use-dedicated-register t)
(setq pdf-view-use-scaling t)

;; Haskell Mode
(require 'haskell-mode)
(add-hook 'haskell-mode-hook 'interactive-haskell-mode)
(add-hook 'haskell-mode-hook 'haskell-indentation-mode)
(defun nh-haskell-interactive-mode-config ()
  "Use in haskell-interactive-mode hook."
  (local-set-key (kbd "C-c C-b") 'haskell-interactive-switch-back)
  (local-set-key (kbd "C-c C-z") nil))
(add-hook 'haskell-interactive-mode-hook 'nh-haskell-interactive-mode-config)
(setq haskell-font-lock-symbols t)

;; ERC
(require 'erc-settings)

;; Prog Mode
(add-hook 'prog-mode-hook 'linum-mode)
(add-hook 'prog-mode-hook 'prettify-symbols-mode)

(message "fuckin nice one mate, we made it")
(provide 'init)
;;; init.el ends here

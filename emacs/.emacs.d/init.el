;;; init.el -- Post customise
;;; Commentary:
;; So long and thanks for all the fish.

;;; Code:
;; Set load path for extra stuff
(add-to-list 'load-path "~/.emacs.d/lisp")

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
 '(custom-enabled-themes (quote (zenburn)))
 '(custom-safe-themes
   (quote
    ("e11569fd7e31321a33358ee4b232c2d3cf05caccd90f896e1df6cab228191109" default)))
 '(package-selected-packages
   (quote
    (auctex auctex-lua counsel ivy magit guru-mode pdf-tools company company-ghc company-ghci haskell-mode flycheck hindent hlint-refactor zenburn-theme sr-speedbar))))
;; And fonts please
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Input Mono Narrow" :foundry "FBI " :slant normal :weight normal :height 108 :width semi-condensed)))))

;; Install stuff
(dolist (package package-selected-packages)
  (unless (package-installed-p package)
    (package-install package)))

;; Counsel
(require 'counsel)
(counsel-mode t)
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

;; Set load path for extra stuff
(add-to-list 'load-path "~/.emacs.d/lisp")
(setq exec-path (append '("~/.local/bin/") exec-path))

;; Fuck off with your stupid~ #tmpfiles# bullshit
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

;; Package memery
(setq package-list
      '(magit
	auctex
	flycheck
	guru-mode
	ace-window
	counsel
	company
	pdf-tools))

(require 'package)
(setq package-enable-at-startup t)
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
			 ("melpa" . "https://melpa.org/packages/")))
(package-initialize)

(unless package-archive-contents
  (package-refresh-contents))

(dolist (package package-list)
  (unless (package-installed-p package)
    (package-install package)))

;; Visual Tweaks
(menu-bar-mode 0)
(tool-bar-mode 0)
(scroll-bar-mode 0)
(column-number-mode t)
(show-paren-mode t)
(display-time-mode t)
(setq inhibit-startup-screen t)
(setq inhibit-startup-echo-area-message "chris")

;; Org Mode
(require 'org)
(setq org-format-latex-options
      (plist-put org-format-latex-options :scale 2.5))

;; Guru Mode
(require 'guru-mode)
(guru-global-mode t)

;; Ace Windows
(require 'ace-window)
(global-set-key (kbd "C-x o") 'ace-window)

;; Counsel Mode
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

;; Prog Mode
(add-hook 'prog-mode-hook 'linum-mode)
(add-hook 'prog-mode-hook 'prettify-symbols-mode)

;; Python
(require 'python)
(setq python-shell-interpreter "python3")

;; Done!
(message "Nice one mate")
(provide 'init)

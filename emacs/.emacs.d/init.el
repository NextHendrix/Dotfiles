;;; init.el -- Let's trust customize edition - NextHendrix - Started 04-04-2018
;;; Commentary:
;; Stop pissing about and revise for your exams you twat
;; Customise isn't totally trustworthy, package stuff rejigged somewhat to actually work

;;; Code:

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
			 ("melpa" . "https://melpa.org/packages/")))
(unless package-archive-contents
  (package-refresh-contents))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(company-backends
   (quote
    (company-bbdb company-nxml company-css company-eclim company-semantic company-clang company-xcode company-cmake company-capf company-files
		  (company-dabbrev-code company-gtags company-etags company-keywords)
		  company-oddmuse company-dabbrev)))
 '(company-frontends
   (quote
    (company-pseudo-tooltip-unless-just-one-frontend company-echo-metadata-frontend company-preview-if-just-one-frontend)))
 '(custom-enabled-themes (quote (zenburn)))
 '(custom-safe-themes
   (quote
    ("e11569fd7e31321a33358ee4b232c2d3cf05caccd90f896e1df6cab228191109" default)))
 '(erc-modules
   (quote
    (autojoin button completion dcc fill irccontrols keep-place list match menu move-to-prompt netsplit networks noncommands notifications readonly ring scrolltobottom smiley stamp spelling)))
 '(erc-nick "NextHendrix")
 '(erc-notifications-icon nil)
 '(erc-paranoid t)
 '(erc-port 5555)
 '(erc-prompt ">")
 '(erc-server "finickitively.co.uk")
 '(erc-track-minor-mode nil)
 '(erc-track-mode nil)
 '(erc-user-full-name "NextHendrix")
 '(erc-user-mode nil)
 '(flycheck-checkers
   (quote
    (ada-gnat asciidoctor asciidoc c/c++-clang c/c++-gcc c/c++-cppcheck cfengine chef-foodcritic coffee coffee-coffeelint coq css-csslint css-stylelint cwl d-dmd dockerfile-hadolint elixir-dogma emacs-lisp emacs-lisp-checkdoc erlang-rebar3 erlang eruby-erubis fortran-gfortran go-gofmt go-golint go-vet go-build go-test go-errcheck go-unconvert go-megacheck groovy haml handlebars haskell-ghc haskell-hlint html-tidy javascript-eslint javascript-jshint javascript-standard json-jsonlint json-python-json jsonnet less less-stylelint llvm-llc lua-luacheck lua perl perl-perlcritic php php-phpmd php-phpcs processing proselint protobuf-protoc pug puppet-parser puppet-lint python-flake8 python-pylint python-pycompile r-lintr racket rpm-rpmlint markdown-markdownlint-cli markdown-mdl nix rst-sphinx rst ruby-rubocop ruby-reek ruby-rubylint ruby ruby-jruby rust-cargo rust rust-clippy scala scala-scalastyle scheme-chicken scss-lint scss-stylelint sass/scss-sass-lint sass scss sh-bash sh-posix-dash sh-posix-bash sh-zsh sh-shellcheck slim slim-lint sql-sqlint systemd-analyze tcl-nagelfar tex-chktex tex-lacheck texinfo typescript-tslint verilog-verilator vhdl-ghdl xml-xmlstarlet xml-xmllint yaml-jsyaml yaml-ruby)))
 '(flycheck-global-modes t)
 '(flycheck-highlighting-mode (quote sexps))
 '(global-company-mode t)
 '(global-flycheck-mode t)
 '(guru-global-mode t)
 '(haskell-interactive-mode-hide-multi-line-errors t)
 '(haskell-interactive-popup-errors nil)
 '(haskell-mode-hook
   (quote
    (flyspell-prog-mode haskell-decl-scan-mode haskell-indentation-mode highlight-uses-mode imenu-add-menubar-index interactive-haskell-mode hlint-haskell-mode-hook)))
 '(haskell-process-suggest-hoogle-imports t)
 '(haskell-process-suggest-remove-import-lines t)
 '(ido-everywhere t)
 '(inhibit-startup-echo-area-message "chris")
 '(inhibit-startup-screen t)
 '(linum-format (quote dynamic))
 '(package-enable-at-startup t)
 '(package-selected-packages
   (quote
    (auctex-lua auctex erc-colorize guru-mode zenburn-theme pdf-tools magit company-ghci company-ghc company hindent hlint-refactor haskell-mode flycheck)))
 '(pdf-tools-enabled-modes
   (quote
    (pdf-history-minor-mode pdf-isearch-minor-mode pdf-links-minor-mode pdf-misc-minor-mode pdf-outline-minor-mode pdf-misc-size-indication-minor-mode pdf-misc-menu-bar-minor-mode pdf-annot-minor-mode pdf-sync-minor-mode pdf-misc-context-menu-minor-mode pdf-cache-prefetch-minor-mode pdf-occur-global-minor-mode pdf-virtual-global-minor-mode)))
 '(pdf-view-use-imagemagick t)
 '(pdf-view-use-scaling t)
 '(prog-mode-hook
   (quote
    (flyspell-prog-mode abbrev-mode linum-mode prettify-symbols-mode)))
 '(save-place t)
 '(scroll-bar-mode nil)
 '(show-paren-mode t)
 '(speedbar-select-frame-method (quote attached))
 '(speedbar-vc-directory-enable-hook nil)
 '(text-mode-hook (quote (turn-on-flyspell text-mode-hook-identify)))
 '(tool-bar-mode nil)
 '(vc-follow-symlinks t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Input Mono Narrow" :foundry "FBI " :slant normal :weight normal :height 108 :width semi-condensed))))
 '(flycheck-error ((t (:underline (:color "Red1" :style wave) :slant italic :weight extra-bold))))
 '(flycheck-warning ((t (:underline "DarkOrange" :slant italic :weight semi-bold)))))

(dolist (package package-selected-packages)
  (unless (package-installed-p package)
    (package-install package)))

(global-set-key (kbd "C-x C-b") 'ibuffer)
(autoload 'ibuffer "ibuffer" "List Buffers." t)
(ido-mode t)
(pdf-tools-install)
(menu-bar-mode -1)


;; Haskell Mode
(require 'haskell-mode)
(defun nh-haskell-interactive-mode-config ()
  "Use in haskell-interactive-mode hook."
  (local-set-key (kbd "C-c C-b") 'haskell-interactive-switch-back)
  (local-set-key (kbd "C-c C-z") nil))
(add-hook 'haskell-interactive-mode-hook 'nh-haskell-interactive-mode-config)
(setq haskell-font-lock-symbols t)

(message "fuckin nice one mate!")
(provide 'init)
;;; init.el ends here

;;; erc-settings --- Settings for irc

;;; Commentary:
;; This file contains the basic settings for erc

;;; Code:

(require 'erc)
(setq-default erc-user-full-name "NextHendrix"
	      erc-nick "NextHendrix"
	      erc-server "nexthendr.tk"
	      erc-port "5555")
(setq erc-interpret-controls-p t)
(setq erc-interpret-mirc-color t)

(add-hook 'erc-mode-hook 'erc-fill-disable)
(add-hook 'erc-mode-hook 'visual-line-mode)
     
(provide 'erc-settings)
;;; erc-settings.el ends here

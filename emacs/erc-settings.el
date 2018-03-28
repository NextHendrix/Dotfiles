;;; erc-settings --- Settings for irc

;;; Commentary:
;; This file contains the basic settings for erc

;;; Code:

(require 'erc)
(require 'tls)
(setq-default erc-user-full-name "NextHendrix"
	      erc-nick "NextHendrix"
	      erc-server "finickitively.co.uk"
	      erc-port "5555")
(setq erc-interpret-controls-p t)
(setq erc-interpret-mirc-color t)

(add-hook 'erc-mode-hook 'erc-fill-disable)
(add-hook 'erc-mode-hook 'visual-line-mode)
(defun erc-open-tls-stream (name buffer host port)
      "Open an TLS stream to an IRC server.
    The process will be given the name NAME, its target buffer will be
    BUFFER.  HOST and PORT specify the connection target."
      (open-tls-stream name buffer host port))
(provide 'erc-settings)
;;; erc-settings.el ends here

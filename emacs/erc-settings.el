;;; erc-settings --- Settings for irc

;;; Commentary:
;; This file contains the basic settings for erc

;;; Code:

(require 'erc)
(setq erc-user-full-name "NextHendrix"
      erc-part-reason-various-alist '(("^$" "I just can't handle the banter..."))
      erc-quit-reason-various-alist '(("^$" "tfw server goes down"))
      erc-quit-reason 'erc-quit-reason-various
      erc-part-reason 'erc-part-reason-various)

(provide 'erc-settings)
;;; erc-settings.el ends here

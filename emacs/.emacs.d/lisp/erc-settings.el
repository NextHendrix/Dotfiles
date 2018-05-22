;;; erc-settings.el --- ERC config settings and functions
;;; Commentary:

;;; Code:

;; General Config
(require 'erc)
(require 'erc-hl-nicks)
(setq erc-nick "nh")
(setq erc-server "finickitively.co.uk")
(setq erc-port 5555)
(setq erc-prompt ">")
(setq erc-user-full-name "NextHendrix")
(setq erc-interpret-controls-p t)
(setq erc-interpret-mirc-color t)
(setq erc-kill-buffer-on-part t)
(setq erc-kill-server-buffer-on-quit t)

;; Functions
(defun erc-cmd-EXEC (&rest command)
  "Send output of a shell COMMAND to current channel."
  (let ((s (string-join command " ")))
    (if (string= s "") 'ignore
      (erc-send-message
       (shell-command-to-string s)))))

(defun erc-cmd-UNAME ()
  "Sends output of uname -a to current channel."
  (erc-cmd-EXEC "uname -a"))

(defun erc-cmd-DATE ()
  "Sends output of date to current channel."
  (erc-cmd-EXEC "date"))

(provide 'erc-settings)
;;; erc-settings.el ends here

;;; Get jade mode
(add-to-list 'load-path "~/.emacs.d/modes/jade-mode")
(require 'jade-mode)
(add-to-list 'auto-mode-alist '("\\.jade$" . jade-mode))

;;; Get nxhtml
(load "/home/rohitjain/.emacs.d/nxhtml/nxhtml/autostart")

;;; Paren Matching
(show-paren-mode 1)
(setq show-paren-delay 0)

;;; Buffer Switching Goodies
(iswitchb-mode 1) ;;; Get better support for buffer name matching
;;; (global-set-key (kbd "<C-tab>") 'bury-buffer)

(global-linum-mode 1)
(fset 'yes-or-no-p 'y-or-n-p)
(add-to-list 'load-path "~/.emacs.d/themes/color-theme-6.6.0")
(require 'color-theme)
(color-theme-initialize)
(color-theme-robin-hood)
;;; Color theme settings for ansi-term
(setq term-default-bg-color "#304020")
(setq term-default-fg-color "#BBBBBB")

;;; IDO
(setq ido-everywhere t)
(require 'ido)
(ido-mode t)

;;; regexp config
(require 're-builder)
(setq reb-re-syntax 'string)

;;; JDEE
(add-to-list 'load-path "~/.emacs.d/jdee-2.4.1/lisp")
(load "jde")

;;; Find files by sudo
(defadvice ido-find-file (after find-file-sudo activate)
  "Find file as root if necessary."
  (unless (and buffer-file-name
               (file-writable-p buffer-file-name))
    (find-alternate-file (concat "/sudo:root@localhost:" buffer-file-name))))


;;; Remap the backward kill word
(global-set-key "\C-w" 'backward-kill-word)
(global-set-key "\C-x\C-k" 'kill-region)
(global-set-key "\C-c\C-k" 'kill-region)

;;; Remove the tool bar and the scroll bar
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
;;;(if (fboundp 'menu-bar-mode) (menu-bar-mode -1)) ;;;Keeping this just in case

;;; ORG mode keybindings
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)


;;; Set tab to 2 spaces
(add-hook 'after-change-major-mode-hook 
          '(lambda () 
             (setq-default indent-tabs-mode nil)
             (setq c-basic-indent 2)
             (setq tab-width 2)))

;;; vi like % paren matching
(defun goto-match-paren (arg)
  "Go to the matching parenthesis if on parenthesis, otherwise insert %.
vi style of % jumping to matching brace."
  (interactive "p")
  (cond ((looking-at "\\s\(") (forward-list 1) (backward-char 1))
        ((looking-at "\\s\)") (forward-char 1) (backward-list 1))
        (t (self-insert-command (or arg 1)))))
(global-set-key (kbd "<f6>") 'goto-match-paren)

;;; Terminal Functionality bound to F2. 
(require 'term)
(defun visit-ansi-term ()
  "If the current buffer is:
     1) a running ansi-term named *ansi-term*, rename it.
     2) a stopped ansi-term, kill it and create a new one.
     3) a non ansi-term, go to an already running ansi-term
        or start a new one while killing a defunt one"
  (interactive)
  (let ((is-term (string= "term-mode" major-mode))
        (is-running (term-check-proc (buffer-name)))
        (term-cmd "/bin/bash")
        (anon-term (get-buffer "*ansi-term*")))
    (if is-term
        (if is-running
            (if (string= "*ansi-term*" (buffer-name))
                (call-interactively 'rename-buffer)
              (if anon-term
                  (switch-to-buffer "*ansi-term*")
                (ansi-term term-cmd)))
          (kill-buffer (buffer-name))
          (ansi-term term-cmd))
      (if anon-term
          (if (term-check-proc "*ansi-term*")
              (switch-to-buffer "*ansi-term*")
            (kill-buffer "*ansi-term*")
            (ansi-term term-cmd))
        (ansi-term term-cmd)))))
(global-set-key (kbd "<f2>") 'visit-ansi-term)

;;; This was installed by package-install.el.
;;; This provides support for the package system and
;;; interfacing with ELPA, the package archive.
;;; Move this code earlier if you want to reference
;;; packages in your .emacs.
(when
    (load
     (expand-file-name "~/.emacs.d/elpa/package.el"))
  (package-initialize))

;;; (require 'package)
;;; (add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))


;;; Customize incantations
(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(global-linum-mode t)
 '(js-auto-indent-flag nil)
 '(js-indent-level 2)
 '(org-todo-keywords (quote ((sequence "TODO" "DONE" "SHELVED"))))
 '(ourcomments-ido-ctrl-tab t))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 )

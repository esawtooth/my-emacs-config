;;; Get jade mode
(add-to-list 'load-path "~/.emacs.d/modes/jade-mode")
(require 'jade-mode)
(add-to-list 'auto-mode-alist '("\\.jade$" . jade-mode))

;;; Get nxhtml
(load "/home/rohitjain/.emacs.d/nxhtml/nxhtml/autostart")

;;; Awesome JS mode
(autoload 'js2-mode "js2" nil t)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))

;;; Paren Matching
(show-paren-mode 1)
(setq show-paren-delay 0)

;;;(require 'multiple-cursors)
(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)
(global-set-key (kbd "C-c C->") 'mc/mark-all-like-this-dwim)


;;; Buffer Switching Goodies
(iswitchb-mode 1) ;;; Get better support for buffer name matching
;;; (global-set-key (kbd "<C-tab>") 'bury-buffer)

(global-linum-mode 1)
(fset 'yes-or-no-p 'y-or-n-p)
(add-to-list 'load-path "~/.emacs.d/themes/color-theme-6.6.0")
(add-to-list 'load-path "~/.emacs.d/potpourri")

;;; Multi-Term
(require 'multi-term)
(global-set-key (kbd "<f2>") 'multi-term)
(global-set-key (kbd "<C-next>") 'multi-term-next)
(global-set-key (kbd "<C-prior>") 'multi-term-prev)
(setq multi-term-buffer-name "term"
      multi-term-program "/bin/bash")



(require 'color-theme)
(color-theme-initialize)
(color-theme-goldenrod)
;;; Color theme settings for ansi-term for robin hood
;;;(setq term-default-bg-color "#304020")
;;;(setq term-default-fg-color "#BBBBBB")

;;; term theme for matrix/goldenrod
(setq term-default-bg-color "#000000")
(setq term-default-fg-color "#AAAAAA")

;;; Setting column-number-mode by default
(setq column-number-mode t)

;;;Set font size to 8pt
(set-face-attribute 'default nil :height 100)

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

(load "~/.emacs.d/ess-13.05/lisp/ess-site")

;;; ORG mode keybindings
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)

;;; Comment hotkey (really useful for stupid javascript mode)
(defun toggle-comment-on-line ()
  "comment or uncomment current line"
  (interactive)
  (comment-or-uncomment-region (line-beginning-position) (line-end-position)))
(global-set-key "\M-c" 'toggle-comment-on-line)

;;; Set tab to 2 spaces
(add-hook 'after-change-major-mode-hook 
          '(lambda () 
             (setq-default indent-tabs-mode nil)
             (setq c-basic-indent 2)
             (setq tab-width 2)))

;;; Get Support for 80 column highlighting
(require 'column-marker)

(setq mumamo-no-chunk-coloring nil)

;;; vi like % paren matching
(defun goto-match-paren (arg)
  "Go to the matching parenthesis if on parenthesis, otherwise insert %.
vi style of % jumping to matching brace."
  (interactive "p")
  (cond ((looking-at "\\s\(") (forward-list 1) (backward-char 1))
        ((looking-at "\\s\)") (forward-char 1) (backward-list 1))
        (t (self-insert-command (or arg 1)))))
(global-set-key (kbd "<f6>") 'goto-match-paren)

;;; This was installed by package-install.el.
;;; This provides support for the package system and
;;; interfacing with ELPA, the package archive.
;;; Move this code earlier if you want to reference
;;; packages in your .emacs.
;;;(when
;;;    (load
;;;     (expand-file-name "~/.emacs.d/elpa/package.el"))
;;;  (package-initialize))

(require 'package)
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))

;;; Customize incantations
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(global-linum-mode t)
 '(js-auto-indent-flag nil)
 '(js-indent-level 2)
 '(js2-basic-offset 2)
 '(org-todo-keywords (quote ((sequence "TODO" "DONE" "SHELVED"))))
 '(ourcomments-ido-ctrl-tab t)
 '(show-paren-mode t)
 '(tool-bar-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "DejaVu Sans Mono" :foundry "unknown" :slant normal :weight normal :height 98 :width normal)))))

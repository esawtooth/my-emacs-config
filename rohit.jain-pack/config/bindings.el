;; Place your bindings here.

;; Basic Bindings:
(define-key global-map (kbd "C-+") 'text-scale-increase)
(define-key global-map (kbd "C--") 'text-scale-decrease)
(define-key global-map (kbd "C-w") 'backward-kill-word)
(define-key global-map (kbd "C-!") 'eshell-here)
(define-key global-map (kbd "C-M-\\") 'indent-buffer)

;; Editor Preferences Override
(define-key global-map (kbd "C-x p") 'go-match-paren)
(define-key global-map (kbd "C-n") 'next-logical-line)
(define-key global-map (kbd "C-p") 'previous-logical-line)

;; Multiple Cursor mode
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)

;; Find File at cursor
(global-set-key (kbd "C-x O") 'xah-open-file-at-cursor)

;;; This was installed by package-install.el.
;;; This provides support for the package system and
;;; interfacing with ELPA, the package archive.
;;; Move this code earlier if you want to reference
;;; packages in your .emacs.

(add-to-list 'load-path "~/.emacs.d")

;; smooth scroll
(setq scroll-conservatively 10000)

;; delete selections using backspace and delete key
(delete-selection-mode t)

;; Show matching paren
(show-paren-mode t)

;; no backup files
(setq make-backup-files nil)

;; no splash screen
(setq inhibit-splash-screen t)
(setq initial-scratch-message nil)

;; no menu bar
(menu-bar-mode 0)

;; encoding
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(prefer-coding-system 'utf-8)

;; auto-indentation for most of modes
(define-key global-map (kbd "RET") 'newline-and-indent)
;; no tab-indenting
(setq-default indent-tabs-mode nil)
;; 4-spaces
;;(setq c-basic-offset 4)

;; http://www.emacswiki.org/emacs/InteractivelyDoThings
(require 'ido)
(ido-mode t)
(setq ido-enable-flex-matching t)

;; http://www.emacswiki.org/emacs/uniquify
(require 'uniquify)
(setq uniquify-buffer-name-style 'forward)

;; line-numbers
(add-hook 'find-file-hook (lambda () (linum-mode 1)))

(setq linum-format (lambda (line)
   (propertize (format (let ((w (length (number-to-string (count-lines (point-min) (point-max))))))
			    (concat "%" (number-to-string w) "d ")) line) 'face 'linum)))

;; goto-line shortcut
(define-key global-map (kbd "M-g") 'goto-line)
 
;; Copy & Paste + Mac Clipboard
;; http://blog.lathi.net/articles/2007/11/07/sharing-the-mac-clipboard-with-emacs
(defun copy-from-osx ()
    (shell-command-to-string "pbpaste"))

(defun paste-to-osx (text &optional push)
    (let ((process-connection-type nil))
         (let ((proc (start-process "pbcopy" "*Messages*" "pbcopy")))
              (process-send-string proc text)
              (process-send-eof proc))))

(setq interprogram-cut-function 'paste-to-osx)
(setq interprogram-paste-function 'copy-from-osx)


;; WHITESPACES
(setq whitespace-style '(trailing indentation::space))

(add-hook 'js-mode-hook 'whitespace-mode)
(add-hook 'sh-mode-hook 'whitespace-mode)
(add-hook 'css-mode-hook 'whitespace-mode)
(add-hook 'html-mode-hook 'whitespace-mode)
(add-hook 'python-mode-hook 'whitespace-mode)

;; NORMALIZE WHITESPACES
;; untabify some modes
;(setq elus/whitespace-fix-modes
;      '(html-mode sh-mode python-mode css-mode less-css-mode javascript-mode))

(defun elus/fix-whitespaces-hook ()
  (when (member major-mode '(html-mode
                             sh-mode
                             python-mode
                             css-mode
                             less-css-mode
                             js-mode))
    (untabify (point-min) (point-max))
    (set-buffer-file-coding-system 'undecided-unix)
    (delete-trailing-whitespace)))

(add-hook 'before-save-hook 'elus/fix-whitespaces-hook)

(require 'package)
(package-initialize)
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
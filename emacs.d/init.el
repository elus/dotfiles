;; set load-path
(add-to-list 'load-path "~/.emacs.d")
(let ((default-directory "~/.emacs.d/"))
  (normal-top-level-add-subdirs-to-load-path))
(add-to-list 'load-path "~/.emacs.d/python.el")
(add-to-list 'load-path "~/.emacs.d/qml-mode")
(add-to-list 'load-path "~/.emacs.d/yaml-mode")
(add-to-list 'load-path "~/.emacs.d/puppet")
;;(progn (cd "~/.emacs.d") (normal-top-level-add-subdirs-to-load-path))

;; mouse support
(require 'mouse)
(xterm-mouse-mode t)
(defun track-mouse (e))

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

;; QML mode
(require 'qml-mode)
(add-to-list 'auto-mode-alist '("\\.qml\\'" . qml-mode))

;; YAML mode
(require 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))

;; puppet-mode
(autoload 'puppet-mode "puppet-mode" "Major mode for editing puppet manifests")
(add-to-list 'auto-mode-alist '("\\.pp$" . puppet-mode))

;; Python.el
;; https://github.com/fgallina/python.el
(require 'python)

(require 'erc)
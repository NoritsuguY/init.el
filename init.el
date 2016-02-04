;; Set Load Path
(let ((default-directory (expand-file-name "~/.emacs.d/lisp")))
  (add-to-list 'load-path default-directory)
  (if (fboundp 'nomal-top-level-add-subdirs-to-load-path)
      (normal-top-level-add-sbudirs-to-load-path)))

;; Maximize window when starting
(add-to-list 'default-frame-alist '(fullscreen . maximized))

;; Set color theme
(load-theme 'wheatgrass t)
(enable-theme 'wheatgrass)

;; Set language and coding system
(set-locale-environment nil)
(set-language-environment "Japanese")
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-buffer-file-coding-system 'utf-8)
(setq default-buffer-file-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(prefer-coding-system 'utf-8)

;; Hide startup message
(setq inhibit-startup-screen t)
(setq inhibit-startup-message t)

;; Deny making backup file
(setq make-backup-files nil)

;; Delete auto-save files when exit
(setq delete-auto-save-files t)

;; Use space for tab
(setq-default tab-width 4 indent-tabs-mode nil)

;; Show line break code
(setq eol-mnemonic-dos "(CRLF)")
(setq eol-mnemonic-mac "(CR)")
(setq eol-mnemonic-unix "(LF)")

;; Prohibit plural windows
(setq ns-pop-up-frames nil)

;; Display full path of open file
(setq frame-title-format (format "%%f"))

;; Associate extension and mode
(add-to-list 'auto-mode-alist '("//.ddl$" . sql-mode))

;; Set window clear
(add-to-list 'default-frame-alist '(alpha . (0.85 0.85)))

;; Hide menu bar
(menu-bar-mode -1)

;; Hide tool bar
(tool-bar-mode -1)

;; Show column number
(column-number-mode t)

;; Show line number
(global-linum-mode t)

;; Prohibit cursor blinking
(blink-cursor-mode 0)

;; Highlight line on cursor
(global-hl-line-mode t)

;; Show paren
(show-paren-mode 1)

;; Show contents inside paren if not display all contents
(setq show-paren-style 'mixed)
(set-face-background 'show-paren-match-face "grey")
(set-face-foreground 'show-paren-match-face "black")
;
;; Delete space on line end when saving
(require 'whitespace)
(set-face-foreground 'whitespace-space "DarkGoldenrod1")
(set-face-background 'whitespace-space nil)
(set-face-bold-p 'whitespace-space t)
(setq whitespace-style '(tabs
                         trailing
                         spaces
                         spacemark
                         ))
(setq whitespace-action '(auto-cleanup))
(global-whitespace-mode 1)

;; Scroll one per line
(setq scroll-conservatively 1)

;; Delete line by C-k
(setq kill-whole-line t)

;; Select by "y or n"
(fset 'yes-or-no-p 'y-or-n-p)

;; Show recent open files
(recentf-mode t)

;; Number of display recent open files
(setq recentf-max-menu-items 10)

;; Number of Saving recent open files
(setq recentf-max-saved-items 3000)

;; Turn off beep
(defun my-bell-function()
  (unless (memq this-command
                '(isearch-abort abort-recursive-edit exit-minibuffer
                                keyboard-quit mwheel-scroll down up next-line previous-line
                                backward-char forward-char))
    (ding)))
(setq ring-bell-function 'my-bell-function)

;; Divide window automatically
(defun split-window-vertically-n (num_wins)
  (interactive "p")
  (if (= num_wins 2)
      (split-window-vertically)
    (progn
      (split-window-vertically
       (- (window-height) (/ (window-height) num_wins)))
      (split-window-vertically-n (- num_wins 1)))))
(defun split-window-horizontally-n (num_wins)
  (interactive "p")
  (if (= num_wins 2)
      (split-window-horizontally)
    (progn
      (split-window-horizontally
       (- (window-width) (/ (window-width) num_wins)))
      (split-window-horizontally-n (- num_wins 1)))))

;; Divide and move window by C-t
(defun other-window-or-split ()
  (interactive)
  (when (one-window-p)
    (if (>= (window-body-width) 270)
        (split-window-horizontally-n 3)
      (split-window-horizontally)))
  (other-window 1))
(global-set-key (kbd "C-t") 'other-window-or-split)

;; Setup tree-undo
(require 'undo-tree)
(global-undo-tree-mode 1)

;; Set keybind to undo and redo
(defalias 'redo 'undo-tree-redo)
(global-set-key [?\C-=] 'undo)
(global-set-key [?\C-Z] 'redo)

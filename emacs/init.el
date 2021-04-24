; TODO Add more packages, e.g., org, org-roam?, AUCTeX, RefTex
; TODO Spaceemacs, Doomemacs as references
(menu-bar-mode -1)

;; Make the scroll more vim-like
(setq scroll-step 1)
(setq scroll-margin 5)

; FIXME Why Emacs keeps writing to my config?
(setq custom-file (concat user-emacs-directory "/custom.el"))

(setq package-user-dir (concat (getenv "XDG_CACHE_HOME") "/elpa"))
(setq make-backup-files nil)

(when (version<= "26.0.50" emacs-version )
  (global-display-line-numbers-mode))

; TODO What does auto-save-list do in Emacs
(setq auto-save-list-file-prefix nil)

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(require 'use-package)

(use-package auto-package-update
  :ensure t
  :config
  (setq auto-package-update-delete-old-versions t)
  (setq auto-package-update-hide-results t)
  (auto-package-update-maybe))

; TODO Bring more config from Vim
(use-package evil
  :ensure t
  :init
  (setq evil-search-module 'evil-search)
  (setq evil-undo-system 'undo-redo)
  (setq evil-want-keybinding nil)
  :config
  (define-key evil-normal-state-map (kbd "SPC m") 'neotree-toggle)
  (evil-mode))

(use-package evil-collection
  :after evil
  :ensure t
  :config
  (evil-collection-init))

(use-package neotree
  :ensure t
  :commands neotree-toggle
  :init
  (setq neo-window-width 40))

; TODO Pair highlight is required
(use-package rainbow-delimiters
  :ensure t
  :init
  (add-hook 'prog-mode-hook 'rainbow-delimiters-mode))

(use-package nord-theme
  :ensure t
  :init
  (load-theme 'nord t))

(use-package hl-todo
  :hook (prog-mode . hl-todo-mode)
  :ensure t
  :config
  (setq hl-todo-keyword-faces
    '(("TODO"       warning bold)
      ("FIXME"      error bold)
      ("NOTE"       success bold)
      ("DEPRECATED" font-lock-doc-face bold))))

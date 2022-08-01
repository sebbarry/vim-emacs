;;; emacs configuration file

;; ---- Package management ---- ;;

(require 'package)


;; Repositories
(add-to-list 'package-archives
	     '("org" . "http://orgmode.org/elpa/"))
(add-to-list 'package-archives
	     '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives
	     '("melpa-stable" . "http://stable.melpa.org/packages/"))


;; Disable automatic package loading
(setq package-enable-at-startup nil)


;; Ensure that specified packages are installed
(defun ensure-package-installed (&rest packages)
  (mapcar
   (lambda (package)
     (if (package-installed-p package)
	 nil
       (if (y-or-n-p (format "%s not found. Install? " package))
	   (package-install package)
	 package)))
   packages))


;; Update package information
(or (file-exists-p package-user-dir)
    (package-refresh-contents))


;; Activate installed packages
(package-initialize)

;; ---- /Package management ---- ;;


;; ---- Theme & UI ---- ;;

(ensure-package-installed 'dracula-theme)

;; Themes to use
(setq main-theme 'dracula)

;; Load main theme
(load-theme main-theme t)

;; ---- /Theme & UI ---- ;;


;;---- General & Misc ----;;

;; Disable welcome screen
(setq inhibit-splash-screen t)
(setq inhibit-startup-message t)


;; Disable toolbar
;;(tool-bar-mode -1)


;; Disable menu bar
;;(menu-bar-mode -1)


;; Line numbers
(global-linum-mode 1)

;;; Disable linum mode in doc view mode (Fixes freeze when opening PDF)
(add-hook 'doc-view-mode-hook
  (lambda ()
    (linum-mode -1)))


;; Column numbers
(setq column-number-mode 1)


;; Cleanup whitespace
(add-hook 'before-save-hook 'whitespace-cleanup)


;; Centered cursor
(centered-cursor-mode 1)


;; Evil mode
(ensure-package-installed 'evil
			  'evil-visualstar)
(require 'evil)
(evil-mode t)
(global-evil-visualstar-mode)


;; Key Chord
(ensure-package-installed 'key-chord)
(require 'key-chord)
(setq key-chord-two-keys-delay 0.5)

;;; Map 'jj' to 'ESC'
(key-chord-define evil-insert-state-map "jj" 'evil-normal-state)
(key-chord-mode 1)


;; Ido
(ensure-package-installed 'ido-ubiquitous
			  'ido-vertical-mode
			  'ido-yes-or-no
			  'flx-ido)

(require 'ido)
(require 'ido-vertical-mode)
(require 'ido-ubiquitous)
(require 'flx-ido)
(ido-mode 1)
(ido-everywhere 1)
(ido-vertical-mode 1)
(ido-ubiquitous-mode 1)
(flx-ido-mode 1)
(setq ido-enable-flex-matching t)
(setq ido-use-faces nil)
(setq ido-vertical-define-keys 'C-n-C-p-up-down-left-right)
(setq ido-vertical-show-count t)


;; Smex
(ensure-package-installed 'smex)
(require 'smex)
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)


;; Autopairs with Skeleton
(setq skeleton-pair t)
(global-set-key "(" 'skeleton-pair-insert-maybe)
(global-set-key "[" 'skeleton-pair-insert-maybe)
(global-set-key "{" 'skeleton-pair-insert-maybe)
(global-set-key "<" 'skeleton-pair-insert-maybe)
(global-set-key "\"" 'skeleton-pair-insert-maybe)
(global-set-key "'" 'skeleton-pair-insert-maybe)


;; Highlight matching parenthesis
(show-paren-mode 1)
(setq show-paren-delay 0)


;; Anzu
(ensure-package-installed 'anzu)
(global-anzu-mode +1)


;; Fill column indicator
;;(ensure-package-installed 'fill-column-indicator)
;;(require 'fill-column-indicator)
;;(setq fci-rule-width 1)
;;(setq fci-rule-column 73)
;;(setq fci-rule-color "magenta")


;; Which key
(ensure-package-installed 'which-key)
(require 'which-key)
(setq which-key-popup-type 'side-window)
(setq which-key-side-window-location 'bottom)
(setq which-key-side-window-max-height 0.25)


;; Golden ratio
(ensure-package-installed 'golden-ratio)
(require 'golden-ratio)
(golden-ratio-mode 1)
(setq golden-ratio-auto-scale t)


;;---- /General & Misc ----;;


;; ---- Web development ----;;

;; Web Mode
(ensure-package-installed 'web-mode)
(require 'web-mode)

;;; File formats
(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.[agj]sp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.js\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.css\\'" . web-mode))

;;; Indentation
(setq web-mode-markup-indent-offset 2)
(setq web-mode-css-indent-offset 2)
(setq web-mode-code-indent-offset 2)
(setq web-mode-attr-indent-offset 2)

;;; Padding
(setq web-mode-style-padding 2)
(setq web-mode-script-padding 2)
(setq web-mode-block-padding 2)

;;; Next tag
(define-key web-mode-map (kbd "C-n") 'web-mode-tag-match)

;;; Features
(setq web-mode-enable-auto-pairing 1)
(setq web-mode-enable-css-colorization 1)
(setq web-mode-enable-current-element-highlight 1)


;; Emmet mode
(ensure-package-installed 'emmet-mode)
(require 'emmet-mode)
(add-hook 'sgml-mode-hook 'emmet-mode) ; Auto-start on any markup modes
(add-hook 'css-mode-hook  'emmet-mode) ; enable Emmet's css abbreviation.require 'emmet-mode)


;; Web Beautify
(ensure-package-installed 'web-beautify)
(require 'web-beautify)
(setq web-beautify-args '("--indent-size" "2" "-f" "-"))

;; ---- /Web development ----;;


;; ---- Markdown ---- ;;

(ensure-package-installed 'markdown-mode)
(require 'markdown-mode)
(add-to-list 'auto-mode-alist '("\\.text\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

;; ---- /Markdown ---- ;;


;; ---- Syntax checking ---- ;;

;; Flycheck
(ensure-package-installed 'flycheck
			  'flycheck-css-colorguard)
(add-hook 'after-init-hook #'global-flycheck-mode)

;; ---- /Syntax checking ----;;


;; ---- Git ---- ;;

;; Diff-hl
(ensure-package-installed 'diff-hl)
(require 'diff-hl)
(global-diff-hl-mode 1)

;; ---- /Git ---- ;;

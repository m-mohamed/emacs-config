;; .emacs.d/init.el

;; ===================================
;; MELPA Package Support
;; ===================================
;; Enables basic packaging support
(require 'package)

;; Adds the Melpa archive to the list of available repositories
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/") t)

;; Initializes the package infrastructure
(package-initialize)

;; If there are no archived package contents, refresh them
(when (not package-archive-contents)
  (package-refresh-contents))

;; Installs packages
;;
;; myPackages contains a list of package names
(defvar myPackages
  '(better-defaults                 ;; Set up some better Emacs defaults
    elpy                            ;; Emacs Lisp Python Environment
    ein                             ;; Emacs IPython Notebook
    flycheck                        ;; On the fly syntax checking
    blacken                         ;; Black formatting on save
    magit                           ;; Git integration
    material-theme                  ;; Theme
    )
  )

;; Scans the list in myPackages
;; If the package listed is not already installed, install it
(mapc #'(lambda (package)
          (unless (package-installed-p package)
            (package-install package)))
      myPackages)

;; ===================================
;; Basic Customization
;; ===================================

(setq inhibit-startup-message t)    ;; Hide the startup message
(load-theme 'darcula t)             ;; Load material theme
(global-linum-mode t)               ;; Enable line numbers globally
(setq ring-bell-function 'ignore )  ;; silent bell on mistakes
(setq delete-old-versions -1 )      ;; delete excess backups silently
(ido-mode)                          ;; Enable ido
(ido-everywhere 1)                  ;; Enable ido-mode everywhere

(when (fboundp 'windmove-default-keybindings) ;; Uses Shit+Arrow to move between windows
  (windmove-default-keybindings))

;; ===================================
;; Virtualenv setup for emacs
;; ===================================

(require 'virtualenvwrapper)

;; Eshell-prompts-extras setup
(with-eval-after-load "esh-opt"      
  (autoload 'epe-theme-lambda "eshell-prompt-extras")
  (setq eshell-highlight-prompt nil
        eshell-prompt-function 'epe-theme-lambda))

;; Eshell-prompts-extras virtualenv setup
(with-eval-after-load "esh-opt"
  (require 'virtualenvwrapper)
  (venv-initialize-eshell)
  (autoload 'epe-theme-lambda "eshell-prompt-extras")
  (setq eshell-highlight-prompt nil
        eshell-prompt-function 'epe-theme-lambda))

;; ====================================
;; Org-mode setup
;; ====================================

(require 'org)
(define-key global-map "\C-c l" 'org-store-link)
(define-key global-map "\C-c a" 'org-agenda)
(setq org-log-done t)

;; ====================================
;; Development Setup
;; ====================================

;; Enable elpy
(elpy-enable)

;; Use Python for REPL
(setq python-shell-interpreter "python"
      python-shell-interpreter-args "-i")

;; Enable Flycheck
(when (require 'flycheck nil t)
  (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
  (add-hook 'elpy-mode-hook 'flycheck-mode))

;; User-Defined init.el ends here

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("41c8c11f649ba2832347fe16fe85cf66dafe5213ff4d659182e25378f9cfc183" default)))
 '(package-selected-packages
   (quote
    (virtualenvwrapper eshell-prompt-extras racket-mode material-theme better-defaults))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

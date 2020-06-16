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
(add-hook 'pdf-view-mode-hook (lambda() (linum-mode -1))) ;; disable for pdfs
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
(setq org-log-done t)

(setq org-agenda-files (list "~/org/work.org"
                             "~/org/school.org" 
                             "~/org/home.org"))

;; set up flyspell
(dolist (hook '(text-mode-hook org-mode-hook))
  (add-hook hook (lambda () (flyspell-mode 1))))

;; Get flyspell to pick up 2 finger clicks (mac)
(eval-after-load "flyspell"
  '(progn
     (define-key flyspell-mouse-map [down-mouse-3] #'flyspell-correct-word)
     (define-key flyspell-mouse-map [mouse-3] #'undefined)))

;; org python code blocks
(org-babel-do-load-languages
 'org-babel-load-languages
 '((python . t)))


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

(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.js?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.jsx?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.css?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.scss?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.xml?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.[agj]sp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))

; enable neo-tree and toggle it to f8
(require 'neotree)
(global-set-key [f8] 'neotree-toggle)

;; auto close bracket insertion. New in emacs 24
(electric-pair-mode 1)

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
    (pdf-tools dockerfile-mode markdown-mode neotree web-mode virtualenvwrapper eshell-prompt-extras racket-mode material-theme better-defaults))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

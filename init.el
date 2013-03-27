(setq debug-on-error t)
(setq frame-title-format '("Emacs @ " system-name ": %b %+%+ %f"))
(setq tramp-default-method "ssh")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Maximize screen on load if X11 detected
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun x11-maximize-frame ()
  "Maximize the current frame (to full screen)"
  (interactive)
  (x-send-client-message nil 0 nil "_NET_WM_STATE" 32 '(2 "_NET_WM_STATE_MAXIMIZED_HORZ" 0))
  (x-send-client-message nil 0 nil "_NET_WM_STATE" 32 '(2 "_NET_WM_STATE_MAXIMIZED_VERT" 0)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Setup xterm mouse in console mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(unless window-system
  (require 'mouse)
  (xterm-mouse-mode 1)
  (global-set-key [mouse-4] '(lambda ()
                               (interactive)
                               (scroll-down 1)))
  (global-set-key [mouse-5] '(lambda ()
                               (interactive)
                               (scroll-up 1)))
  (xterm-mouse-mode t)
  (defun track-mouse (e)) 
  (setq mouse-sel-mode t))

(require 'package)
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(package-initialize)

(setq default-tab-width 2)
(setq nxml-child-indent 2)

(global-set-key (kbd "C-c c") 'comment-region) ; comment code block
(global-set-key (kbd "C-c u") 'uncomment-region) ; uncomment code block

(global-set-key (kbd "C-x TAB") 'tab-indent-region) ; indent region
(global-set-key (kbd "C-x <backtab>") 'unindent-region) ; unindent region
(defun tab-indent-region ()
    (interactive)
  (setq fill-prefix "\t")
    (indent-region (region-beginning) (region-end) 4)
)
(defun unindent-region ()
    (interactive)
    (indent-region (region-beginning) (region-end) -1)
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Cua-Mode
;; (Windows like control+x, control+c, control+v)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(cua-mode t)
(setq cua-auto-tabify-rectangles nil) ;; Don't tabify after rectangle commands
(transient-mark-mode 1) ;; No region when it is not highlighted
(setq cua-keep-region-after-copy t) ;; Standard Windows behaviour
(delete-selection-mode 1) ;; Typing in region deletes
(setq x-select-enable-clipboard t) ;; interact with x copy-cut-paste
(setq interprogram-paste-function 'x-cut-buffer-or-selection-value)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Color Theme
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(add-to-list 'load-path "~/.emacs.d/elpa/color-theme-6.6.0")
(require 'color-theme)
(color-theme-initialize)
(add-to-list 'load-path "~/.emacs.d/extra")


(when window-system
  (set-face-font 'default "InConsolata-10")
  (require 'color-theme-tm)
  (color-theme-tm)
  (add-to-list 'default-frame-alist '(background-color . "#111111"))
  (x11-maximize-frame)
)

(unless window-system
  (color-theme-taming-mr-arneson)
)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Code Mode 
;; (Most code modes are included,  check before installing)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(add-to-list 'load-path "~/.emacs.d/elpa/js2-mode-20130307")
(require 'js2-mode)
(add-to-list 'load-path "~/.emacs.d/elpa/apache-mode-2.0")
(require 'apache-mode)
(add-to-list 'load-path "~/.emacs.d/elpa/php-mode-1.5.0")
(require 'php-mode)
(add-to-list 'load-path "~/.emacs.d/extra/jinja2-mode")
(require 'jinja2-mode)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ECB (Emacs Code Browser)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(add-to-list 'load-path "~/.emacs.d/extra/ecb")
(require 'ecb)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Helm
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(add-to-list 'load-path "~/.emacs.d/extra/helm")
(require 'helm-config)
(global-set-key (kbd "C-c h") 'helm-mini)
(helm-mode 1)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Whitespace Highlighting
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'whitespace)
(setq whitespace-display-mappings '((space-mark ?\  [?\u00B7]) (newline-mark ?\n [?$ ?\n]) (tab-mark ?\t [?\u00BB ?\t])))
;(autoload 'whitespace-mode           "whitespace" t)
;(autoload 'whitespace-toggle-options "whitespace" t)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(backup-directory-alist (quote ((".*" . "~/.emacs.d/backups/"))))
 '(ecb-auto-activate t)
 '(ecb-layout-name "left8")
 '(ecb-layout-window-sizes (quote (("left8"
                                    (ecb-directories-buffer-name 0.21022727272727273 . 0.26)
                                    (ecb-sources-buffer-name 0.21022727272727273 . 0.24)
                                    (ecb-methods-buffer-name 0.21022727272727273 . 0.16)
                                    (ecb-history-buffer-name 0.21022727272727273 . 0.32)))))
 '(ecb-options-version "2.40")
 '(ecb-primary-secondary-mouse-buttons (quote mouse-1--C-mouse-1))
 '(ecb-source-path (quote ("/home/matt"
                          ("/home/matt/www/chartpin" "chartpin")
                          ("/ssh:matt@intsims.matriclabs.com:/var/www/" "intsims-www")
                          ("/ssh:matt@intsims.matriclabs.com:/var/django-projects/" "intsims-django"))))
 '(ecb-tip-of-the-day nil)
 '(inhibit-startup-screen t)
 '(safe-local-variable-values (quote ((js-indent-level . 2)))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ecb-default-highlight-face ((((class color) (background dark)) (:background "RoyalBlue"))))
 '(ecb-tree-guide-line-face ((((class color) (background dark)) (:inherit ecb-default-general-face :foreground "gray")))))

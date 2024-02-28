(delete-selection-mode 1)
(electric-pair-mode 1)
(global-auto-revert-mode t)

;; https://www.reddit.com/r/emacs/comments/fwmqc8/how_to_stop_emacs_from_half_scrolling_from_bottom/
(setq scroll-margin 3
      scroll-conservatively 101
      scroll-up-aggressively 0.01
      scroll-down-aggressively 0.01
      scroll-preserve-screen-position t
      auto-window-vscroll nil)

;; https://stackoverflow.com/questions/151945/how-do-i-control-how-emacs-makes-backup-files
(setq backup-directory-alist `(("~/.saves")))
(setq backup-by-copying t)
(setq delete-old-versions t
  kept-new-versions 6
  kept-old-versions 2
  version-control t)

;; https://amitp.blogspot.com/2007/03/emacs-move-autosave-and-backup-files.html
(setq auto-save-directory "~/.saves")

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(amx-mode t)
 '(ispell-dictionary nil)
 '(package-selected-packages
   '(spacegray-theme minimal-theme anti-zenburn-theme ample-theme zenburn-theme magit magit-annex taxy-magit-section ag zeal-at-point typescript-mode ido-completing-read+ timu-line corfu markdown-mode amx multiple-cursors ivy twilight-bright-theme projectile one-themes vertico timu-spacegrey-theme ## cmake-mode)))

(defalias 'yes-or-no-p 'y-or-n-p)

;; force to use horizontal split (https://www.emacswiki.org/emacs/HorizontalSplitting)
 (setq split-width-threshold 9999)

(add-to-list 'default-frame-alist '(font . "Iosevka-16" ))
(set-face-attribute 'default t :font "Iosevka-16")

;; make comments italic
;;(use-package font-lock
;;  :defer t
;;  :custom-face
;;  (font-lock-comment-face ((t (:inherit font-lock-comment-face :italic t))))
;;  (font-lock-doc-face ((t (:inherit font-lock-doc-face :italic t))))
;;  (font-lock-string-face ((t (:inherit font-lock-string-face :italic t)))))

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
;; Comment/uncomment this line to enable MELPA Stable if desired.  See `package-archive-priorities`
;; and `package-pinned-packages`. Most users will not need or want to do this.
;;(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(package-initialize)

;					(load-theme 'one-dark t)
;					(load-theme 'twilight-bright t)
(customize-set-variable 'timu-spacegrey-flavour "light")
(load-theme 'timu-spacegrey t)
					; (load-theme 'ample-light t t)
;; (load-theme 'ample t t)
					; (load-theme 'ample-flat t t)
;; (load-theme 'ample t t)
;; (load-theme 'ample-flat t t)
;; (load-theme 'ample-light t t)
;; (enable-theme 'ample)
;;  (load-theme 'zenburn t)
;; (load-theme 'minimal t)
;; (load-theme 'spacegray t)


;;(require 'projectile)
;;(define-key projectile-mode-map (kbd "C-x p") 'projectile-command-map)
(projectile-mode +1)
(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
;; we need this wrapper to match Projectile's API


(menu-bar-mode -1)
(tool-bar-mode -1)


(load "~/.emacs.d/clang-format.el")
(global-set-key (kbd "M-I") 'clang-format-buffer)

(setq-default line-spacing 8)

(require 'use-package)
(require 'vertico)
(use-package vertico
  :ensure t
  :init
  (vertico-mode))


;; https://stackoverflow.com/questions/3509919/emacs-c-opening-corresponding-header-file
(add-hook 'c-mode-common-hook
  (lambda() 
    (local-set-key  (kbd "C-c o") 'ff-find-other-file)))


;(add-hook 'c++-mode-hook
;	  (lambda ()
;	    (add-hook 'after-save-hook 'clang-format-buffer nil 'make-it-local)))

(global-display-line-numbers-mode) 
(setq display-line-numbers-type 'relative)


(setq inhibit-startup-screen t)

;; For IDO
;; (setq ido-enable-flex-matching t)
;; (setq ido-everywhere t)
;; (setq ido-show-dot-for-dired t)
;; (ido-mode 1)

(ivy-mode)
(setq ivy-use-virtual-buffers t)
(setq enable-recursive-minibuffers t)
(setq ivy-re-builders-alist
      '((read-file-name-internal . ivy--regex-fuzzy)
        (t . ivy--regex-plus)))


(require 'multiple-cursors)
(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(font-lock-keyword-face ((t (:slant italic))))
 '(font-lock-type-face ((t (:slant italic)))))

;; Use fuzzy matching
(setq completion-styles '(flex basic partial-completion emacs22))

(setq projectile-generic-command "fdfind . -0 --type f --color=never --strip-cwd-prefix --ignore-file .projectile")


(use-package corfu
  ;; Optional customizations
:custom
  ;; (corfu-cycle t)                ;; Enable cycling for `corfu-next/previous'
(corfu-auto t)                 ;; Enable auto completion
  ;; (corfu-separator ?\s)          ;; Orderless field separator
  ;; (corfu-quit-at-boundary nil)   ;; Never quit at completion boundary
  ;; (corfu-quit-no-match nil)      ;; Never quit, even if there is no match
  ;; (corfu-preview-current nil)    ;; Disable current candidate preview
  ;; (corfu-preselect 'prompt)      ;; Preselect the prompt
  ;; (corfu-on-exact-match nil)     ;; Configure handling of exact matches
  ;; (corfu-scroll-margin 5)        ;; Use scroll margin

  ;; Enable Corfu only for certain modes.
  ;; :hook ((prog-mode . corfu-mode)
  ;;        (shell-mode . corfu-mode)
  ;;        (eshell-mode . corfu-mode))

  ;; Recommended: Enable Corfu globally.
  ;; This is recommended since Dabbrev can be used globally (M-/).
  ;; See also `global-corfu-modes'.
  :init
  (global-corfu-mode))

(defun my-c++-mode-hook ()
  (setq c-basic-offset 4))
(add-hook 'c++-mode-hook 'my-c++-mode-hook)



(defun hilite-todos ()
  (highlight-lines-matching-regexp "\\<\\(FIXME\\|WRITEME\\|WRITEME!\\|TODO\\|BUG\\):?" 
       'hi-green-b)
)

(add-hook 'c++-mode-hook 'hilite-todos)




(require 'ansi-color)
(defun endless/colorize-compilation ()
  "Colorize from `compilation-filter-start' to `point'."
  (let ((inhibit-read-only t))
    (ansi-color-apply-on-region
     compilation-filter-start (point))))

(add-hook 'compilation-filter-hook
          #'endless/colorize-compilation)

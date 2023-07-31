;;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!

;;GIT-GUTTER+ begins
;;git-gutter+ in every buffer....is it like jetbrains???...turn off vc-gutter???
;;(global-git-gutter+-mode) <---this blew up doom so turn off
  (global-set-key (kbd "C-x g") 'git-gutter+-mode) ; Turn on/off in the current buffer
  (global-set-key (kbd "C-x G") 'global-git-gutter+-mode) ; Turn on/off globally

  (eval-after-load 'git-gutter+
    '(progn
       ;;; Jump between hunks
       (define-key git-gutter+-mode-map (kbd "C-x n") 'git-gutter+-next-hunk)
       (define-key git-gutter+-mode-map (kbd "C-x p") 'git-gutter+-previous-hunk)

       ;;; Act on hunks
       (define-key git-gutter+-mode-map (kbd "C-x v =") 'git-gutter+-show-hunk)
       (define-key git-gutter+-mode-map (kbd "C-x r") 'git-gutter+-revert-hunks)
       ;; Stage hunk at point.
       ;; If region is active, stage all hunk lines within the region.
       (define-key git-gutter+-mode-map (kbd "C-x t") 'git-gutter+-stage-hunks)
       (define-key git-gutter+-mode-map (kbd "C-x c") 'git-gutter+-commit)
       (define-key git-gutter+-mode-map (kbd "C-x C") 'git-gutter+-stage-and-commit)
       (define-key git-gutter+-mode-map (kbd "C-x C-y") 'git-gutter+-stage-and-commit-whole-buffer)
       (define-key git-gutter+-mode-map (kbd "C-x U") 'git-gutter+-unstage-whole-buffer)))

;; smooth out the bitmap look
(use-package git-gutter-fringe
  :config
  (define-fringe-bitmap 'git-gutter-fr:added [224] nil nil '(center repeated))
  (define-fringe-bitmap 'git-gutter-fr:modified [224] nil nil '(center repeated))
  (define-fringe-bitmap 'git-gutter-fr:deleted [128 192 224 240] nil nil 'bottom))

;; livereload with skewer-mode
(add-hook 'js2-mode-hook 'skewer-mode)
(add-hook 'css-mode-hook 'skewer-css-mode)
(add-hook 'html-mode-hook 'skewer-html-mode)

;;auto save when emacs focus lost
(defun save-all ()
  (interactive)
  (save-some-buffers t))

(add-hook 'focus-out-hook 'save-all)

;;automatically restore the state of your Emacs session, including files you had in window splits
(desktop-save-mode 1)
;; save location
(setq desktop-dirname "~/.emacs.d/")
(setq desktop-base-file-name "emacs-desktop")

;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "John Doe"
      user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
(setq doom-font (font-spec :family "monospace" :size 17 :weight 'semi-light)
       doom-variable-pitch-font (font-spec :family "sans" :size 17))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
;; DAYTIME OPTIONS
(setq doom-theme 'doom-challenger-deep)
;;(setq doom-theme 'doom-solarized-light)

;; NIGHT OPTIONS:
;;(setq doom-theme 'doom-dark+)
;;(setq doom-theme 'doom-moonlight)
;;(setq doom-theme 'doom-dracula)
;;(setq doom-theme 'doom-nord)
;;(setq doom-theme 'doom-palenight)
;;(setq doom-theme 'doom-one)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; Set to default browser
(setq browse-url-browser-function 'browse-url-default-browser)

;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the ` load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

;;USE-PACKAGE setup
(require 'package)
(add-to-list 'package-archives '("gnu"   . "https://elpa.gnu.org/packages/"))
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))

;;NOTE CHATGPT answer for EMMET problem Associate .jsx files with web-mode
;;(add-to-list 'auto-mode-alist '("\\.jsx\\'" . web-mode))
;;(setq web-mode-content-types-alist '(("jsx" . "\\.js[x]?\\'")))


(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(eval-and-compile
  (setq use-package-always-ensure t
        use-package-expand-minimally t))

;;PRETTIER-JS
;;NOTE:prettier is set for MANUAL via your "customize-group" settings
;;NOTE:https://github.com/jscheid/prettier.el
;;NOTE:see vue below
(add-hook 'after-init-hook #'global-prettier-mode);;prettier is enabled
;; M-x prettier-prettify current - buffer manually
;; M-x prettier-prettify-region - selected code region
;; M-x customize-group prettier - opens configuration setings thingie
;;
;;EMMET
;;NOTE https://gist.github.com/thefonso/814a2fc041b1ae30c7618a989cf79abf
;;NOTE auto enable for .js/.jsx files
(add-to-list 'auto-mode-alist '("\\.jsx\\'" . web-mode)) ;; auto-enable for .js/.jsx files
;;NOTE enable JSX syntax higlighting...
(setq web-mode-content-types-alist '(("jsx" . "\\.js[x]?\\'")))
;;get emmet in React JSX files
;;(add-to-list 'emmet-jsx-major-modes 'rjsx-mode)
;;next line auto installes emmet
(use-package emmet-mode
  :config ;; turn emmet on automatically??
  (add-hook 'sgml-mode-hook 'emmet-mode) ;; Auto-start on any markup modes
  (add-hook 'web-mode-hook 'emmet-mode) ;; Auto-start on any markup modes
  (add-hook 'css-mode-hook  'emmet-mode) ;; Auto start on css file.
)
;;NOTE CHATGPT- force rjsx to web-mode
(after! rjsx-mode
  (setq auto-mode-alist (rassq-delete-all 'rjsx-mode auto-mode-alist)))

;;CODE COMPLETION - put emmet on top NOTE see similar line in TABNINE section
(after! company
  (setq company-backends '((company-emmet))))

;;EMMET end


;;TABNINE
;;(use-package company-tabnine :ensure t)
;;TABNINE AI auto completion
;;(require 'company)
;;get company-mode in all buffers
;;(add-hook 'after-init-hook 'global-company-mode)
;;then the tabnine plugin
;;(require 'company-tabnine)
;;(add-to-list 'company-backends 'company-tabnine)

;;(after! company
;;  (setq +lsp-company-backends '(company-tabnine :separate company-capf company-yasnippet))
;;  (setq company-show-numbers t)
;;  (setq company-idle-delay 0)
;;)

;; Trigger completion immediately.
;;(setq company-idle-delay 0)

;; Number the candidates (use M-1, M-2 etc to select completions).
;;(setq company-show-quick-access t)
;;TABNINE ENDS


;; grab the .env file reader
(use-package dotenv-mode)



;; web-mode supports vue since 2019
(add-to-list 'auto-mode-alist '("\\.vue\\'". web-mode))
;; get .env file to render correctly
(add-to-list 'auto-mode-alist '("\\.env'". dotenv-mode))
;;NOTE WHAT IS THIS FOR / FROM?
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)
;; do I need yassnippetts after lsp-mode here?
(setq package-selected-packages '(lsp-mode lsp-treemacs helm-lsp projectile hydra flycheck company avy which-key helm-xref dap-mode zenburn-theme json-mode))
(when (cl-find-if-not #'package-installed-p package-selected-packages)
  (package-refresh-contents)
  (mapc #'package-install package-selected-packages))

;; NOTE for html intellisense use: M-x lsp-install-server RET html-ls RET

(use-package lsp-mode
  :custom
  (lsp-vetur-format-default-formatter-css "none");;needed for vue
  (lsp-vetur-format-default-formatter-html "none");;ditto
  (lsp-vetur-format-default-formatter-js "none");;ditto
  (lsp-vetur-validation-template nil));;ditto - https://azzamsa.com/n/vue-emacs/

(use-package vue-mode
  :mode "\\.vue\\'"
  :hook (vue-mode . prettier-js-mode)
  :config
  (add-hook 'vue-mode-hook #'lsp)
  (setq prettier-js-args '("--parser vue")))
;;vue
(use-package! lsp-volar)

(use-package counsel-etags
  :bind (("C-]" . counsel-etags-find-tag-at-point))
  :init
  (add-hook 'prog-mode-hook
        (lambda ()
          (add-hook 'after-save-hook
            'counsel-etags-virtual-update-tags 'append 'local)))
  :config
  (setq counsel-etags-update-interval 60)
  (push "build" counsel-etags-ignore-directories))

(helm-mode)
(require 'helm-xref)
(define-key global-map [remap find-file] #'helm-find-files)
(define-key global-map [remap execute-extended-command] #'helm-M-x)
(define-key global-map [remap switch-to-buffer] #'helm-mini)
(which-key-mode)
(defun dotfiles--lsp-deferred-if-supported ()
  ;;"Run `lsp-deferred' if it's a supported mode."
  (unless (derived-mode-p 'emacs-lisp-mode)
    (lsp-deferred)))

(add-hook 'prog-mode-hook #'dotfiles--lsp-deferred-if-supported)
;;;; this line give that gnarly lsp-mode warning

;;WARNING: I suspect this next block breaks SPC+/ project search thingie
(setq gc-cons-threshold (* 100 1024 1024)
      read-process-output-max (* 1024 1024)
      company-idle-delay 0.0
      company-minimum-prefix-length 1
      create-lockfiles nil) ;; lock files will kill `npm start'
;;
;;(with-eval-after-load 'lsp-mode ;;what does this block do?
;;  (require 'dap-chrome)
;;  (add-hook 'lsp-mode-hook #'lsp-enable-which-key-integration)

;;find-definition like intellij for js files
(with-eval-after-load 'js
  (define-key js-mode-map (kbd "M-.") nil))
;;
;;SEE LINE 68 - you may not need this
;;(require 'react-snippets')

;;GOLDEN RATIO - this makes the window wide on focus like I have on vim
;;NOTE how to speedup switching???
(use-package golden-ratio
  :config
  (golden-ratio-mode 1))


;;MARKDOWN - live preview
;;https://github.com/jrblevin/markdown-mode
;;NOTE run this command from keybord...
;;
;;C-c C-c l
;;
;;...this keyboard sequence will display the preview inside emacs
;;;; Set the split window direction for Markdown-mode
(setq markdown-split-window-direction 'right)



;;INDIUM
;;trying to get breakpoint functionality set up
(use-package indium :hook ((js2-mode . indium-interaction-mode)))
;;need this so node is in emacs for indium debug engine
(use-package exec-path-from-shell
	:config
	(exec-path-from-shell-initialize))
;;read chrome from cli after flapak alias has been created
;; alias chrome="flatpak run org.chromium.Chromium"
(setq indium-chrome-executable "chromium")

;;MULTIEDIT evil-multiedit set up
;;(evil-multiedit-default-keybinds)
;;NOTE "windows" left Alt key is Meta key
;;USE - V-mode select word(s) then M-d each time

;;hlissner has evil-multiedit as part of doom....we do not need this next line
(use-package evil-mc
	:config
	(global-evil-mc-mode 1));;enable

;;(evil-mc-make-all-cursors) ;; C-n
;; Create cursors for all strings that match the selected
;; region or the symbol under cursor.

;;(evil-mc-undo-all-cursors);; C-p
;; Remove all cursors.
;;CYCLE---> M-n / M-p

;;EXPERIMENTAL: increase border width so breakpoints can be seen better
;;(setq-default display-line-numbers-width 10)
;;(setq scroll-bar-width 10)
;; add to config.el
;; split window border???
;;(setq window-divider-default-bottom-width 4  ; default is 1
;;window-divider-default-right-width 4)  ; default is 1

;;TREEMACS icons
(setq doom-themes-treemacs-theme "doom-colors") ; or another theme name
(setq doom-themes-treemacs-enable-variable-pitch nil) ; optional, if you prefer fixed-pitch
(doom-themes-treemacs-config)


;;FRINGES set fringes to 10 left 5 right so breakpoints are seen
;;(fringe-mode '(10 . 5))
;;Set fringes to default
(fringe-mode nil)


;;run html page from emacs just type M-x livepreview
(defun livepreview ()
  "Run `httpd-start' and `impatient-mode' in sequence. Open localhost:8080/imp/"
  (interactive)
  (httpd-start)
  (impatient-mode)
  (browse-url-xdg-open "http://localhost:8080/imp/"))

(global-set-key (kbd "C-c a b c") 'livepreview)

;;save current buffer when spc-o-t for terminal is used
;;???
;;
;; Maximize screen on startup
(add-to-list 'initial-frame-alist '(fullscreen . maximized))
;;(add-hook 'window-setup-hook #'toggle-frame-maximized)
;;(add-hook 'window-setup-hook #'toggle-frame-fullscreen)

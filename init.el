(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name
        "straight/repos/straight.el/bootstrap.el"
        (or (bound-and-true-p straight-base-dir)
            user-emacs-directory)))
      (bootstrap-version 7))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))


(straight-use-package 'use-package)
(use-package straight
  :custom
  (straight-use-package-by-default t))

(setq major-mode-remap-alist
      '((python-mode . python-ts-mode)
        (c-mode      . c-ts-mode)
        (c++-mode    . c++-ts-mode)))

(setq treesit-font-lock-level 4)

(use-package eglot
  :straight t
  :hook
  ((c-ts-mode . eglot-ensure)
   (c++-ts-mode . eglot-ensure)))


;; this works fine!
;; (use-package eglot
;;   :straight t
;;   :hook
;;   ((c-mode . eglot-ensure)
;;    (c++-mode . eglot-ensure)
;;    (c-ts-mode . eglot-ensure)
;;    (c++-ts-mode . eglot-ensure)))


;; ------------------------------
;; Completion Stack (Minimal)
;; ------------------------------

;; Vertico: vertical completion UI
(use-package vertico
  :straight t
  :init
  (vertico-mode))

;; Orderless: flexible matching
(use-package orderless
  :straight t
  :custom
  (completion-styles '(orderless basic))
  (completion-category-defaults nil)
  (completion-category-overrides '((file (styles basic partial-completion)))))

;; Marginalia: annotations in minibuffer
(use-package marginalia
  :straight t
  :init
  (marginalia-mode))

;; Consult: enhanced commands
(use-package consult
  :straight t)

;; Embark: context actions
(use-package embark
  :straight t
  :bind
  (("C-." . embark-act)
   ("C-;" . embark-dwim)
   ("C-h B" . embark-bindings)))

;; Embark-Consult: live previews
(use-package embark-consult
  :straight t
  :after (embark consult))


(use-package corfu
  :straight t
  :init
  (global-corfu-mode))

;; ------------------------------
;; Snippet
;; ------------------------------
(use-package yasnippet
  :straight t
  :hook
  ((c-ts-mode . yas-minor-mode)
   (c++-ts-mode . yas-minor-mode)
   (c-mode . yas-minor-mode)
   (c++-mode . yas-minor-mode))
  :init
  (yas-global-mode 1))

(use-package yasnippet-snippets
  :straight t)

;; ------------------------------
;; Eglot completions first, snippets appear as fallback
;; ------------------------------

(add-hook 'eglot-managed-mode-hook
          (lambda ()
            (add-to-list 'completion-at-point-functions
                         'yasnippet-capf)))

;; (use-package yasnippet
;;   :straight t
;;   :init
;;   (yas-global-mode 1))

;; (use-package yasnippet-snippets
;;   :straight t)

(use-package magit
  :straight t
  :commands (magit-status))


;; disable cmake-ts-mode use built-in cmake-mode 
(use-package cmake-mode
  :straight t
  :mode (("CMakeLists\\.txt\\'" . cmake-mode)
         ("\\.cmake\\'" . cmake-mode)))

(setq major-mode-remap-alist
      (assq-delete-all 'cmake-mode major-mode-remap-alist))

;; ------------------------------
;; NOT USED
;; ------------------------------

;; (use-package eglot
;;   :straight t
;;   :hook
;;   ((python-ts-mode . eglot-ensure)
;;    (c++-ts-mode    . eglot-ensure)
;;    (c-ts-mode      . eglot-ensure))
;;   :config
;;   (setq eglot-autoshutdown t
;;         eglot-events-buffer-size 0))

;; (setq treesit-language-source-alist
;;       '((cpp "https://github.com/tree-sitter/tree-sitter-cpp")
;;         (c "https://github.com/tree-sitter/tree-sitter-c")))



;; (treesit-install-language-grammar 'cpp)
;; (treesit-install-language-grammar 'c)

;; (add-hook 'cpp-mode-hook (lambda () (c++-ts-mode) (electric-pair-mode)))
;; (add-to-list 'major-mode-remap-alist '(c-mode . c-ts-mode))
;; (add-to-list 'major-mode-remap-alist '(c++-mode . c++-ts-mode))
;; (add-to-list 'major-mode-remap-alist
;;              '(c-or-c++-mode . c-or-c++-ts-mode))

;; (require 'tree-sitter)
;; (require 'tree-sitter-langs)

;; (global-tree-sitter-mode)

(add-to-list 'load-path "~/.emacs.d/")

(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(aquamacs-additional-fontsets nil t)
 '(aquamacs-autoface-mode nil)
 '(aquamacs-customization-version-id 210 t)
 '(aquamacs-tool-bar-user-customization nil t)
 '(auto-compression-mode t nil (jka-compr))
 '(case-fold-search t)
 '(css-indent-offset 2)
 '(current-language-environment "English")
 '(custom-buffer-indent 2)
 '(default-frame-alist (quote ((cursor-type . box) (internal-border-width . 0) (modeline . t) (fringe) (mouse-color . "black") (background-mode . dark) (tool-bar-lines . 0) (menu-bar-lines . 1) (right-fringe . 0) (left-fringe . 14) (cursor-color . "Red") (background-color . "black") (foreground-color . "white") (font . "-apple-Monaco-medium-normal-normal-*-12-*-*-*-m-0-iso10646-1") (fontsize . 0) (font-backend ns))))
 '(fringe-mode (quote (nil . 0)) nil (fringe))
 '(global-font-lock-mode t nil (font-lock))
 '(global-hl-line-mode t)
 '(global-linum-mode t)
 '(indicate-buffer-boundaries (quote left))
 '(indicate-empty-lines t)
 '(js-enabled-frameworks (quote (javascript mochikit prototype dojo extjs merrillpress)))
 '(js-indent-level 2)
 '(kill-whole-line t)
 '(ns-tool-bar-display-mode (quote both) t)
 '(ns-tool-bar-size-mode (quote regular) t)
 '(paren-match-face (quote paren-face-match-light))
 '(paren-sexp-mode t)
 '(save-place t nil (saveplace))
 '(scroll-bar-mode nil)
 '(size-indication-mode t)
 '(standard-indent 2)
 '(text-mode-hook (quote (text-mode-hook-identify)))
 '(transient-mark-mode t)
 '(uniquify-buffer-name-style (quote forward) nil (uniquify))
 '(visual-line-mode nil t))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(default ((t (:foreground "white" :background "black" :size "13" :family "Monaco"))))
 '(cperl-array-face ((t (:foreground "orangered" :bold t))))
 '(cperl-hash-face ((t (:foreground "Red" :bold t))))
 '(cperl-nonoverridable-face ((t (:foreground "orange" :bold t))))
 '(custom-button ((t (:bold t :foreground "#3fdfcf"))))
 '(custom-group-tag ((t (:underline t :foreground "blue"))))
 '(custom-saved ((t (:underline t :foreground "orange"))))
 '(custom-state ((t (:foreground "green3"))))
 '(custom-variable-button ((t (:bold t :underline t :foreground "white"))))
 '(dired-face-permissions ((t (:foreground "green"))))
 '(echo-area ((t (:stipple nil :strike-through nil :underline nil :slant normal :weight normal :height 130 :width normal :family "Monaco"))))
 '(font-latex-bold-face ((((class color) (background light)) (:bold t))))
 '(font-latex-italic-face ((((class color) (background light)) (:italic t))))
 '(font-latex-math-face ((((class color) (background light)) (:foreground "green3"))))
 '(font-latex-sedate-face ((((class color) (background light)) (:foreground "gold"))))
 '(font-lock-comment-face ((t (:foreground "orange3"))))
 '(font-lock-doc-string-face ((t (:foreground "Wheat3"))))
 '(font-lock-function-name-face ((t (:foreground "lightblue" :bold t))))
 '(font-lock-keyword-face ((t (:foreground "gold"))))
 '(font-lock-preprocessor-face ((t (:foreground "red" :bold t))))
 '(font-lock-reference-face ((t (:foreground "orangered"))))
 '(font-lock-string-face ((t (:foreground "green3"))))
 '(font-lock-type-face ((t (:foreground "#886fff" :bold t))))
 '(font-lock-variable-name-face ((t (:foreground "yellow" :bold t))))
 '(font-lock-warning-face ((t (:foreground "Violetred" :bold t))))
 '(highlight ((t (:background "#333333"))))
 '(isearch ((t (:foreground "red" :background "white"))))
 '(list-mode-item-selected ((t (:foreground "green"))) t)
 '(message-cited-text ((t (:bold t :italic nil))))
 '(scss-mode-default ((t (:inherit css-mode-default :background "#000000"))) t)
 '(secondary-selection ((t (:foreground "white" :background "red"))))
 '(text-cursor ((t (:foreground "black" :background "green"))) t)
 '(zmacs-region ((t (:background "RoyalBlue"))) t))

;; for compatibility with older Aquamacs versions
 (defvar aquamacs-140-custom-file-upgraded t)
 (unless (fboundp 'auto-detect-longlines) (defun auto-detect-longlines () t))

;; Global settings
(setq-default indent-tabs-mode nil)

(iswitchb-mode 1)
(setq iswitchb-buffer-ignore '("^\\*Messages"))

;; Editor modes
(require 'php-mode)

(require 'sass-mode)
(require 'scss-mode)
(add-to-list 'auto-mode-alist '("\\.less$" . scss-mode))

(require 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))

(require 'asp-mode)
(add-to-list 'auto-mode-alist '("\\.asp$" . asp-mode))

(require 'textile-mode)
(add-to-list 'auto-mode-alist '("\\.textile\\'" . textile-mode))

(require 'markdown-mode)
(add-to-list 'auto-mode-alist '("\\.txt\\'" . markdown-mode))

(require 'protobuf-mode)

(require 'scala-mode-auto)

(require 'sws-mode)
(add-to-list 'auto-mode-alist '("\\.styl$" . sws-mode))

(require 'jade-mode)
(add-to-list 'auto-mode-alist '("\\.jade$" . jade-mode))

(require 'magit)
(autoload 'magit-status "magit" nil t)

(defun duplicate-line (arg)
  "Duplicate current line, leaving point in lower line."
  (interactive "*p")

  ;; save the point for undo
  (setq buffer-undo-list (cons (point) buffer-undo-list))

  ;; local variables for start and end of line
  (let ((bol (save-excursion (beginning-of-line) (point)))
        eol)
    (save-excursion

      ;; don't use forward-line for this, because you would have
      ;; to check whether you are at the end of the buffer
      (end-of-line)
      (setq eol (point))

      ;; store the line and disable the recording of undo information
      (let ((line (buffer-substring bol eol))
            (buffer-undo-list t)
            (count arg))
        ;; insert the line arg times
        (while (> count 0)
          (newline)         ;; because there is no newline in 'line'
          (insert line)
          (setq count (1- count)))
        )

      ;; create the undo information
      (setq buffer-undo-list (cons (cons eol (point)) buffer-undo-list)))
    ) ; end-of-let

  ;; put the point in the lowest line and return
  (next-line arg))

(defun move-text-internal (arg)
  (cond
   ((and mark-active transient-mark-mode)
    (if (> (point) (mark))
        (exchange-point-and-mark))
    (let ((column (current-column))
          (text (delete-and-extract-region (point) (mark))))
      (forward-line arg)
      (move-to-column column t)
      (set-mark (point))
      (insert text)
      (exchange-point-and-mark)
      (setq deactivate-mark nil)))
   (t
    (let ((column (current-column)))
      (beginning-of-line)
      (when (or (> arg 0) (not (bobp)))
        (forward-line)
        (when (or (< arg 0) (not (eobp)))
          (transpose-lines arg))
        (forward-line -1))
      (move-to-column column t)))))

(defun move-text-down (arg)
  "Move region (transient-mark-mode active) or current line
  arg lines down."
  (interactive "*p")
  (move-text-internal arg))

(defun move-text-up (arg)
  "Move region (transient-mark-mode active) or current line
  arg lines up."
  (interactive "*p")
  (move-text-internal (- arg)))

;; Key settings
(define-key osx-key-mode-map [home] 'beginning-of-line)
(define-key osx-key-mode-map [end] 'end-of-line)

(global-set-key (kbd "<A-M-down>") 'duplicate-line)
(global-set-key (kbd "A-d") 'kill-whole-line)

(global-unset-key (kbd "<M-up>"))
(global-unset-key (kbd "<M-down>"))
(global-set-key (kbd "<M-up>") 'move-text-up)
(global-set-key (kbd "<M-down>") 'move-text-down)


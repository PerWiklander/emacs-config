(add-to-list 'load-path "~/.emacs.d/")

(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(auto-compression-mode t nil (jka-compr))
 '(case-fold-search t)
 '(current-language-environment "English")
 '(fringe-mode (quote (nil . 0)) nil (fringe))
 '(global-font-lock-mode t nil (font-lock))
 '(indicate-buffer-boundaries (quote left))
 '(indicate-empty-lines t)
 '(paren-match-face (quote paren-face-match-light))
 '(paren-sexp-mode t)
 '(save-place t nil (saveplace))
 '(scroll-bar-mode nil)
 '(size-indication-mode t)
 '(text-mode-hook (quote (text-mode-hook-identify)))
 '(transient-mark-mode t)
 '(uniquify-buffer-name-style (quote forward) nil (uniquify)))

; Syntax highlighting. Dark background.
; Insert this in custom.el. Then restart XEmacs.

(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(default ((t (:foreground "white" :background "black" :size "13" :family "Monaco"))))
 '(cperl-array-face ((t (:foreground "orangered" :bold t))))
 '(cperl-hash-face ((t (:foreground "Red" :bold t))))
 '(cperl-nonoverridable-face ((t (:foreground "orange" :bold t))))
 '(custom-button-face ((t (:bold t :foreground "#3fdfcf"))) t)
 '(custom-group-tag-face ((t (:underline t :foreground "blue"))) t)
 '(custom-saved-face ((t (:underline t :foreground "orange"))) t)
 '(custom-state-face ((t (:foreground "green3"))) t)
 '(custom-variable-button-face ((t (:bold t :underline t :foreground "white"))) t)
 '(dired-face-permissions ((t (:foreground "green"))))
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
 '(secondary-selection ((t (:foreground "white" :background "red"))))
 '(text-cursor ((t (:foreground "black" :background "green"))) t)
 '(zmacs-region ((t (:background "RoyalBlue"))) t))

(setq magic-mode-alist nil)

(require 'php-mode)
(require 'sass-mode)
(require 'scss-mode)
(require 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))
(require 'asp-mode)
(add-to-list 'auto-mode-alist '("\\.asp$" . asp-mode))

(require 'magit)
(autoload 'magit-status "magit" nil t)

(require 'textile-mode)
(add-to-list 'auto-mode-alist '("\\.textile\\'" . textile-mode))
(add-to-list 'auto-mode-alist '("\\.txt\\'" . textile-mode))

(iswitchb-mode 1)
(setq iswitchb-buffer-ignore '("^\\*Messages"))

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


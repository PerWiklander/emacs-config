(add-to-list 'load-path "~/.emacs.d/")

(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(aquamacs-additional-fontsets nil t)
 '(aquamacs-customization-version-id 215 t)
 '(aquamacs-tool-bar-user-customization (quote ((16777249 new-file open-file recent-files save-buffer aquamacs-print nil undo redo cut copy paste isearch-forward nil customize help))) t)
 '(current-language-environment "UTF-8")
 '(default-frame-alist (quote ((cursor-type . box) (internal-border-width . 0) (modeline . t) (fringe) (mouse-color . "black") (background-mode . light) (menu-bar-lines . 1) (right-fringe . 0) (left-fringe . 14) (cursor-color . "Red") (background-color . "White") (foreground-color . "Black") (font . "-apple-Monaco-medium-normal-normal-*-12-*-*-*-m-0-iso10646-1") (fontsize . 0) (font-backend ns) (vertical-scroll-bars) (tool-bar-lines . 0))))
 '(global-hl-line-mode t)
 '(indicate-buffer-boundaries (quote left))
 '(indicate-empty-lines t)
 '(ns-tool-bar-display-mode (quote both) t)
 '(ns-tool-bar-size-mode (quote regular) t)
 '(scroll-bar-mode nil)
 '(size-indication-mode t)
 '(toolbar-mode nil t)
 '(tooltip-mode nil)
 '(visual-line-mode nil t)
;; '(global-linum-mode t)
)
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 )

;; Global settings
(setq-default css-indent-offset 2)
(setq-default css-indent-offset 2)
(setq-default custom-buffer-indent 2)
(setq-default js-enabled-frameworks (quote (javascript mochikit prototype dojo extjs merrillpress)))
(setq-default js-indent-level 2)
(setq-default standard-indent 2)
(setq-default indent-tabs-mode nil)

(iswitchb-mode 1)
(setq iswitchb-buffer-ignore '("^\\*Messages"))

;; Color theme
(require 'color-theme)
(eval-after-load "color-theme"
  '(progn
     (color-theme-initialize)
     (color-theme-solarized-dark)))

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


(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(package-initialize)

(setq backup-directory-alist `(("." . "~/.saves")))
(setq-default fill-column 80)
; (setq-default auto-fill-function 'do-auto-fill)

; (require 'evil)
; (evil-mode 1)

(add-to-list 'load-path (expand-file-name "~/.emacs.d/org-mode/lisp"))
(add-to-list 'load-path (expand-file-name "~/.emacs.d/org-mode/contrib/lisp"))

(require 'org)
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(setq org-log-done t)
(setq org-tags-column -97)

; (add-hook 'org-mode-hook
;           (lambda ()
;             (org-indent-mode t))
;           t)

; TODO set org agenda files
; (setq org-agenda-files)

; tasks

(setq org-todo-keywords
      (quote ((sequence "PROJECT(p)" "|")
              (sequence "TODO(t)" "|" "DONE(d)")
              (sequence "WAITING(w@/!)" "|" "CANCELLED(c@/!)"))))

(setq org-todo-state-tags-triggers
      (quote (("PROJECT" ("PROJECT" . t))
              ("CANCELLED" ("CANCELLED" . t))
              ("WAITING" ("WAITING" . t))
              (done ("WAITING"))
              ("TODO" ("WAITING") ("CANCELLED") ("HOLD"))
              ("DONE" ("WAITING") ("CANCELLED")))))

(setq org-agenda-tags-column -100)

; refile

(setq org-refile-targets (quote ((nil :maxlevel . 9)
                                 (org-agenda-files :maxlevel . 9))))
(setq org-refile-use-outline-path 'file)

(global-set-key (kbd "C-c c") 'org-capture)
(setq org-directory "~/Org")
(setq org-default-notes-file "~/Org/Refile.org")
(setq org-capture-templates
      (quote (("t" "todo" entry (file "~/Org/Refile.org")
               "* TODO %?\n"))))

; archive

(setq org-archive-mark-done nil)
(setq org-archive-location ".%s_archive::* Archived Tasks")

; journal

(require 'org-journal)
(setq org-journal-dir "~/Org/Journal/")
; (setq org-journal-file-format "%Y-%m-%d")

; agenda

(setq org-enforce-todo-dependencies t)
(setq org-agenda-compact-blocks t)
(setq org-agenda-dim-blocked-tasks nil)

(setq org-agenda-custom-commands
      (quote (
;             ("N" "Notes" tags "NOTE"
;              ((org-agenda-overriding-header "Notes")
;               (org-tags-match-list-sublevels t)))
;             ("h" "Habits" tags-todo "STYLE=\"habit\""
;              ((org-agenda-overriding-header "Habits")
;               (org-agenda-sorting-strategy
;                '(todo-state-down effort-up category-keep))))
              ("a" "Agenda"
               ((agenda "" (
                 (org-agenda-span 1)
                 (org-deadline-warning-days 0)))
                (tags "REFILE"
                      ((org-agenda-overriding-header "Refile")
                       (org-tags-match-list-sublevels nil)))
;               (tags-todo "-CANCELLED/!"
;                          ((org-agenda-overriding-header "Archive")
;                           (org-agenda-skip-function 'bh/skip-non-stuck-projects)
;                           (org-agenda-sorting-strategy
;                            '(category-keep))))
                (tags-todo "PROJECT+active/PROJECT"
                           ((org-agenda-overriding-header "Projects")
                            (org-agenda-hide-tags-regexp "PROJECT\\|active")
                            (org-agenda-sorting-strategy
                             '(priority-down category-keep))))
                (tags-todo "-PROJECT/TODO"
                           ((org-agenda-overriding-header "Tasks")))
                (tags-todo "PROJECT-active/PROJECT"
                           ((org-agenda-overriding-header "Projects Backlog")
                            (org-agenda-hide-tags-regexp "PROJECT")
                            (org-agenda-sorting-strategy
                             '(priority-down category-keep)))))
               nil))))

; checklists

(require 'org-checklist)

; repeated task

(setq org-log-repeat nil)

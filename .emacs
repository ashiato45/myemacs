(when (file-exists-p "~/.opam")
  (load "~/.opam/4.03.0/share/emacs/site-lisp/tuareg-site-file")

  ;; Add opam emacs directory to the load-path
  (setq opam-share (substring (shell-command-to-string "opam config var
   share 2> /dev/null") 0 -1))
  (add-to-list 'load-path (concat opam-share "/emacs/site-lisp"))
  ;; Load merlin-mode
  (require 'merlin)
  ;; Start merlin on ocaml files
  (add-hook 'tuareg-mode-hook 'merlin-mode t)
  (add-hook 'caml-mode-hook 'merlin-mode t)
)


;; https://melpa.org/#/getting-started
;; http://חנוך.se/diary/how_to_enable_GnuTLS_for_Emacs_24_on_Windows/index.en.html
(require 'package) ;; You might already have this line
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))
;; (when (< emacs-major-version 24)
;;   ;; For important compatibility libraries like cl-lib
;;   (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages")))
(package-initialize) ;; You might already have this line

; from http://rontan.sakura.ne.jp/2009/02/tips_emacs_bkfile/
;;; *.~ とかのバックアップファイルを作らない
(setq make-backup-files nil)
;;; .#* とかのバックアップファイルを作らない
(setq auto-save-default nil)

(when (require 'skk nil t)
  (global-set-key (kbd "C-x C-j") 'skk-auto-fill-mode) ;;良い感じに改行を自動入力してくれる機能
  (setq default-input-method "japanese-skk")         ;;emacs上での日本語入力にskkをつかう
  (require 'skk-study))                              ;;変換学習機能の追加

;; http://openlab.ring.gr.jp/skk/skk-manual-git/Zui-moJi-Ben-De-naShe-Ding-.html
(when (file-exists-p "C:/Users/ashia/OneDrive/ドキュメント
/skk/SKK-JISYO.L/SKK-JISYO.L")
  (setq skk-large-jisyo "C:/Users/ashia/OneDrive/ドキュメント/skk/SKK-JISYO.L/SKK-JISYO.L")
)
(when (file-exists-p "/media/sf_OneDrive/ドキュメント
/skk/SKK-JISYO.L/SKK-JISYO.L")
  (setq skk-large-jisyo "/media/sf_OneDrive/ドキュメント
/skk/SKK-JISYO.L/SKK-JISYO.L")
)

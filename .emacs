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
(when (file-exists-p "C:/Users/ashia/OneDrive/ドキュメント/skk/SKK-JISYO.L/SKK-JISYO.L")
  (setq skk-large-jisyo "C:/Users/ashia/OneDrive/ドキュメント/skk/SKK-JISYO.L/SKK-JISYO.L")
  )
(when (file-exists-p "/media/sf_OneDrive/ドキュメント
/skk/SKK-JISYO.L/SKK-JISYO.L")
  (setq skk-large-jisyo "/media/sf_OneDrive/ドキュメント
/skk/SKK-JISYO.L/SKK-JISYO.L")
)

;; http://syohex.hatenablog.com/entry/20110331/1301584188
(show-paren-mode 1)


(when (file-exists-p "C:/Users/ashia/")
  ;;
  ;; YaTeX
  ;;
  (autoload 'yatex-mode "yatex" "Yet Another LaTeX mode" t)
  (setq auto-mode-alist
	(append '(("\\.tex$" . yatex-mode)
		  ("\\.ltx$" . yatex-mode)
		  ("\\.cls$" . yatex-mode)
		  ("\\.sty$" . yatex-mode)
		  ("\\.clo$" . yatex-mode)
		  ("\\.bbl$" . yatex-mode)) auto-mode-alist))
  (setq YaTeX-inhibit-prefix-letter t)
  (setq YaTeX-kanji-code nil)
  (setq YaTeX-latex-message-code 'utf-8)
  (setq YaTeX-use-LaTeX2e t)
  (setq YaTeX-use-AMS-LaTeX t)
  (setq YaTeX-dvi2-command-ext-alist
	'(("TeXworks\\|texworks\\|texstudio\\|mupdf\\|SumatraPDF\\|Preview\\|Skim\\|TeXShop\\|evince\\|okular\\|zathura\\|qpdfview\\|Firefox\\|firefox\\|chrome\\|chromium\\|Adobe\\|Acrobat\\|AcroRd32\\|acroread\\|pdfopen\\|xdg-open\\|open\\|start" . ".pdf")))
  (setq tex-command "ptex2pdf -u -l -ot \"-kanji=utf8 -no-guess-input-enc -synctex=1\"")
					;(setq tex-command "platex-ng -synctex=1")
					;(setq tex-command "pdflatex -synctex=1")
					;(setq tex-command "lualatex -synctex=1")
					;(setq tex-command "luajitlatex -synctex=1")
					;(setq tex-command "xelatex -synctex=1")
					;(setq tex-command "latexmk -e \"$latex=q/uplatex %O -kanji=utf8 -no-guess-input-enc -synctex=1 %S/\" -e \"$bibtex=q/upbibtex %O %B/\" -e \"$biber=q/biber %O --bblencoding=utf8 -u -U --output_safechars %B/\" -e \"$makeindex=q/upmendex %O -o %D %S/\" -e \"$dvipdf=q/dvipdfmx %O -o %D %S/\" -norc -gg -pdfdvi")
					;(setq tex-command "latexmk -e \"$latex=q/uplatex %O -kanji=utf8 -no-guess-input-enc -synctex=1 %S/\" -e \"$bibtex=q/upbibtex %O %B/\" -e \"$biber=q/biber %O --bblencoding=utf8 -u -U --output_safechars %B/\" -e \"$makeindex=q/upmendex %O -o %D %S/\" -e \"$dvips=q/dvips %O -z -f %S | convbkmk -u > %D/\" -e \"$ps2pdf=q/ps2pdf.exe %O %S %D/\" -norc -gg -pdfps")
					;(setq tex-command "latexmk -e \"$pdflatex=q/platex-ng %O -synctex=1 %S/\" -e \"$bibtex=q/upbibtex %O %B/\" -e \"$biber=q/biber %O --bblencoding=utf8 -u -U --output_safechars %B/\" -e \"$makeindex=q/upmendex %O -o %D %S/\" -norc -gg -pdf")
					;(setq tex-command "latexmk -e \"$pdflatex=q/pdflatex %O -synctex=1 %S/\" -e \"$bibtex=q/bibtex %O %B/\" -e \"$biber=q/biber %O --bblencoding=utf8 -u -U --output_safechars %B/\" -e \"$makeindex=q/makeindex %O -o %D %S/\" -norc -gg -pdf")
					;(setq tex-command "latexmk -e \"$pdflatex=q/lualatex %O -synctex=1 %S/\" -e \"$bibtex=q/upbibtex %O %B/\" -e \"$biber=q/biber %O --bblencoding=utf8 -u -U --output_safechars %B/\" -e \"$makeindex=q/upmendex %O -o %D %S/\" -norc -gg -pdf")
					;(setq tex-command "latexmk -e \"$pdflatex=q/luajitlatex %O -synctex=1 %S/\" -e \"$bibtex=q/upbibtex %O %B/\" -e \"$biber=q/biber %O --bblencoding=utf8 -u -U --output_safechars %B/\" -e \"$makeindex=q/upmendex %O -o %D %S/\" -norc -gg -pdf")
					;(setq tex-command "latexmk -e \"$pdflatex=q/xelatex %O -synctex=1 %S/\" -e \"$bibtex=q/upbibtex %O %B/\" -e \"$biber=q/biber %O --bblencoding=utf8 -u -U --output_safechars %B/\" -e \"$makeindex=q/upmendex %O -o %D %S/\" -norc -gg -pdf")
  (setq bibtex-command "latexmk -e \"$latex=q/uplatex %O -kanji=utf8 -no-guess-input-enc -synctex=1 %S/\" -e \"$bibtex=q/upbibtex %O %B/\" -e \"$biber=q/biber %O --bblencoding=utf8 -u -U --output_safechars %B/\" -e \"$makeindex=q/upmendex %O -o %D %S/\" -e \"$dvipdf=q/dvipdfmx %O -o %D %S/\" -norc -gg -pdfdvi")
  (setq makeindex-command "latexmk -e \"$latex=q/uplatex %O -kanji=utf8 -no-guess-input-enc -synctex=1 %S/\" -e \"$bibtex=q/upbibtex %O %B/\" -e \"$biber=q/biber %O --bblencoding=utf8 -u -U --output_safechars %B/\" -e \"$makeindex=q/upmendex %O -o %D %S/\" -e \"$dvipdf=q/dvipdfmx %O -o %D %S/\" -norc -gg -pdfdvi")
  (setq dvi2-command "rundll32 shell32,ShellExec_RunDLL SumatraPDF -reuse-instance")
					;(setq dvi2-command "texworks")
					;(setq dvi2-command "texstudio --pdf-viewer-only")
					;  (setq tex-pdfview-command "rundll32 shell32,ShellExec_RunDLL SumatraPDF -reuse-instance")
  (setq tex-pdfview-command "SumatraPDF -reuse-instance")
					;(setq tex-pdfview-command "texworks")
					;(setq tex-pdfview-command "texstudio --pdf-viewer-only")
  (setq dviprint-command-format "powershell -Command \"& {$r = Write-Output %s;$p = [System.String]::Concat('\"\"\"',[System.IO.Path]::GetFileNameWithoutExtension($r),'.pdf','\"\"\"');Start-Process pdfopen -ArgumentList ('--r15','--file',$p)}\"")
  (defun sumatrapdf-forward-search ()
    (interactive)
    (progn
      (process-kill-without-query
       (start-process
	"fwdsumatrapdf"
	nil
	"fwdsumatrapdf"
	(expand-file-name
	 (concat (file-name-sans-extension (or YaTeX-parent-file
					       (save-excursion
						 (YaTeX-visit-main t)
						 buffer-file-name)))
		 ".pdf"))
	(buffer-name)
	(number-to-string (save-restriction
			    (widen)
			    (count-lines (point-min) (point))))))))
  (add-hook 'yatex-mode-hook
	    '(lambda ()
	       (define-key YaTeX-mode-map (kbd "C-c s") 'sumatrapdf-forward-search)))
  (add-hook 'yatex-mode-hook
	    '(lambda ()
	       (auto-fill-mode -1)))
  ;;
  ;; RefTeX with YaTeX
  ;;
					;(add-hook 'yatex-mode-hook 'turn-on-reftex)
  (add-hook 'yatex-mode-hook
	    '(lambda ()
	       (reftex-mode 1)
	       (define-key reftex-mode-map (concat YaTeX-prefix ">") 'YaTeX-comment-region)
	       (define-key reftex-mode-map (concat YaTeX-prefix "<") 'YaTeX-uncomment-region)))

  ;;  for inverse search
  (server-start)
  
  ;; https://twitter.com/hiroseyuuji/status/782197412332920832
  (add-hook 'yatex-mode-hook
	    '(lambda ()
	       (define-key YaTeX-mode-map (kbd "C-c C-t")
		 '(lambda()(interactive)(YaTeX-make-section nil nil nil "text")))
	       ))
  
  )



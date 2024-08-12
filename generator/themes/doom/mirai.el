(require 'doom-themes)

;;
(defgroup mirai-theme nil
  "Options for doom-themes"
  :group 'doom-themes)

(defcustom mirai-brighter-modeline nil
  "If non-nil, more vivid colors will be used to style the mode-line."
  :group 'mirai-theme
  :type 'boolean)

(defcustom mirai-brighter-comments nil
  "If non-nil, comments will be highlighted in more vivid colors."
  :group 'mirai-theme
  :type 'boolean)

(defcustom mirai-comment-bg mirai-brighter-comments
  "If non-nil, comments will have a subtle, darker background. Enhancing their
legibility."
  :group 'mirai-theme
  :type 'boolean)

(defcustom mirai-padded-modeline nil
  "If non-nil, adds a 4px padding to the mode-line. Can be an integer to
determine the exact padding."
  :group 'mirai-theme
  :type '(or integer boolean))

(setq doom-themes-enable-bold t
      doom-themes-enable-italic t)

(def-doom-theme mirai
  "A dark theme inspired by Atom One Dark"
  ;; name        default   256       16
  ((bg         '("#1c1c1c" nil       nil            ))
   (bg-dark    '("#1c1c1c" nil       nil            ))
   (bg-alt     '("#1c1c1c" nil       nil            ))
   (bg-so      '("#212121" nil       nil            ))
   (bg-alt-so  '("#1c1c1c" nil       nil            ))
   (fg         '("#ffffff" "#ffffff" "white"        ))
   (fg-alt     '("#979797" "#979797" "white"        ))

   (base0      '("#212121"   "black"   "black"        ))
   (base1      '("#1e1e1e" "#1e1e1e" "brightblack"  ))
   (base2      '("#212121" "#2e2e2e" "brightblack"  ))
   (base3      '("#262626" "#262626" "brightblack"  ))
   (base4      '("#3f3f3f" "#3f3f3f" "brightblack"  ))
   (base5      '("#525252" "#525252" "brightblack"  ))
   (base6      '("#6b6b6b" "#6b6b6b" "brightblack"  ))
   (base7      '("#979797" "#979797" "brightblack"  ))
   (base8      '("#dfdfdf" "#dfdfdf" "white"        ))


   (grey       "#757575")
   (red        '("#757575" "#525252" "red"          )) ;
   (orange     '("#FCF707" "#6e43e5" "brightred"    )) ; Numbers
   (green      '("#FF1652" "#6e43e5" "green"        )) ; Strings, brackets
   (teal       '("#FF1652" "#6e43e5" "brightgreen"  )) ; Only hydra and rainbow delimiters
   (yellow     '("#FF1652" "#6e43e5" "yellow"       )) ; Objects, types, Lisp functions
   (blue       '("#757575" "#525252" "brightblue"   )) ; brackets, UI colors, autocomplete foreground, cursor
   (dark-blue  '("#757575" "#525252" "blue"         )) ; Selection in menus and autocomplete and
   (magenta    '("#ffffff" "#ffffff" "magenta"      )) ; Functions and defines
   (violet     '("#757575" "#525252" "brightmagenta")) ; this, backdrop UI colors, comment points
   (cyan       '("#979797" "#979797" "brightcyan"   )) ; html.. tags
   (dark-cyan  '("#979797" "#979797" "cyan"         )) ; Was used for blending comments with base4 ba

   (g-red      '("#ff6c6b" "#ff6655" "red"          ))
   (g-orange   '("#da8548" "#dd8844" "brightred"    ))
   (g-green    '("#98be65" "#99bb66" "green"        ))

   ;; face categories -- required for all themes
   (abstract       (doom-lighten bg 0.1))
   (current-line   (doom-lighten bg 0.04))
   (highlight      teal)
   (vertical-bar   base1)
   (selection      base4)
   (builtin        magenta)
   (comments       base5)
   (doc-comments   comments)
   (constants      violet)
   (functions      magenta)
   (keywords       blue)
   (methods        cyan)
   (operators      blue)
   (type           yellow)
   (strings        green)
   (variables      magenta)
   (numbers        orange)
   (region         base0)
   (error          red)
   (warning        yellow)
   (success        green)
   (vc-modified    orange)
   (vc-added       green)
   (vc-deleted     red)
   (fc-red         red)
   (fc-yellow      yellow)
   (fc-orange      yellow)
   (fc-green       green)

   ;; custom categories
   (-modeline-bright mirai-brighter-modeline)
   (-modeline-pad
    (when mirai-padded-modeline
      (if (integerp mirai-padded-modeline) mirai-padded-modeline 4)))

   (modeline-fg     nil)
   (modeline-fg-alt (doom-blend violet base4 (if -modeline-bright 0.5 0.2)))

   (modeline-bg
    (if -modeline-bright
        (doom-darken blue 0.475)
      `(,(doom-darken (car bg) 0.1) ,@(cdr base0))))
   (modeline-bg-l
    (if -modeline-bright
        (doom-darken blue 0.45)
      `(,(doom-darken (car bg-alt) 0.125) ,@(cdr base0))))
   (modeline-bg-inactive   (car bg))
   (modeline-bg-inactive-l `(,(car bg-alt) ,@(cdr base1))))


  ;; --- extra faces ------------------------
  ((elscreen-tab-other-screen-face :background "#353a42" :foreground "#1e2022")

   (font-lock-doom-comment-face :foreground comments)
   (font-lock-doom-main-face :foreground blue)

   (font-doom-comment      :foreground comments)
   (font-doom-keyword      :foreground keywords)

   (line-number :inherit 'default :foreground comments :distant-foreground nil )
   (line-number-current-line :inherit 'hl-line :foreground (doom-lighten comments 0.35) :distant-foreground nil )

   (doom-modeline-bar :background (if -modeline-bright modeline-bg highlight))

   (mode-line
    :background modeline-bg :foreground modeline-fg
    :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg)))
   (mode-line-inactive
    :background modeline-bg-inactive :foreground modeline-fg-alt
    :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg-inactive)))
   (mode-line-emphasis
    :foreground (if -modeline-bright base8 comments))

   (solaire-mode-line-face
    :inherit 'mode-line
    :background modeline-bg-l
    :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg-l)))
   (solaire-mode-line-inactive-face
    :inherit 'mode-line-inactive
    :background modeline-bg-inactive-l
    :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg-inactive-l)))

   ;; --- major-mode faces -------------------
   (font-lock-builtin-face      :foreground red)

   ;; web-mode
   (web-mode-html-tag-face              :foreground highlight)
   (web-mode-current-element-highlight-face :foreground fg :background nil)
   (web-mode-html-attr-name-face        :foreground constants :inherit 'italic)
   ;; (web-mode-block-control-face     :foreground green)
   ;; (web-mode-html-tag-bracket-face  :foreground variables)
   ;;

   ;; rjsx
   (rjsx-tag          :foreground highlight)
   (rjsx-attr          :foreground type :inherit 'italic)

   ;; css-mode / scss-mode
   (css-proprietary-property :foreground orange)
   (css-property             :foreground fg)
   (css-selector             :foreground highlight)

   ;; markdown-mode
   (markdown-markup-face :foreground base5)
   (markdown-header-face :inherit 'bold :foreground red)
   (markdown-code-face :background (doom-lighten base3 0.05))

   ;; js2-mode
   (js2-function-param  :foreground constants)
   (js2-function-call   :foreground functions)
   (js2-object-property :foreground violet)
   (js2-jsdoc-tag       :foreground comments)

   ;; visual-regex
   (vr/match          :background dark-blue :foreground bg)
   (vr/match-0          :background dark-blue :foreground bg)
   (vr/match-1          :background violet :foreground bg)
   (vr/group          :background base8 :foreground bg)
   (vr/group-0          :background base8 :foreground bg)
   (vr/group-1          :background base7 :foreground bg)
   (vr/group-2          :background dark-cyan :foreground fg)

   ;; touch-ups
   (show-paren-match    :foreground highlight   :background nil :weight 'bold)
   (highlight           :background highlight  :foreground bg :distant-foreground fg)
   (hl-todo-face        :foreground highlight :inherit 'italic)
   (lazy-highlight      :background highlight  :foreground bg :distant-foreground fg)
   (ivy-current-match   :background highlight  :foreground bg :distant-foreground fg)
   (whitespace-line     :background red        :foreground bg)
   (whitespace-tab      :foreground base4 :background nil)
   (rainbow-delimiter-depth-1-face :foreground blue)

   (ivy-minibuffer-match-face-1 :background nil :foreground (doom-lighten grey 0.1))
   (ivy-minibuffer-match-face-2 :inherit 'ivy-minibuffer-match-face-1 :foreground magenta)
   (ivy-minibuffer-match-face-3 :inherit 'ivy-minibuffer-match-face-1 :foreground magenta)
   (ivy-minibuffer-match-face-4 :inherit 'ivy-minibuffer-match-face-1 :foreground red)

   ;; common
   (tooltip              :background bg-dark :foreground fg)
   (lazy-highlight       :background highlight  :foreground base8 :distant-foreground base0 :weight 'bold)
   (match                :foreground green      :background base0 :weight 'bold)
   (vertical-border      :background bg :foreground bg)

   (font-lock-comment-face              :foreground comments :inherit 'italic)
   (font-lock-comment-delimiter-face    :foreground base3)
   (font-lock-keyword-face              :foreground keywords :inherit 'italic)
   (font-lock-constant-face             :foreground comments :inherit 'italic)

   ;; ediff | TODO: finish this
   (ediff-fine-diff-A    :background g-red :inherit 'bold)
   (ediff-fine-diff-B    :background g-green :inherit 'bold)
   (ediff-fine-diff-C    :background g-orange :inherit 'bold)
   (ediff-current-diff-A :background g-red)
   (ediff-current-diff-B :background g-green)
   (ediff-current-diff-C :background (doom-blend g-orange bg 0.2))
   (ediff-even-diff-A    :inherit 'hl-line)
   (ediff-even-diff-B    :inherit 'hl-line)
   (ediff-even-diff-C    :inherit 'hl-line)
   (ediff-odd-diff-A     :inherit 'hl-line)
   (ediff-odd-diff-B     :inherit 'hl-line)
   (ediff-odd-diff-C     :inherit 'hl-line)

   (flycheck-error     :underline `(:style line :color ,fc-red))
   (flycheck-warning   :underline `(:style line :color ,fc-yellow))
   (flycheck-info      :underline `(:style line :color ,fc-green))

   (flymake-warnline :background bg :underline `(:style line :color ,fc-orange))
   (flymake-errline  :background bg :underline `(:style line :color ,fc-red))

   (magit-bisect-bad        :foreground g-red)
   (magit-bisect-good       :foreground g-green)
   (magit-bisect-skip       :foreground g-orange)
   (magit-blame-date        :foreground g-red)
   (magit-blame-heading     :foreground g-orange :background base3)
   (magit-branch-current    :foreground blue)
   (magit-branch-local      :foreground cyan)
   (magit-branch-remote     :foreground g-green)
   (magit-cherry-equivalent :foreground violet)
   (magit-cherry-unmatched  :foreground cyan)
   (magit-diff-added             :foreground (doom-darken g-green 0.2)  :background (doom-blend g-green bg 0.1))
   (magit-diff-added-highlight   :foreground g-green                    :background (doom-blend g-green bg 0.2) :weight 'bold)
   (magit-diff-base              :foreground (doom-darken g-orange 0.2) :background (doom-blend g-orange bg 0.1))
   (magit-diff-base-highlight    :foreground g-orange                   :background (doom-blend g-orange bg 0.2) :weight 'bold)
   (magit-diff-context           :foreground (doom-darken fg 0.4) :background bg)
   (magit-diff-context-highlight :foreground fg                   :background bg-alt)
   (magit-diff-file-heading           :foreground fg :weight 'bold)
   (magit-diff-file-heading-selection :foreground magenta               :background dark-blue :weight 'bold)
   (magit-diff-hunk-heading           :foreground bg                    :background (doom-blend violet bg 0.3))
   (magit-diff-hunk-heading-highlight :foreground bg                    :background violet :eight 'bold)
   (magit-diff-removed                :foreground (doom-darken g-red 0.3) :background (doom-blend g-red base3 0.05))
   (magit-diff-removed-highlight      :foreground g-red                   :background (doom-blend g-red base3 0.1) :weight 'bold)
   (magit-diff-lines-heading          :foreground yellow     :background g-red)
   (magit-diffstat-added              :foreground g-green)
   (magit-diffstat-removed            :foreground g-red)
   (magit-dimmed :foreground comments)
   (magit-hash :foreground comments)
   (magit-header-line :background dark-blue :foreground base8 :weight 'bold
                      :box `(:line-width 3 :color ,dark-blue))
   (magit-log-author :foreground g-orange)
   (magit-log-date :foreground blue)
   (magit-log-graph :foreground comments)
   (magit-process-ng :inherit 'error)
   (magit-process-ok :inherit 'success)
   (magit-reflog-amend :foreground magenta)
   (magit-reflog-checkout :foreground blue)
   (magit-reflog-cherry-pick :foreground g-green)
   (magit-reflog-commit :foreground g-green)
   (magit-reflog-merge :foreground g-green)
   (magit-reflog-other :foreground cyan)
   (magit-reflog-rebase :foreground magenta)
   (magit-reflog-remote :foreground cyan)
   (magit-reflog-reset :inherit 'error)
   (magit-refname :foreground comments)
   (magit-section-heading           :foreground blue :weight 'bold)
   (magit-section-heading-selection :foreground g-orange :weight 'bold)
   (magit-section-highlight :inherit 'hl-line)
   (magit-sequence-drop :foreground g-red)
   (magit-sequence-head :foreground blue)
   (magit-sequence-part :foreground g-orange)
   (magit-sequence-stop :foreground g-green)
   (magit-signature-bad :inherit 'error)
   (magit-signature-error :inherit 'error)
   (magit-signature-expig-red :foreground g-orange)
   (magit-signature-good :inherit 'success)
   (magit-signature-revoked :foreground magenta)
   (magit-signature-untrusted :foreground cyan)
   (magit-tag :foreground yellow)
   (magit-filename :foreground violet)
   (magit-section-secondary-heading :foreground violet :weight 'bold)

   ;; org-mode
   (org-block-begin-line         :foreground comments :background nil)
   (org-block                    :background nil)

   (org-level-1 :foreground blue     :background nil :height 1.25)
   (org-level-2 :foreground magenta)
   (org-level-3 :foreground violet)
   (org-level-4 :foreground (doom-lighten blue 0.25))
   (org-level-5 :foreground (doom-lighten magenta 0.25))
   (org-level-6 :foreground (doom-lighten blue 0.5))
   (org-level-7 :foreground (doom-lighten magenta 0.5))
   (org-level-8 :foreground (doom-lighten blue 0.8))

   (org-tag             :foreground doc-comments)
   (org-ref-cite-face   :foreground yellow :underline t)

   (org-ellipsis :underline nil :background nil :foreground violet)

   ;; LSP faces
   (lsp-face-highlight-textual :background highlight  :foreground bg :distant-foreground fg)
   ;; (lsp-face-highlight-read)
   ;; (lsp-face-highlight-write)
   ;; (lsp-lens-mouse-face)
   ;; (lsp-lens-face)
   ;; (lsp-face-highlight-write)
   ;; (lsp-face-highlight-write)
   ;; (lsp-face-highlight-write)
   ;; (lsp-face-highlight-write)
   ;; (lsp-face-highlight-write)
   ;; (lsp-face-highlight-write)

   ;; LSP UI faces
   (lsp-ui-sideline-code-action :foreground comments)
   (company-tooltip-search-selection :foreground selection)
   (company-tooltip-selection :foreground highlight)
   (company-tooltip-common-selection :foreground highlight)
   ;; (company-tooltip :foreground base7)

   ;; (neo-root-dir-face   :foreground highlight :background bg :box `(:line-width 4 :color ,bg))
   (neo-root-dir-face   :foreground bg :distant-foreground highlight :background highlight :box `(:line-width 4 :color ,highlight))
   )
  )

;;; mirai-theme.el ends here

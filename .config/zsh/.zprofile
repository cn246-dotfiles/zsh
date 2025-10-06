# FZF
if [[ -d "$HOME/.local/src/fzf" ]]; then
  # Setup
  DISABLE_FZF_AUTO_COMPLETION="false"
  DISABLE_FZF_KEY_BINDINGS="false"
  FZF_BASE="$HOME/.local/src/fzf/"

  # Default options
  FZF_DEFAULT_COMMAND='rg --files --hidden --glob "!.git/*"'
  FZF_DEFAULT_OPTS="--height=40% --layout=reverse --info=inline --border --margin=1 --padding=1 --tmux=bottom,80%,40%"
  FZF_DEFAULT_OPTS="${FZF_DEFAULT_OPTS} --bind alt-j:page-down,alt-k:page-up"
  FZF_DEFAULT_OPTS="${FZF_DEFAULT_OPTS},ctrl-alt-k:preview-up,ctrl-alt-j:preview-down"
  FZF_DEFAULT_OPTS="${FZF_DEFAULT_OPTS},ctrl-alt-u:preview-half-page-up,ctrl-alt-d:preview-half-page-down"
  FZF_DEFAULT_OPTS="${FZF_DEFAULT_OPTS},ctrl-alt-b:preview-page-up,ctrl-alt-f:preview-page-down"
  FZF_DEFAULT_OPTS="${FZF_DEFAULT_OPTS},ctrl-alt-h:preview-top,ctrl-alt-g:preview-bottom"

  # cd list options
  FZF_ALT_C_COMMAND="find * -mindepth 1 -maxdepth 2 -type d | sort"
  FZF_ALT_C_OPTS="--preview 'tree -C {} 2> /dev/null | head -200'"

  # History options
  FZF_CTRL_R_OPTS="--no-sort --padding=0,1,1 --color header:italic --exact"
  FZF_CTRL_R_OPTS="${FZF_CTRL_R_OPTS} --header-first --header-border=double"
  FZF_CTRL_R_OPTS="${FZF_CTRL_R_OPTS} --header 'Press ? to toggle preview\nPress CTRL+Y to copy command into clipboard'"
  FZF_CTRL_R_OPTS="${FZF_CTRL_R_OPTS} --preview 'echo {}' --preview-window down:20%:hidden:wrap"
  FZF_CTRL_R_OPTS="${FZF_CTRL_R_OPTS} --bind '?:toggle-preview'"
  FZF_CTRL_R_OPTS="${FZF_CTRL_R_OPTS} --bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort'"

  # File list options
  FZF_CTRL_T_COMMAND="find . -mindepth 1 -maxdepth 1 | cut -d'/' -f2 | sort"
  FZF_CTRL_T_OPTS="--prompt 'All> ' --header 'CTRL-D: Directories / CTRL-F: Files'"
  FZF_CTRL_T_OPTS="${FZF_CTRL_T_OPTS} --bind 'ctrl-d:change-prompt(Directories> )+reload(find . -mindepth 1 -maxdepth 1 -type d | cut -d'/' -f2)'"
  FZF_CTRL_T_OPTS="${FZF_CTRL_T_OPTS} --bind 'ctrl-f:change-prompt(Files> )+reload(find . -mindepth 1 -maxdepth 1 -type f | cut -d'/' -f2)'"
  FZF_CTRL_T_OPTS="${FZF_CTRL_T_OPTS} --preview '(bat {} || tree -C {}) 2> /dev/null | head -200'"

  export FZF_BASE
  export FZF_DEFAULT_COMMAND FZF_ALT_C_COMMAND FZF_CTRL_T_COMMAND
  export FZF_DEFAULT_OPTS FZF_ALT_C_OPTS FZF_CTRL_R_OPTS FZF_CTRL_T_OPTS
  export DISABLE_FZF_AUTO_COMPLETION DISABLE_FZF_KEY_BINDINGS
fi


# HOMEBREW
brew_binary=''
[[ -x "/opt/homebrew/bin/brew" ]] && brew_binary="/opt/homebrew/bin/brew"
[[ -x "$HOME/.local/homebrew/bin/brew" ]] && brew_binary="$HOME/.local/homebrew/bin/brew"

typeset -U path
typeset -U fpath

# Prepend local bin and Homebrew paths if available
if [[ -n "${brew_binary}" ]]; then
  eval "$(${brew_binary} shellenv)"
  export HOMEBREW_NO_ANALYTICS=1

  path=(
    "${HOME}/.local/bin"
    "${HOMEBREW_PREFIX}/bin"
    "${HOMEBREW_PREFIX}/sbin"
    ${path}
  )

  fpath=(
    "${ZDOTDIR}/functions"
    "${ZDOTDIR}/completions"
    "${HOMEBREW_PREFIX}/share/zsh/site-functions"
    ${fpath}
  )
else
  path=("${HOME}/.local/bin" ${path})
  fpath=("${ZDOTDIR}/functions" "${ZDOTDIR}/completions" ${fpath})
fi

export PATH FPATH

# LS
LS_COLORS='st=0;38;2;39;46;51;48;2;167;192;128:cd=3;38;2;219;188;127:bd=1;38;2;127;187;179:*~=3;38;2;133;146;137:di=1;38;2;127;187;179:so=1;38;2;131;192;146:pi=0;38;2;219;188;127:ex=1;38;2;167;192;128:tw=0;38;2;39;46;51;48;2;219;188;127:do=1;38;2;131;192;146:mi=0;38;2;39;46;51;48;2;230;126;128:ca=0;38;2;40;46;51;48;2;230;126;128:fi=0;38;2;211;198;170;48;2;40;46;51:ln=1;38;2;214;153;182:or=0;38;2;230;126;128;48;2;73;81;86:mh=0;38;2;131;192;146:su=1;38;2;230;126;128:rs=0:sg=1;38;2;219;188;127:ow=0;38;2;219;188;127:no=0;38;2;211;198;170;48;2;40;46;51:*.h=0;38;2;211;198;170:*.d=0;38;2;211;198;170:*.a=1;38;2;167;192;128:*.o=3;38;2;133;146;137:*.c=0;38;2;211;198;170:*.m=0;38;2;211;198;170:*.t=0;38;2;211;198;170:*.r=0;38;2;211;198;170:*.p=0;38;2;211;198;170:*.z=4;38;2;230;152;117:*.bc=3;38;2;133;146;137:*.gz=4;38;2;230;152;117:*.ps=0;38;2;230;126;128:*.ml=0;38;2;211;198;170:*.cr=0;38;2;211;198;170:*.hi=3;38;2;133;146;137:*.pp=0;38;2;211;198;170:*.ex=0;38;2;211;198;170:*.fs=0;38;2;211;198;170:*.mn=0;38;2;211;198;170:*.wv=0;38;2;214;153;182:*.pl=0;38;2;211;198;170:*css=0;38;2;211;198;170:*.rs=0;38;2;211;198;170:*.rb=0;38;2;211;198;170:*.rm=0;38;2;214;153;182:*.md=0;38;2;219;188;127:*.hh=0;38;2;211;198;170:*.gv=0;38;2;211;198;170:*.la=3;38;2;133;146;137:*.sh=0;38;2;211;198;170:*.el=0;38;2;211;198;170:*.jl=0;38;2;211;198;170:*.go=0;38;2;211;198;170:*.ui=0;38;2;131;192;146:*.xz=4;38;2;230;152;117:*.cp=0;38;2;211;198;170:*.ko=1;38;2;167;192;128:*.kt=0;38;2;211;198;170:*.cc=0;38;2;211;198;170:*.td=0;38;2;211;198;170:*.nb=0;38;2;211;198;170:*.di=0;38;2;211;198;170:*.lo=3;38;2;133;146;137:*.js=0;38;2;211;198;170:*.ts=0;38;2;211;198;170:*.py=0;38;2;211;198;170:*.as=0;38;2;211;198;170:*.bz=4;38;2;230;152;117:*.vb=0;38;2;211;198;170:*.cs=0;38;2;211;198;170:*.pm=0;38;2;211;198;170:*.so=1;38;2;167;192;128:*.ll=0;38;2;211;198;170:*.7z=4;38;2;230;152;117:*.hs=0;38;2;211;198;170:*.csx=0;38;2;211;198;170:*hgrc=3;38;2;131;192;146:*.wmv=0;38;2;214;153;182:*.bat=1;38;2;167;192;128:*.swp=3;38;2;133;146;137:*.m4v=0;38;2;214;153;182:*.blg=3;38;2;133;146;137:*.htc=0;38;2;211;198;170:*.pps=0;38;2;230;126;128:*.cxx=0;38;2;211;198;170:*.dmg=1;38;2;230;152;117:*.tbz=4;38;2;230;152;117:*.dpr=0;38;2;211;198;170:*.jar=4;38;2;230;152;117:*.out=3;38;2;133;146;137:*.psd=0;38;2;214;153;182:*.bib=0;38;2;131;192;146:*.inl=0;38;2;211;198;170:*.iso=1;38;2;230;152;117:*.doc=0;38;2;230;126;128:*.mpg=0;38;2;214;153;182:*.img=1;38;2;230;152;117:*.wav=0;38;2;214;153;182:*.bz2=4;38;2;230;152;117:*.mir=0;38;2;211;198;170:*.fsx=0;38;2;211;198;170:*.tar=4;38;2;230;152;117:*.git=3;38;2;133;146;137:*.ilg=3;38;2;133;146;137:*.fsi=0;38;2;211;198;170:*.tmp=3;38;2;133;146;137:*.fnt=0;38;2;214;153;182:*.bbl=3;38;2;133;146;137:*.xcf=0;38;2;214;153;182:*.sxi=0;38;2;230;126;128:*.erl=0;38;2;211;198;170:*.exe=1;38;2;167;192;128:*.tml=0;38;2;131;192;146:*TODO=0;38;2;230;126;128:*.mli=0;38;2;211;198;170:*.ppt=0;38;2;230;126;128:*.vim=0;38;2;211;198;170:*.sql=0;38;2;211;198;170:*.dot=0;38;2;211;198;170:*.jpg=0;38;2;214;153;182:*.dll=1;38;2;167;192;128:*.flv=0;38;2;214;153;182:*.pid=3;38;2;133;146;137:*.pgm=0;38;2;214;153;182:*.pas=0;38;2;211;198;170:*.aif=0;38;2;214;153;182:*.tsx=0;38;2;211;198;170:*.ps1=0;38;2;211;198;170:*.pyo=3;38;2;133;146;137:*.nix=0;38;2;131;192;146:*.ini=0;38;2;131;192;146:*.ogg=0;38;2;214;153;182:*.ods=0;38;2;230;126;128:*.odt=0;38;2;230;126;128:*.zsh=0;38;2;211;198;170:*.bag=4;38;2;230;152;117:*.png=0;38;2;214;153;182:*.ppm=0;38;2;214;153;182:*.dox=3;38;2;131;192;146:*.bsh=0;38;2;211;198;170:*.fon=0;38;2;214;153;182:*.lua=0;38;2;211;198;170:*.zst=4;38;2;230;152;117:*.elm=0;38;2;211;198;170:*.inc=0;38;2;211;198;170:*.php=0;38;2;211;198;170:*.ipp=0;38;2;211;198;170:*.hxx=0;38;2;211;198;170:*.apk=4;38;2;230;152;117:*.kts=0;38;2;211;198;170:*.com=1;38;2;167;192;128:*.cgi=0;38;2;211;198;170:*.pyd=3;38;2;133;146;137:*.xml=0;38;2;219;188;127:*.rtf=0;38;2;230;126;128:*.sbt=0;38;2;211;198;170:*.rpm=4;38;2;230;152;117:*.xlr=0;38;2;230;126;128:*.cfg=0;38;2;131;192;146:*.bak=3;38;2;133;146;137:*.mp4=0;38;2;214;153;182:*.mid=0;38;2;214;153;182:*.gvy=0;38;2;211;198;170:*.rst=0;38;2;219;188;127:*.idx=3;38;2;133;146;137:*.fls=3;38;2;133;146;137:*.pyc=3;38;2;133;146;137:*.ics=0;38;2;230;126;128:*.pkg=4;38;2;230;152;117:*.pro=3;38;2;131;192;146:*.cpp=0;38;2;211;198;170:*.aux=3;38;2;133;146;137:*.rar=4;38;2;230;152;117:*.kex=0;38;2;230;126;128:*.pdf=0;38;2;230;126;128:*.vcd=1;38;2;230;152;117:*.exs=0;38;2;211;198;170:*.bmp=0;38;2;214;153;182:*.gif=0;38;2;214;153;182:*.xmp=0;38;2;131;192;146:*.mkv=0;38;2;214;153;182:*.xls=0;38;2;230;126;128:*.arj=4;38;2;230;152;117:*.def=0;38;2;211;198;170:*.swf=0;38;2;214;153;182:*.deb=4;38;2;230;152;117:*.bcf=3;38;2;133;146;137:*.mp3=0;38;2;214;153;182:*.csv=0;38;2;219;188;127:*.tif=0;38;2;214;153;182:*.vob=0;38;2;214;153;182:*.tcl=0;38;2;211;198;170:*.awk=0;38;2;211;198;170:*.sxw=0;38;2;230;126;128:*.svg=0;38;2;214;153;182:*.c++=0;38;2;211;198;170:*.ttf=0;38;2;214;153;182:*.ltx=0;38;2;211;198;170:*.tex=0;38;2;211;198;170:*.pod=0;38;2;211;198;170:*.htm=0;38;2;219;188;127:*.txt=0;38;2;211;198;170:*.wma=0;38;2;214;153;182:*.ind=3;38;2;133;146;137:*.bst=0;38;2;131;192;146:*.hpp=0;38;2;211;198;170:*.h++=0;38;2;211;198;170:*.otf=0;38;2;214;153;182:*.bin=1;38;2;230;152;117:*.epp=0;38;2;211;198;170:*.odp=0;38;2;230;126;128:*.avi=0;38;2;214;153;182:*.yml=0;38;2;131;192;146:*.log=3;38;2;133;146;137:*.ico=0;38;2;214;153;182:*.zip=4;38;2;230;152;117:*.eps=0;38;2;214;153;182:*.clj=0;38;2;211;198;170:*.toc=3;38;2;133;146;137:*.mov=0;38;2;214;153;182:*.m4a=0;38;2;214;153;182:*.tgz=4;38;2;230;152;117:*.sty=3;38;2;133;146;137:*.asa=0;38;2;211;198;170:*.pbm=0;38;2;214;153;182:*.pptx=0;38;2;230;126;128:*.toml=0;38;2;131;192;146:*.webm=0;38;2;214;153;182:*.purs=0;38;2;211;198;170:*.h264=0;38;2;214;153;182:*.hgrc=3;38;2;131;192;146:*.bash=0;38;2;211;198;170:*.orig=3;38;2;133;146;137:*.json=0;38;2;131;192;146:*.epub=0;38;2;230;126;128:*.conf=0;38;2;131;192;146:*.jpeg=0;38;2;214;153;182:*.dart=0;38;2;211;198;170:*.rlib=3;38;2;133;146;137:*.lisp=0;38;2;211;198;170:*.yaml=0;38;2;131;192;146:*.psd1=0;38;2;211;198;170:*.tiff=0;38;2;214;153;182:*.xlsx=0;38;2;230;126;128:*.diff=0;38;2;211;198;170:*.fish=0;38;2;211;198;170:*.opus=0;38;2;214;153;182:*.html=0;38;2;219;188;127:*.java=0;38;2;211;198;170:*.make=3;38;2;131;192;146:*.flac=0;38;2;214;153;182:*.tbz2=4;38;2;230;152;117:*.less=0;38;2;211;198;170:*.psm1=0;38;2;211;198;170:*.lock=3;38;2;133;146;137:*.mpeg=0;38;2;214;153;182:*.docx=0;38;2;230;126;128:*passwd=0;38;2;131;192;146:*.toast=1;38;2;230;152;117:*.swift=0;38;2;211;198;170:*.scala=0;38;2;211;198;170:*.ipynb=0;38;2;211;198;170:*.mdown=0;38;2;219;188;127:*.shtml=0;38;2;219;188;127:*.patch=0;38;2;211;198;170:*.dyn_o=3;38;2;133;146;137:*.xhtml=0;38;2;219;188;127:*shadow=0;38;2;131;192;146:*.cache=3;38;2;133;146;137:*README=1;38;2;219;188;127:*.cabal=0;38;2;211;198;170:*.class=3;38;2;133;146;137:*.cmake=3;38;2;131;192;146:*.dyn_hi=3;38;2;133;146;137:*.ignore=3;38;2;131;192;146:*.flake8=3;38;2;131;192;146:*.groovy=0;38;2;211;198;170:*LICENSE=3;38;2;133;146;137:*INSTALL=1;38;2;219;188;127:*TODO.md=0;38;2;230;126;128:*.matlab=0;38;2;211;198;170:*COPYING=3;38;2;133;146;137:*.gradle=0;38;2;211;198;170:*.config=0;38;2;131;192;146:*.gemspec=3;38;2;131;192;146:*.desktop=0;38;2;131;192;146:*setup.py=3;38;2;131;192;146:*TODO.txt=0;38;2;230;126;128:*Makefile=3;38;2;131;192;146:*Doxyfile=3;38;2;131;192;146:*.cmake.in=3;38;2;131;192;146:*.kdevelop=3;38;2;131;192;146:*COPYRIGHT=3;38;2;133;146;137:*.markdown=0;38;2;219;188;127:*README.md=1;38;2;219;188;127:*.rgignore=3;38;2;131;192;146:*.DS_Store=3;38;2;133;146;137:*.fdignore=3;38;2;131;192;146:*configure=3;38;2;131;192;146:*SConstruct=3;38;2;131;192;146:*CODEOWNERS=3;38;2;131;192;146:*.localized=3;38;2;133;146;137:*.scons_opt=3;38;2;133;146;137:*Dockerfile=0;38;2;131;192;146:*.gitconfig=3;38;2;131;192;146:*INSTALL.md=1;38;2;219;188;127:*.gitignore=3;38;2;131;192;146:*SConscript=3;38;2;131;192;146:*README.txt=1;38;2;219;188;127:*LICENSE-MIT=3;38;2;133;146;137:*.gitmodules=3;38;2;131;192;146:*.synctex.gz=3;38;2;133;146;137:*INSTALL.txt=1;38;2;219;188;127:*.travis.yml=0;38;2;167;192;128:*Makefile.am=3;38;2;131;192;146:*Makefile.in=3;38;2;133;146;137:*MANIFEST.in=3;38;2;131;192;146:*CONTRIBUTORS=1;38;2;219;188;127:*.fdb_latexmk=3;38;2;133;146;137:*appveyor.yml=0;38;2;167;192;128:*.applescript=0;38;2;211;198;170:*configure.ac=3;38;2;131;192;146:*.clang-format=3;38;2;131;192;146:*.gitattributes=3;38;2;131;192;146:*CMakeCache.txt=3;38;2;133;146;137:*LICENSE-APACHE=3;38;2;133;146;137:*CMakeLists.txt=3;38;2;131;192;146:*CONTRIBUTORS.md=1;38;2;219;188;127:*CONTRIBUTORS.txt=1;38;2;219;188;127:*.sconsign.dblite=3;38;2;133;146;137:*requirements.txt=3;38;2;131;192;146:*package-lock.json=3;38;2;133;146;137:*.CFUserTextEncoding=3;38;2;133;146;137'
export LS_COLORS

# SSH Keys
if [[ -z "${SSH_AUTH_SOCK}" ]]; then
  if ! ssh-add -q -L >/dev/null; then
    case $(uname -s) in
      "Darwin")
        ssh-add --apple-load-keychain 2>/dev/null
        ;;
      "Linux")
        if grep -qslR "PRIVATE" "${HOME}/.ssh/"; then
          ssh-add -l >/dev/null || ( grep -slR "PRIVATE" "${HOME}/.ssh/" | xargs ssh-add )
        fi
        ;;
    esac
  fi
fi

# Extras
umask 077

# vim: ft=zsh ts=2 sts=2 sw=2 sr et

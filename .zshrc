export ZSH="$HOME/.oh-my-zsh"
plugins=(git keychain gpg-agent z node npm)

source $ZSH/oh-my-zsh.sh

source $HOMEBREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $HOMEBREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# Stop auto change of directory from zsh
unsetopt AUTO_CD

# Lang exports
export LANG=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# History config
export HISTSIZE=100000                  # Number of history items in memory
export SAVEHIST=100000                  # Number of history items saved to disk
export HISTFILE="$HOME/.zsh_history"    # Path to history file
setopt HIST_IGNORE_ALL_DUPS             # Ignores all duplicate commands
setopt HIST_EXPIRE_DUPS_FIRST           # Expires older duplicates first
setopt HIST_FIND_NO_DUPS                # Avoids saving duplicates
export HISTORY_IGNORE="(ls|cd|clear|z)" # Ignore these commands

# bind ctrl-space to choose zsh autosuggestions
bindkey '^ ' autosuggest-accept

# Add volta to path
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"

# Add mono to the path
export PATH="/Library/Frameworks/Mono.framework/Versions/Current/bin:$PATH"

export PATH="$HOME/code/work/tv4-infrastructure/bin:$PATH"

# Golang
export GOROOT=$(go env GOROOT)
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin
go env -w GOPRIVATE='github.com/TV4\/*'

# OSX specific setup
if [[ "$(uname)" == "Darwin" ]]; then
  export ZSH_DISABLE_COMPFIX=true
fi

# Add bin to path
export PATH="/usr/local/bin:$PATH"
export PATH="$HOME/bin:$PATH"
export PATH="$HOME/.bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"

# Aws region
export AWS_REGION=eu-west-1
export AWS_DEFAULT_REGION=eu-west-1

# Set nvim as default editor
export VISUAL=nvim
export EDITOR="$VISUAL"

# GPG
export GPG_TTY=$(tty)

# Aliases
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
alias vim=nvim
alias vi=nvim
alias gs="git status"
alias tree='tree -I node_modules -a'
alias spotify=spt

THEME="light"

# Toggle light theme
alias light="\
tmux source-file ~/tmux/light-theme; \
tmux set-environment THEME 'light'; \
cp $HOME/.config/ghostty/config.light $HOME/.config/ghostty/config"


# Toggle dark theme
alias dark="\
tmux source-file ~/tmux/dark-theme; \
tmux set-environment THEME 'dark'; \
cp $HOME/.config/ghostty/config.dark $HOME/.config/ghostty/config"

# Make ctrl+r use fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# fzf search with ripgrep
export FZF_DEFAULT_COMMAND="rg --files --hidden -i --ignore-file '~/.rgignore'"
export FZF_CTRL_T_COMMAND=$FZF_DEFAULT_COMMAND

# Helper to detect if we are running tmux
_not_inside_tmux() {
  [[ -z "$TMUX" ]]
}

# I always want TMUX to run
ensure_tmux_is_running() {
  if _not_inside_tmux; then
    tat
  fi
}
ensure_tmux_is_running

# CPP
export PATH="/opt/homebrew/opt/llvm/bin:$PATH"
export SDKROOT=$(xcrun --sdk macosx --show-sdk-path)
export LIBRARY_PATH="$LIBRARY_PATH:$SDKROOT/usr/lib"
cpprun() {
  if [ -z "$1" ]; then
    echo "Usage: cpprun <main_filename.cpp>"
    return 1
  fi

  main_file="$1"
  filename=$(basename "$main_file" .cpp)

  # Find all .cpp files in the current directory and subdirectories
  cpp_files=($(find . -name "*.cpp"))

  # Check if object files already exist (for incremental compilation)
  obj_dir="./build"
  mkdir -p "$obj_dir"

  # Convert .cpp files to .o files in the build directory
  obj_files=()
  for cpp in "${cpp_files[@]}"; do
    obj="${obj_dir}/$(basename "${cpp}" .cpp).o"
    obj_files+=("$obj")

    # Compile only if .o file is missing or .cpp is newer
    if [ ! -f "$obj" ] || [ "$cpp" -nt "$obj" ]; then
      echo "Compiling $cpp..."
      clang++ -std=c++20 -Wall -fno-elide-constructors -c "$cpp" -o "$obj" || return $?
    fi
  done

  # Link all object files into the final binary
  echo "Linking..."
  if clang++ -std=c++20 -Wall "${obj_files[@]}" -o "$filename"; then
    echo "Running $filename..."
    ./"$filename"
    local exit_status=$?

    rm "$filename"

    return $exit_status
  else
    return $?
  fi
}

# enable zmv
autoload zmv
fpath=($fpath "/home/conner/.zfunctions")

# zsh functions
fpath+=${ZDOTDIR:-~}/.zsh_functions

# Set starship ZSH as a prompt
eval "$(starship init zsh)"

# direnv needs to be hooked into the shell to work properly
eval "$(direnv hook $SHELL)"

source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

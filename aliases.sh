DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
export PETERINO_DOTFILES_DIR=${DIR}
alias update_dotfiles="cd $(echo ${PETERINO_DOTFILES_DIR}) && git commit -am 'updating' && git pull && git push"
export PATH="$PATH:${DIR}/scripts"
echo Loading Peterino\'s Dotfiles at  \>\>\> ${DIR}



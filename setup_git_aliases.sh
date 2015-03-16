set -e

set pretty_format = ""

declare -a aliases=( \
  'st status' \
  'di diff' \
  'co checkout' \
  'ci commit' \
  'br branch' \
  'sta stash' \
  'llog \"log --date=local\"' \
  'flog "log --pretty=fuller --decorate"' \
  'lg "log --graph --pretty=format:\"%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset\" --abbrev-commit --date=relative"' \
  'lol "log --graph --decorate --oneline"' \
  'lola "log --graph --decorate --oneline --all"' \
  'blog "log origin/master... --left-right"' \
  'ds "diff --staged"' \
  'fixup "commit --fixup"' \
  'squash "commit --squash"' \
  'unstage "reset HEAD"' \
  'rum "rebase master@{u}"'
)

for alias in "${aliases[@]}"
do
   eval "git config --global alias.$alias"
done

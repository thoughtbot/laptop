defaults write com.apple.Dock autohide 1

dockutil --remove "Launchpad" --no-restart
dockutil --remove "Safari" --no-restart
dockutil --remove "Mail" --no-restart
dockutil --remove "Contacts" --no-restart
dockutil --remove "Calendar" --no-restart
dockutil --remove "Notes" --no-restart
dockutil --remove "Map" --no-restart
dockutil --remove "Facetime" --no-restart
dockutil --remove "iPhoto" --no-restart
dockutil --remove "Pages" --no-restart
dockutil --remove "Numbers" --no-restart
dockutil --remove "Keynote" --no-restart
dockutil --remove "iTunes" --no-restart
dockutil --remove "iBooks" --no-restart

dockutil --add /Applications/Google\ Chrome.app --no-restart
dockutil --add ~/Applications/iTerm.app/ --no-restart
dockutil --add ~/Applications/Slack.app/ --no-restart
dockutil --add ~/Applications/Sublime Text 2.app/ --no-restart
dockutil --add ~/Applications/MacVim.app/ --no-restart
dockutil --add ~/Applications/Screenhero.app/ --no-restart
dockutil --add ~/Applications/SourceTree.app/ --no-restart

/usr/bin/killall -HUP Dock >/dev/null 2>&1

#!/bin/sh

# Some things taken from here
# https://github.com/mathiasbynens/dotfiles/blob/master/.osx

# Set the colours you can use
black='\033[0;30m'
white='\033[0;37m'
red='\033[0;31m'
green='\033[0;32m'
yellow='\033[0;33m'
blue='\033[0;34m'
magenta='\033[0;35m'
cyan='\033[0;36m'


#  Reset text attributes to normal + without clearing screen.
alias Reset="tput sgr0"

# Color-echo.
# arg $1 = message
# arg $2 = Color
cecho() {
  echo "${2}${1}"
  Reset # Reset to normal.
  return
}

# Set continue to false by default
CONTINUE=false

echo ""
cecho "###############################################" $red
cecho "#        DO NOT RUN THIS SCRIPT BLINDLY       #" $red
cecho "#         YOU'LL PROBABLY REGRET IT...        #" $red
cecho "#                                             #" $red
cecho "#              READ IT THOROUGHLY             #" $red
cecho "#         AND EDIT TO SUIT YOUR NEEDS         #" $red
cecho "###############################################" $red
echo ""

echo ""
cecho "Have you read through the script you're about to run and " $red
cecho "understood that it will make changes to your computer? (y/n)" $red
read -r response
case $response in
  [yY]) CONTINUE=true
      break;;
  *) break;;
esac

if ! $CONTINUE; then
  # Check if we're continuing and output a message if not
  cecho "Please go read the script, it only takes a few minutes" $red
  exit
fi

# Here we go.. ask for the administrator password upfront and run a
# keep-alive to update existing `sudo` time stamp until script has finished
sudo -v
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

###############################################################################
# General UI/UX
###############################################################################

echo ""
echo "Would you like to set your computer name (as done via System Preferences >> Sharing)?  (y/n)"
read -r response
case $response in
  [yY])
      echo "What would you like it to be?"
      read COMPUTER_NAME
      sudo scutil --set ComputerName $COMPUTER_NAME
      sudo scutil --set HostName $COMPUTER_NAME
      sudo scutil --set LocalHostName $COMPUTER_NAME
      sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server NetBIOSName -string $COMPUTER_NAME
      break;;
  *) break;;
esac

echo ""
echo "Hide the Time Machine, Volume, User, and Bluetooth icons?  (y/n)"
read -r response
case $response in
  [yY])
      # Get the system Hardware UUID and use it for the next menubar stuff
      for domain in ~/Library/Preferences/ByHost/com.apple.systemuiserver.*; do
          defaults write "${domain}" dontAutoLoad -array \
        "/System/Library/CoreServices/Menu Extras/TimeMachine.menu" \
        "/System/Library/CoreServices/Menu Extras/Volume.menu" \
        "/System/Library/CoreServices/Menu Extras/User.menu"
      done

      defaults write com.apple.systemuiserver menuExtras -array \
        "/System/Library/CoreServices/Menu Extras/Bluetooth.menu" \
        "/System/Library/CoreServices/Menu Extras/AirPort.menu" \
        "/System/Library/CoreServices/Menu Extras/Battery.menu" \
        "/System/Library/CoreServices/Menu Extras/Clock.menu"
      break;;
  *) break;;
esac

echo ""
echo "Hide the Spotlight icon? (y/n)"
read -r response
case $response in
  [yY])
      sudo chmod 600 /System/Library/CoreServices/Search.bundle/Contents/MacOS/Search
      break;;
  *) break;;
esac

echo ""
echo "Increasing the window resize speed for Cocoa applications"
defaults write NSGlobalDomain NSWindowResizeTime -float 0.001

echo ""
echo "Expanding the save panel by default"
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint2 -bool true

echo ""
echo "Automatically quit printer app once the print jobs complete"
defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true

# Try e.g. `cd /tmp; unidecode "\x{0000}" > cc.txt; open -e cc.txt`
echo ""
echo "Displaying ASCII control characters using caret notation in standard text views"
defaults write NSGlobalDomain NSTextShowsControlCharacters -bool true

echo ""
echo "Save to disk, rather than iCloud, by default? (y/n)"
read -r response
case $response in
  [yY])
    defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false
    break;;
  *) break;;
esac

echo ""
echo "Reveal IP address, hostname, OS version, etc. when clicking the clock in the login window"
sudo defaults write /Library/Preferences/com.apple.loginwindow AdminHostInfo HostName

echo ""
echo "Check for software updates daily, not just once per week"
defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1

echo ""
echo "Removing duplicates in the 'Open With' menu"
/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user

echo ""
echo "Disable smart quotes and smart dashes? (y/n)"
read -r response
case $response in
  [yY])
    defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false
    defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false
    break;;
  *) break;;
esac

echo ""
echo "Add ability to toggle between Light and Dark mode in Yosemite using ctrl+opt+cmd+t? (y/n)"
# http://www.reddit.com/r/apple/comments/2jr6s2/1010_i_found_a_way_to_dynamically_switch_between/
read -r response
case $response in
  [yY])
    sudo defaults write /Library/Preferences/.GlobalPreferences.plist _HIEnableThemeSwitchHotKey -bool true
    break;;
  *) break;;
esac


###############################################################################
# General Power and Performance modifications
###############################################################################

echo ""
echo "Disable hibernation? (speeds up entering sleep mode) (y/n)"
read -r response
case $response in
  [yY])
    sudo pmset -a hibernatemode 0
    break;;
  *) break;;
esac

echo ""
echo "Remove the sleep image file to save disk space? (y/n)"
echo "(If you're on a <128GB SSD, this helps but can have adverse affects on performance. You've been warned.)"
read -r response
case $response in
  [yY])
    sudo rm /Private/var/vm/sleepimage
    echo "Creating a zero-byte file instead"
    sudo touch /Private/var/vm/sleepimage
    echo "and make sure it can't be rewritten"
    sudo chflags uchg /Private/var/vm/sleepimage
    break;;
  *) break;;
esac

echo ""
echo "Disable the sudden motion sensor? (it's not useful for SSDs/current MacBooks) (y/n)"
read -r response
case $response in
  [yY])
    sudo pmset -a sms 0
    break;;
  *) break;;
esac

echo ""
echo "Disable system-wide resume? (y/n)"
read -r response
case $response in
  [yY])
    defaults write com.apple.systempreferences NSQuitAlwaysKeepsWindows -bool false
    break;;
  *) break;;
esac

echo ""
echo "Speeding up wake from sleep to 24 hours from an hour"
# http://www.cultofmac.com/221392/quick-hack-speeds-up-retina-macbooks-wake-from-sleep-os-x-tips/
sudo pmset -a standbydelay 86400

echo ""
echo "Disabling the annoying backswipe in Chrome"
defaults write com.google.Chrome AppleEnableSwipeNavigateWithScrolls -bool false


################################################################################
# Trackpad, mouse, keyboard, Bluetooth accessories, and input
###############################################################################

echo ""
echo "Increasing sound quality for Bluetooth headphones/headsets"
defaults write com.apple.BluetoothAudioAgent "Apple Bitpool Min (editable)" -int 40

echo ""
echo "Enabling full keyboard access for all controls (enable Tab in modal dialogs, menu windows, etc.)"
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

echo ""
echo "Disabling press-and-hold for special keys in favor of key repeat"
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false

echo ""
echo "Setting a blazingly fast keyboard repeat rate"
defaults write NSGlobalDomain KeyRepeat -int 0

echo ""
echo "Disable auto-correct? (y/n)"
read -r response
case $response in
  [yY])
    defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false
    break;;
  *) break;;
esac

echo ""
echo "Setting trackpad & mouse speed to a reasonable number"
defaults write -g com.apple.trackpad.scaling 2
defaults write -g com.apple.mouse.scaling 2.5

echo ""
echo "Turn off keyboard illumination when computer is not used for 5 minutes"
defaults write com.apple.BezelServices kDimTime -int 300

echo ""
echo "Disable display from automatically adjusting brightness? (y/n)"
read -r response
case $response in
  [yY])
    sudo defaults write /Library/Preferences/com.apple.iokit.AmbientLightSensor "Automatic Display Enabled" -bool false
    break;;
  *) break;;
esac

echo ""
echo "Disable keyboard from automatically adjusting backlight brightness in low light? (y/n)"
read -r response
case $response in
  [yY])
    sudo defaults write /Library/Preferences/com.apple.iokit.AmbientLightSensor "Automatic Keyboard Enabled" -bool false
    break;;
  *) break;;
esac

###############################################################################
# Screen
###############################################################################

echo ""
echo "Requiring password immediately after sleep or screen saver begins"
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0

echo ""
echo "Where do you want screenshots to be stored? (hit ENTER if you want ~/Desktop as default)"
# Thanks https://github.com/omgmog
read screenshot_location
echo ""
if [ -z "${screenshot_location}" ]
then
  # If nothing specified, we default to ~/Desktop
  screenshot_location="${HOME}/Desktop"
else
  # Otherwise we use input
  if [[ "${screenshot_location:0:1}" != "/" ]]
  then
    # If input doesn't start with /, assume it's relative to home
    screenshot_location="${HOME}/${screenshot_location}"
  fi
fi
echo "Setting location to ${screenshot_location}"
defaults write com.apple.screencapture location -string "${screenshot_location}"

echo ""
echo "What format should screenshots be saved as? (hit ENTER for PNG, options: BMP, GIF, JPG, PDF, TIFF) "
read screenshot_format
if [ -z "$1" ]
then
  echo ""
  echo "Setting screenshot format to PNG"
  defaults write com.apple.screencapture type -string "png"
else
  echo ""
  echo "Setting screenshot format to $screenshot_format"
  defaults write com.apple.screencapture type -string "$screenshot_format"
fi

echo ""
echo "Enabling subpixel font rendering on non-Apple LCDs"
defaults write NSGlobalDomain AppleFontSmoothing -int 2

echo ""
echo "Enabling HiDPI display modes (requires restart)"
sudo defaults write /Library/Preferences/com.apple.windowserver DisplayResolutionEnabled -bool true

###############################################################################
# Finder
###############################################################################

echo ""
echo "Show icons for hard drives, servers, and removable media on the desktop? (y/n)"
case $response in
  [yY])
    defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
    break;;
  *) break;;
esac

echo ""
echo "Show hidden files in Finder by default? (y/n)"
read -r response
case $response in
  [yY])
    defaults write com.apple.Finder AppleShowAllFiles -bool true
    break;;
  *) break;;
esac

echo ""
echo "Show dotfiles in Finder by default? (y/n)"
read -r response
case $response in
  [yY])
    defaults write com.apple.finder AppleShowAllFiles TRUE
    break;;
  *) break;;
esac

echo ""
echo "Show all filename extensions in Finder by default? (y/n)"
read -r response
case $response in
  [yY])
    defaults write NSGlobalDomain AppleShowAllExtensions -bool true
    break;;
  *) break;;
esac

echo ""
echo "Show status bar in Finder by default? (y/n)"
read -r response
case $response in
  [yY])
    defaults write com.apple.finder ShowStatusBar -bool true
    break;;
  *) break;;
esac

echo ""
echo "Display full POSIX path as Finder window title? (y/n)"
read -r response
case $response in
  [yY])
    defaults write com.apple.finder _FXShowPosixPathInTitle -bool true
    break;;
  *) break;;
esac

echo ""
echo "Disable the warning when changing a file extension? (y/n)"
read -r response
case $response in
  [yY])
    defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false
    break;;
  *) break;;
esac

echo ""
echo "Use column view in all Finder windows by default? (y/n)"
read -r response
case $response in
  [yY])
    defaults write com.apple.finder FXPreferredViewStyle Clmv
    break;;
  *) break;;
esac

echo ""
echo "Avoid creation of .DS_Store files on network volumes? (y/n)"
read -r response
case $response in
  [yY])
    defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
    break;;
  *) break;;
esac

echo ""
echo "Disable disk image verification? (y/n)"
read -r response
case $response in
  [yY])
    defaults write com.apple.frameworks.diskimages skip-verify -bool true
    defaults write com.apple.frameworks.diskimages skip-verify-locked -bool true
    defaults write com.apple.frameworks.diskimages skip-verify-remote -bool true
    break;;
  *) break;;
esac

echo ""
echo "Allowing text selection in Quick Look/Preview in Finder by default"
defaults write com.apple.finder QLEnableTextSelection -bool true

echo ""
echo "Enabling snap-to-grid for icons on the desktop and in other icon views"
/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist


###############################################################################
# Dock & Mission Control
###############################################################################

echo "Wipe all (default) app icons from the Dock? (y/n)"
echo "(This is only really useful when setting up a new Mac, or if you don't use the Dock to launch apps.)"
read -r response
case $response in
  [yY])
    defaults write com.apple.dock persistent-apps -array
    break;;
  *) break;;
esac

echo ""
echo "Setting the icon size of Dock items to 36 pixels for optimal size/screen-realestate"
defaults write com.apple.dock tilesize -int 36

echo ""
echo "Speeding up Mission Control animations and grouping windows by application"
defaults write com.apple.dock expose-animation-duration -float 0.1
defaults write com.apple.dock "expose-group-by-app" -bool true

echo ""
echo "Set Dock to auto-hide and remove the auto-hiding delay? (y/n)"
read -r response
case $response in
  [yY])
    defaults write com.apple.dock autohide -bool true
    defaults write com.apple.dock autohide-delay -float 0
    defaults write com.apple.dock autohide-time-modifier -float 0
    break;;
  *) break;;
esac


###############################################################################
# Safari & WebKit
###############################################################################

echo ""
echo "Hiding Safari's bookmarks bar by default"
defaults write com.apple.Safari ShowFavoritesBar -bool false

echo ""
echo "Hiding Safari's sidebar in Top Sites"
defaults write com.apple.Safari ShowSidebarInTopSites -bool false

echo ""
echo "Disabling Safari's thumbnail cache for History and Top Sites"
defaults write com.apple.Safari DebugSnapshotsUpdatePolicy -int 2

echo ""
echo "Enabling Safari's debug menu"
defaults write com.apple.Safari IncludeInternalDebugMenu -bool true

echo ""
echo "Making Safari's search banners default to Contains instead of Starts With"
defaults write com.apple.Safari FindOnPageMatchesWordStartsOnly -bool false

echo ""
echo "Removing useless icons from Safari's bookmarks bar"
defaults write com.apple.Safari ProxiesInBookmarksBar "()"

echo ""
echo "Allow hitting the Backspace key to go to the previous page in history"
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2BackspaceKeyNavigationEnabled -bool true

echo ""
echo "Enabling the Develop menu and the Web Inspector in Safari"
defaults write com.apple.Safari IncludeDevelopMenu -bool true
defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
defaults write com.apple.Safari "com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled" -bool true

echo ""
echo "Adding a context menu item for showing the Web Inspector in web views"
defaults write NSGlobalDomain WebKitDeveloperExtras -bool true


###############################################################################
# Mail
###############################################################################

echo ""
echo "Setting email addresses to copy as 'foo@example.com' instead of 'Foo Bar <foo@example.com>' in Mail.app"
defaults write com.apple.mail AddressesIncludeNameOnPasteboard -bool false


###############################################################################
# Terminal
###############################################################################

echo ""
echo "Enabling UTF-8 ONLY in Terminal.app and setting the Pro theme by default"
defaults write com.apple.terminal StringEncodings -array 4
defaults write com.apple.Terminal "Default Window Settings" -string "Pro"
defaults write com.apple.Terminal "Startup Window Settings" -string "Pro"


###############################################################################
# Time Machine
###############################################################################

echo ""
echo "Prevent Time Machine from prompting to use new hard drives as backup volume? (y/n)"
read -r response
case $response in
  [yY])
    defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true
    break;;
  *) break;;
esac

echo ""
echo "Disable local Time Machine backups? (This can take up a ton of SSD space on <128GB SSDs) (y/n)"
read -r response
case $response in
  [yY])
    hash tmutil &> /dev/null && sudo tmutil disablelocal
    break;;
  *) break;;
esac


###############################################################################
# Messages                                                                    #
###############################################################################

echo ""
echo "Disable automatic emoji substitution in Messages.app? (i.e. use plain text smileys) (y/n)"
read -r response
case $response in
  [yY])
    defaults write com.apple.messageshelper.MessageController SOInputLineSettings -dict-add "automaticEmojiSubstitutionEnablediMessage" -bool false
    break;;
  *) break;;
esac

echo ""
echo "Disable smart quotes in Messages.app? (it's annoying for messages that contain code) (y/n)"
read -r response
case $response in
  [yY])
    defaults write com.apple.messageshelper.MessageController SOInputLineSettings -dict-add "automaticQuoteSubstitutionEnabled" -bool false
    break;;
  *) break;;
esac

echo ""
echo "Disable continuous spell checking in Messages.app? (y/n)"
read -r response
case $response in
  [yY])
    defaults write com.apple.messageshelper.MessageController SOInputLineSettings -dict-add "continuousSpellCheckingEnabled" -bool false
    break;;
  *) break;;
esac


###############################################################################
# Transmission.app                                                            #
###############################################################################


echo ""
echo "Do you use Transmission for torrenting? (y/n)"
read -r response
case $response in
  [yY])
    echo ""
    echo "Use `~/Downloads/Incomplete` to store incomplete downloads"
    defaults write org.m0k.transmission UseIncompleteDownloadFolder -bool true
    mkdir -p ~/Downloads/Incomplete
    defaults write org.m0k.transmission IncompleteDownloadFolder -string "${HOME}/Downloads/Incomplete"

    echo ""
    echo "Don't prompt for confirmation before downloading"
    defaults write org.m0k.transmission DownloadAsk -bool false

    echo ""
    echo "Trash original torrent files"
    defaults write org.m0k.transmission DeleteOriginalTorrent -bool true

    echo ""
    echo "Hide the donate message"
    defaults write org.m0k.transmission WarningDonate -bool false

    echo ""
    echo "Hide the legal disclaimer"
    defaults write org.m0k.transmission WarningLegal -bool false
    break;;
  *) break;;
esac


###############################################################################
# Sublime Text
###############################################################################
echo ""
echo "Do you use Sublime Text 3 as your editor of choice, and is it installed?"
read -r response
case $response in
  [yY])
    # Installing from homebrew cask does the following for you!
    # echo ""
    # echo "Linking Sublime Text for command line usage as subl"
    # ln -s "/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl" /usr/local/bin/subl

    echo ""
    echo "Setting Git to use Sublime Text as default editor"
    git config --global core.editor "subl -n -w"
    break;;
  *) break;;
esac


###############################################################################
# Kill affected applications
###############################################################################

echo ""
cecho "Done!" $cyan
echo ""
echo ""
cecho "################################################################################" $white
echo ""
echo ""
cecho "Note that some of these changes require a logout/restart to take effect." $red
cecho "Killing some open applications in order to take effect." $red
echo ""

find ~/Library/Application\ Support/Dock -name "*.db" -maxdepth 1 -delete
for app in "Activity Monitor" "Address Book" "Calendar" "Contacts" "cfprefsd" \
  "Dock" "Finder" "Mail" "Messages" "Safari" "SystemUIServer" \
  "Terminal" "Transmission"; do
  killall "${app}" > /dev/null 2>&1
done

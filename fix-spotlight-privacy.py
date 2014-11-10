#!/usr/bin/python

from Foundation import NSMutableArray, NSMutableDictionary
from Foundation import CFPreferencesSynchronize, CFPreferencesCopyValue, CFPreferencesCopyKeyList, CFPreferencesSetValue, CFPreferencesCopyMultiple, CFPreferencesSetMultiple, kCFPreferencesCurrentUser, kCFPreferencesAnyHost
import os, sys

# We only handle Yosemite's spotlight for now
majorRelease = int(os.uname()[2].split(".")[0])
if majorRelease < 14:
  print "Good news! This version of Mac OS X's Spotlight and Safari are not known to invade your privacy."
  sys.exit(0)

def fixSpotlight ():
  DISABLED_ITEMS=set(["MENU_WEBSEARCH", "MENU_SPOTLIGHT_SUGGESTIONS"])
  REQUIRED_ITEM_KEYS=set(["enabled", "name"])
  BUNDLE_ID="com.apple.Spotlight"
  PREF_NAME="orderedItems"
  DEFAULT_VALUE=[
    {'enabled' : True, 'name' : 'APPLICATIONS'},
    {'enabled' : False, 'name' : 'MENU_SPOTLIGHT_SUGGESTIONS'},
    {'enabled' : True, 'name' : 'MENU_CONVERSION'},
    {'enabled' : True, 'name' : 'MENU_EXPRESSION'},
    {'enabled' : True, 'name' : 'MENU_DEFINITION'},
    {'enabled' : True, 'name' : 'SYSTEM_PREFS'},
    {'enabled' : True, 'name' : 'DOCUMENTS'},
    {'enabled' : True, 'name' : 'DIRECTORIES'},
    {'enabled' : True, 'name' : 'PRESENTATIONS'},
    {'enabled' : True, 'name' : 'SPREADSHEETS'},
    {'enabled' : True, 'name' : 'PDF'},
    {'enabled' : True, 'name' : 'MESSAGES'},
    {'enabled' : True, 'name' : 'CONTACT'},
    {'enabled' : True, 'name' : 'EVENT_TODO'},
    {'enabled' : True, 'name' : 'IMAGES'},
    {'enabled' : True, 'name' : 'BOOKMARKS'},
    {'enabled' : True, 'name' : 'MUSIC'},
    {'enabled' : True, 'name' : 'MOVIES'},
    {'enabled' : True, 'name' : 'FONTS'},
    {'enabled' : True, 'name' : 'MENU_OTHER'},
    {'enabled' : False, 'name' : 'MENU_WEBSEARCH'}
  ]

  items = CFPreferencesCopyValue(PREF_NAME, BUNDLE_ID, kCFPreferencesCurrentUser, kCFPreferencesAnyHost)
  newItems = None
  if items is None or len(items) is 0:
    # Actual preference values are populated on demand; if the user
    # hasn't previously configured Spotlight, the preference value
    # will be unavailable
    newItems = DEFAULT_VALUE
  else:
    newItems = NSMutableArray.new()
    for item in items:
      missing_keys = []
      for key in REQUIRED_ITEM_KEYS:
        if not item.has_key(key):
          missing_keys.append(key)

      if len(missing_keys) != 0:
        print "Preference item %s is missing expected keys (%s), skipping" % (item, missing_keys)
        newItems.append(item)
        continue

      if item["name"] not in DISABLED_ITEMS:
        newItems.append(item)
        continue

      newItem = NSMutableDictionary.dictionaryWithDictionary_(item)
      newItem.setObject_forKey_(0, "enabled")
      newItems.append(newItem)

  CFPreferencesSetValue(PREF_NAME, newItems, BUNDLE_ID, kCFPreferencesCurrentUser, kCFPreferencesAnyHost)
  CFPreferencesSynchronize(BUNDLE_ID, kCFPreferencesCurrentUser, kCFPreferencesAnyHost)

def fixSafariSpotlight ():
    # Safari "Spotlight" respects the system-wide Spotlight privacy settings
    # EXCEPT when it comes to submitting search metrics to Apple.
    #
    # To disable these metrics, we have to disable Safari's *seperate*
    # "Spotlight Suggestions" setting, in addition to Spotlight's
    # "Spotlight Suggestions".
    #
    # You'll be forgiven if you find this confusing.
    BUNDLE_ID="com.apple.Safari"
    PREF_NAME="UniversalSearchEnabled"
    CFPreferencesSetValue(PREF_NAME, False, BUNDLE_ID, kCFPreferencesCurrentUser, kCFPreferencesAnyHost)
    CFPreferencesSynchronize(BUNDLE_ID, kCFPreferencesCurrentUser, kCFPreferencesAnyHost)

fixSpotlight()
fixSafariSpotlight()
print "All done. Make sure to log out (and back in) for the changes to take effect."

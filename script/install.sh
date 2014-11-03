#!/bin/bash
#
#      ___________
#     /-/_'/-/_/-/|                   B   O   R   G
#    /'-/-_'/-_//||          << https://github.com/agh/borg >>
#   /__________/|/|
#   |'|_'='-]:+|/||   Sit back and relax, human. Resistance is futile.
#   |-+-|.|_'-'||//   This should be a painless process and before long this
#   |['.[:!+-'=|//    system will be a functional part of the collective.
#   |='!+|-:]|-|/
#    ----------
#
#  Author: Alex Howells <alex@howells.me>
#  Copyright (c) 2014, Aeode Ltd <hello@aeode.com>
#  Please see the LICENSE file in the repository root for further information.
#
function bold() {
  bold=`tput bold`
  normal=`tput sgr0`
  echo "${bold}$1${normal}"
}

function notify() {
  echo "==> $1"
}

function subnotify() {
  echo "     $1"
}

cat << __EOF__

$(tput setaf 4)    ___________                                                           
$(tput setaf 4)   /-/_'/-/_/-/| $(tput setaf 1)                  B   O   R   G                            
$(tput setaf 4)  /'-/-_'/-_//|| $(tput setaf 1)         << https://github.com/agh/borg >>                
$(tput setaf 4) /__________/|/| $(tput setaf 2)                                                           
$(tput setaf 4) |'|_'='-]:+|/|| $(tput setaf 2)  Sit back and relax, human. Resistance is futile.         
$(tput setaf 4) |-+-|.|_'-'||// $(tput setaf 2)  This should be a painless process and before long this   
$(tput setaf 4) |['.[:!+-'=|//  $(tput setaf 2)  system will be a functional part of the collective.      
$(tput setaf 4) |='!+|-:]|-|/
$(tput setaf 4)  ----------
$(tput sgr0)
__EOF__

bold "  Ready to get started? We'll have you ready to assimilate in just a tick."
bold "  We need your password so packages that require sudo can be installed."
  
# Ensure that sudo isn't going to prompt for a password in a weird place.
sudo -k && sudo -p "  Password: " -l 2>&1 >/dev/null && echo "" || exit 1

#
# Extend sudo tickets to last for 30 minutes.
#
if [ -f /private/etc/sudoers.borg ]; then
  notify '👍  Looks like sudo is already hot to trot with Borg!'
else
  notify 'Extending the sudo timeout, or installs will error out.'
  sudo cat << __EOF__ | sudo tee -a /private/etc/sudoers >/dev/null 2>&1

# Borg - Facilitates installs without sudo ticket expiring and causing errors.
Defaults        !fqdn,insults,!lecture,timestamp_timeout=30,tty_tickets
__EOF__

  # Making sure we have a ticket good for 30 minutes.
  sudo -v
  sudo touch /private/etc/sudoers.borg
fi

#
# Xcode Command Line Tools
#
if ! /usr/bin/xcode-select -p >/dev/null 2>&1; then
  notify 'Installing the Xcode Command Line Tools. When this completes we shall continue.'
  xcode-select --install
  for i in `seq 1 360`; do
    if ! /usr/bin/xcode-select -p >/dev/null 2>&1; then
      sleep 5
    else
      break
    fi
  done
else
  notify '👍  Found the Xcode Command Line Tools!'
fi

# Sanity check on CLT install completion...
/usr/bin/xcode-select -p >/dev/null 2>&1 || echo "Fatal: Xcode CLT error" && exit 1

#
# ChefDK
#
chefdk_version="0.3.2-1"

(test -x /opt/chefdk/bin/chef-solo && 
  (/opt/chefdk/bin/chef --version | grep 0.3.2 2>&1 >/dev/null &&
    (notify "👍  Found the Chef Development Kit!"))) || {

    # If we got this far, then we need to install or upgrade ChefDK.
    notify "Installing the Chef Development Kit (${chefdk_version})"

    # This naively assumes we are running on OSX.
    platform="mac_os_x"
    release="10.8"

    # Perform the download.
    fname="chefdk-${chefdk_version}.dmg"
    url="https://opscode-omnibus-packages.s3.amazonaws.com/$platform/$release/x86_64/$fname"
    subnotify "Downloading ${url}..."
    cd /tmp && curl -L -O $url

    # Perform the install
    test "$platform" = "mac_os_x" && {
      hdiutil attach /tmp/$fname 2>&1 >/dev/null && echo "mounted"
      sudo installer -package "/Volumes/Chef Development Kit/chefdk-${chefdk_version}.pkg" -target /
      hdiutil detach "/Volumes/Chef Development Kit" 2>&1 >/dev/null && rm /tmp/$fname
    }
}

#
# Homebrew
#
if [ ! -d /usr/local/.git ]; then
  notify "🚄  Doesn't look like you have Homebrew. I'll clone that down for you!"
  sudo rm -rf /usr/local
  sudo git clone https://github.com/mxcl/homebrew /usr/local
else
  notify "👍  Looks like you already have Homebrew installed!"
fi

if [ ! -d /opt/homebrew-cask ]; then
  notify "👎  I can't find the necessary directories for Homebrew. Gonna help you create them."
  sudo mkdir -p /Library/Caches/Homebrew /opt/homebrew-cask
else
  notify "👍  Looks like all the extra directories for Homebrew exist!"
fi

if [ $(stat -f "%Su" /usr/local) != "$USER" ]; then
  notify "😠  Permissions on /usr/local look wrong. Gonna help you fix that."
  sudo chown -R $USER:admin /usr/local /Library/Caches/Homebrew /opt/homebrew-cask
  sudo chmod 775 /usr/local /Library/Caches/Homebrew /opt/homebrew-cask
else
  notify "👍  Permissions on necessary directories all look good!"
fi

#
# Borg
#
if [ ! -d $HOME/.borg ]; then
  notify "👎  Looks like we need to clone the rest of Borg. I'll do that now!"
 
  BORG_ROOT="${HOME}/.borg"

  # Let's make some directories to get the basics installed.
  BORG_DIRECTORIES="logs src"
  for directory in $BORG_DIRECTORIES; do
    mkdir -p $BORG_ROOT/$directory
  done

  # Pull down source from GitHub for the first time.
  git clone https://github.com/agh/borg $BORG_ROOT/src
else
  notify "👍  I've found Borg and thus you can 'borg update' to get newer code."
fi

# Symlinks so that stuff appears in PATH.
BORG_TOOLS="borg"
for tool in $BORG_TOOLS; do
  if [ ! -f /usr/local/bin/$tool ]; then
    ln $BORG_ROOT/src/script/$tool /usr/local/bin/$tool
  fi
done

#
# Validation
# Also known as 'checks and balances', or making sure everything worked!
#
type chef-solo >/dev/null 2>&1 || {
  echo >&2 "Expected to find chef-solo but it is missing. Bummer!"
  exit 1
}

type berks >/dev/null 2>&1 || {
  echo >&2 "Expected to find Berkshelf but it is missing. Bummer!"
  exit 1
}

if [ $(stat -f "%Su" /usr/local) != "$USER" ]; then
  echo >&2 "Expected your user to own /usr/local, and you need to fix this!"
  exit 1
fi

if [ ! -d /opt/homebrew-cask ] || [ $(stat -f "%Su" /opt/homebrew-cask) != "$USER" ]; then
  echo >&2 "Expected your user to own /opt/homebrew-cask, and you need to fix this!"
  exit 1
fi

type borg >/dev/null 2>&1 || {
  echo >&2 "Expected to find Borg but it is missing. Bummer!"
  exit 1
}

cat << __EOF__

   $(bold "System is now prepared for assimilation. Type 'borg help' for info.")

__EOF__

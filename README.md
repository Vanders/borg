# borg

![cube](http://f.cl.ly/items/1U1z2f0J060L0Q2v111h/borg-cube-angled.jpg)

I've always found it a ginormous pain to get an OSX system configured
_"just right"_ in any **reasonable** amount of time, or to keep multiple systems
vaguely in sync in terms of the software and settings.

I'd guess this is a pain I feel a couple of times a year on average. It sucks.

Manual steps and checklists are okay, and Borg automates as much as sensible.
Everything involved in setting up my systems is over in [agh/setup](https://github.com/agh/setup)
and that includes pointy-clicky actions taken in Mac App Store, et al.

Where possible settings are parameterized, so you can use this too without :rage3:
and Borg is chef-solo so it has few external dependencies. No need for Chef Server.

The intent is that Borg should run as your user (e.g. `agh`) and that it will
elevate privileges with sudo :muscle: as required to install packages, etc.
Something like 95% of the lifting is done by Chef, the remaining 5% is Bash,
which maintains XCode Command Line Tools, Homebrew, et al.

None of the fancy :zap: features in Bash 4.x can be used until Apple ships that.
No warranty is supplied. If you try to run this on Ruby 1.9 (or earlier) or on
anything before OSX 10.10 ('Yosemite') then your results **will** vary. Sorry.
Perhaps you should give consideration to upgrading?

## Prerequisites

  * Install OSX 'Yosemite' (10.10) from scratch onto your system.
  * Be the only user of that system. This takes over /usr/local and other places.

## Install

  * `curl -L https://raw.github.com/agh/borg/master/script/install.sh | bash`

## Operation

  * `borg assimilate`

## What Does it Do?

In essence the convergence is broken down into three phases:

  * 'Update Phase' - Pulling down the latest hotness from GitHub.
  * 'Injection Phase' - Making sure all the prerequisites are satisfied like Homebrew.
  * 'Assimilation Phase' - Running chef-solo to actually personalize your system.





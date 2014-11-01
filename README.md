# borg

![cube](http://f.cl.ly/items/1U1z2f0J060L0Q2v111h/borg-cube-angled.jpg)

I've always found it a ginormous pain to get an OSX system configured
_"just right"_ in any *reasonable* amount of time, or to keep multiple systems
vaguely in sync in terms of the software and settings deployed on them.

I'd guess this is a pain I feel a couple of times a year on average. It sucks.
It's like the difference between sleeping in your own bed, or a :hotel: bed,
you just feel :tired_face: using the system if it isn't built right.

The goal is thus: Build a system from scratch to >99% done in <60 minutes.
Manual steps and checklists are okay, because Apple doesn't make it easy
to access the App Store from the CLI, but automate as much as sensible.
Anything I have to do manually will be documented in [agh/setup](https://github.com/agh/setup).

Where possible settings are parameterized, so you can use this too without :rage3:,
and Borg is chef-solo so it should be fast to get going. No need for Chef Server.

The intent is that Borg should run as your user (e.g. `agh`) and that it will
elevate privileges :muscle: with sudo as required to install packages, etc.
Something like 95% of the lifting is done by Chef, the remaining 5% is Bash,
which maintains XCode Command Line Tools, Homebrew, et al.

None of the fancy :zap: features in Bash 4.x can be used until Apple ships that.
No warranty is supplied generally, but if you try to run this on Ruby 1.9 
(or earlier) since OSX 10.10 ('Yosemite') now ships Ruby 2.0.0-p481,
then you are *especially* unsupported :fire: (and slightly crazy - upgrade!).

## Prerequisites

  * Install OSX 'Yosemite' (10.10) from scratch onto your system.

## Install

  * `curl -L https://raw.github.com/agh/borg/master/script/install | bash`

## Operation

  * `borg assimilate`

## What Does it Do?

In essence the convergence is broken down into three phases:

  * 'Update Phase' - Pulling down the latest hotness from GitHub.
  * 'Injection Phase' - Making sure all the prerequisites are satisfied like Homebrew.
  * 'Assimilation Phase' - Running chef-solo to actually personalize your system.





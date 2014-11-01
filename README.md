# borg

![cube](http://f.cl.ly/items/1U1z2f0J060L0Q2v111h/borg-cube-angled.jpg)

I've always found it a ginormous pain to get an OSX system configured
"just right" in any reasonable amount of time, or to keep multiple systems
vaguely in sync in terms of the software and settings deployed on them.

I'd guess this is a pain I feel a couple of times a year on average. It sucks.
It's like the difference between sleeping in your own bed, or a :hotel: bed,
you just feel :tired_face: using the system if it isn't built right.

What follows with Borg is (generally) how I like my systems configured.
It tries not to hardcode anything important, but out of the box, you may :rage3:.
The intent is that Borg runs as your user (e.g. `agh`) and will elevate
privileges as needed to install packages. :muscle:

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





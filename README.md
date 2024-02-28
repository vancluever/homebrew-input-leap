# Unofficial tap for Input Leap

> [!WARNING]
> This formula is currently not intended to be run on Linux and will likely
> error out!

This is an unofficial tap for [Input
Leap](https://github.com/input-leap/input-leap), a fork of the
[Barrier](https://github.com/debauchee/barrier) project from its active
maintainers. Barrier is, in turn, a fork of the old
[Synergy](https://github.com/symless/synergy-core) project after it went closed
source. It allows you to do keyboard/mouse sharing across multiple computers
without the need for a KVM or USB switch.

As the Input Leap maintainers have been busy working on modernizing the
codebase, more and more folks seem to be looking for various ways to install it
ahead of an official re-release. Packaging is available on the AUR (see
[input-leap-git](https://aur.archlinux.org/packages/input-leap-git) and
[input-leap-headless-git](https://aur.archlinux.org/packages/input-leap-headless-git)),
but seemingly not much else.

This is an AUR-like tap that will allow you to build and run the Input Leap
application on MacOS.

## External Requirements

* MacOS Sierra minimum.
* You have to have [XCode](https://developer.apple.com/xcode/) installed (not
  just the command-line tools. Homebrew will also remind you of this). 

All other dependencies are handled by Homebrew itself in the formula.

## Installing

Run `brew tap vancluever/input-leap` and then `brew install input-leap`.

## Caveats

Make sure to heed the caveats when you install, notably the app location and the
accessibility permission oddities. As this is not a cask, we can't automatically
install this to `/Applications`.

```
You will need to access the InputLeap.app directly from:
  #{opt_prefix}/InputLeap.app

Run this at least once to properly register accessibility
permissions before using the CLI tools.

If your run into an accessibility permissions loop, try
running:
  tccutil reset Accessibility input-leap

This will reset your accessibility permissions; running the app
again should then correctly grant it.

The command-line binaries input-leapc (client) and input-leaps
(server) have been linked and should be available from your
PATH.

Man pages have also been installed, and you will be able to find
config file examples in:
  #{HOMEBREW_PREFIX}/share/doc/input-leap
```

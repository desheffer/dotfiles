# dotfiles

These are my personal dotfiles for various Unix utilities.  If you find these
files useful, then you are free to use them however you see fit.

## Installation

Run `bootstrap.sh` to link the files into your home directory.

To install tmux plugins, run tmux and press <kbd>Ctrl</kbd>-<kbd>a</kbd> +
<kbd>I</kbd>.

To use special symbols, download and install one of the patched [Nerd
Fonts](https://github.com/ryanoasis/nerd-fonts) for your terminal.

## Sharing a clipboard over SSH

The following steps allow you to create a remote version of the `pbcopy`
utility.  These instructions assume that your local machine is a Mac.  Replace
`1234` with a port of your choice.

### On your local machine

Create `~/Library/LaunchAgents/pbcopy.plist` with the following content:

```
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple Computer//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
     <key>Label</key>
     <string>pbcopy</string>
     <key>ProgramArguments</key>
     <array>
         <string>/usr/bin/pbcopy</string>
     </array>
     <key>inetdCompatibility</key>
     <dict>
          <key>Wait</key>
          <false/>
     </dict>
     <key>Sockets</key>
     <dict>
          <key>Listeners</key>
          <dict>
              <key>SockServiceName</key>
              <string>1234</string>
              <key>SockNodeName</key>
              <string>127.0.0.1</string>
          </dict>
     </dict>
</dict>
</plist>
```

Run `launchctl load ~/Library/LaunchAgents/pbcopy.plist` to start the listener.

Add `RemoteForward 1234 127.0.0.1:1234` to your `~/.ssh/config`.

### On the remote machine

Create `~/bin/pbcopy` with the following content:

```
#!/bin/bash

cat | nc localhost 1234
```

You can now copy text using the `pbcopy` command on the remote machine.  For
example, you can copy a file (`cat myfile | pbcopy`) or part of a file (using
<kbd>g</kbd><kbd>y</kbd> on a block of text in Vim).  In either case, the text
will be copied to the clipboard on your local machine.

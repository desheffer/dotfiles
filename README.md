# dotfiles

                            |
                        \       /
                          .-"-.
                     --  /     \  --
    `~~^~^~^~^~^~^~^~^~^-=======-~^~^~^~~^~^~^~^~^~^~^~`
    `~^_~^~^~-~^_~^~^_~-=========- -~^~^~^-~^~^_~^~^~^~`
    `~^~-~~^~^~-^~^_~^~~ -=====- ~^~^~-~^~_~^~^~~^~-~^~`
    `~^~^~-~^~~^~-~^~~-~^~^~-~^~~^-~^~^~^-~^~^~^~^~~^~-`

That's a sunset, and these are my personal dotfiles for various Unix utilities.
On the off chance you find any of these files useful, you are free to use them
however you see fit.

## Installation

1. Run <code>bootstrap.sh</code> to link the files into your home directory.

2. https://www.youtube.com/watch?v=QX5XKFn7Ngo

3. ???

4. Et voilà!

## Sharing a clipboard over SSH

The following steps allow you to create a remote version of the `pbcopy`
utility.  Please note this assumes that your local machine is a Mac.

First, on your local machine:

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
              <string>2224</string>
              <key>SockNodeName</key>
              <string>127.0.0.1</string>
          </dict>
     </dict>
</dict>
</plist>
```

Run `launchctl load ~/Library/LaunchAgents/pbcopy.plist` to start the listener.

Add `RemoteForward 2224 127.0.0.1:2224` to your `~/.ssh/config`.

Next, on the remote machine:

Now you can pipe text into `nc localhost 2224` and it will be copied to the
clipboard on your local machine.  To make this easier, you can use the
following script:

```
#!/bin/bash

cat | nc localhost 2224
```

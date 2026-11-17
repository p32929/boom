# Boom

Boom is a tiny macOS menu bar app that force quits all your open apps in one click. When several apps freeze, or you just want a clean slate, you don't have to quit them one by one or wait for each "not responding" window. Click once and they are gone, while Finder, the Dock and the rest of macOS keep running.

<img width="199" height="210" alt="Boom menu" src="https://github.com/user-attachments/assets/21b1ddc5-c788-4ccb-984b-927f51b7d149" />

## Features

1. **Force Close All:** force quits every app you opened, in one click.
2. **Force Shut Down:** closes every app and then shuts down your Mac.
3. **Safe for your Mac:** it never closes Finder, the Dock, the menu bar, Control Center, Notification Center, background helpers or itself.
4. **Launch at Login:** start Boom by itself when you log in, if you want.
5. **Stays out of the way:** it lives only in the menu bar, with no Dock icon, and only one copy can run at a time.

## Download

Download `Boom-1.2.zip` from the [releases page](https://github.com/p32929/boom/releases/latest), unzip it and move Boom to your Applications folder. It needs macOS 13 or newer.

## How to use it

1. Open Boom. A bolt icon appears in the menu bar.
2. Click the icon and pick one:
   1. **Force Close All** closes all your apps right away.
   2. **Force Shut Down** closes all your apps and shuts down the Mac.
   3. **Launch at Login** turns auto-start on or off (a tick means on).
   4. **About** shows the app info.
   5. **Exit** quits Boom.

## Good to know

1. Force quitting does not ask to save, so unsaved work in those apps is lost. Save first.
2. macOS may ask you to allow Boom to control other apps. You can allow it in **System Settings**, **Privacy & Security**, **Automation**.
3. **Launch at Login** works best when Boom is in your Applications folder.

## How it works

1. It lists the open apps with `NSWorkspace.shared.runningApplications` and keeps only normal apps with windows.
2. It closes them with `NSRunningApplication.forceTerminate()`.
3. **Force Shut Down** asks macOS to shut down through AppleScript.

## Build it yourself

You need Xcode 15 or newer.

```bash
git clone https://github.com/p32929/boom.git
cd boom
open boom.xcodeproj
```

Pick your Mac as the target and press `Cmd + R`. To make an app you can keep, use **Product**, then **Archive**, export it and move it to Applications.

## License

MIT License. Copyright (c) 2026 Fayaz Bin Salam. See [LICENSE](LICENSE) for the full text.

## Contributing

Contributions are very welcome. Please open an issue first to talk about what you'd like to add or change, so we can agree on it before you spend time on a pull request. Thank you!

<p><a href="https://p32929.github.io/share/?repo=boom"><picture><source media="(prefers-color-scheme: dark)" srcset="https://p32929.github.io/readme/footer-share-dark.svg"><img src="https://p32929.github.io/readme/footer-share-light.svg" width="50%" align="top" alt="Share this project with your friends in one click"></picture></a><a href="https://p32929.github.io/support/"><picture><source media="(prefers-color-scheme: dark)" srcset="https://p32929.github.io/readme/footer-support-dark.svg"><img src="https://p32929.github.io/readme/footer-support-light.svg" width="50%" align="top" alt="If you like my work and want to support me, feel free to support"></picture></a><br><a href="https://openstore.pfay.workers.dev/add"><picture><source media="(prefers-color-scheme: dark)" srcset="https://p32929.github.io/readme/footer-join-dark.svg"><img src="https://p32929.github.io/readme/footer-join-light.svg" width="100%" align="top" alt="Put your own apps on OpenStore: free, your listing lives in your own repo"></picture></a></p>

# Boom

A lightweight macOS menu bar utility that lets you force quit all running apps with a single click.

## Why "Boom"?

Because sometimes you just need everything to go **boom** and disappear. No more clicking through frozen apps one by one. No more waiting for unresponsive windows to close. Just one click, and *boom* — everything's gone.

## Screenshot

<img width="199" height="210" alt="Image" src="https://github.com/user-attachments/assets/21b1ddc5-c788-4ccb-984b-927f51b7d149" />

## Features

- **Force Close All** — Instantly force quits all user applications (excludes essential system apps like Finder and Dock)
- **Force Shut Down** — Force closes all apps and shuts down your Mac in one action
- **Launch at Login** — Optionally start Boom automatically when you log in
- **About** — View app info with links to the developer's profile and source code
- **Lightweight** — Lives quietly in your menu bar, no dock icon, minimal resource usage
- **Single Instance** — Prevents multiple instances from running simultaneously

## How It Works

Boom uses macOS native APIs to:

1. **Enumerate running applications** via `NSWorkspace.shared.runningApplications`
2. **Force terminate** apps using `NSRunningApplication.forceTerminate()`
3. **Trigger shutdown** via AppleScript when using Force Shut Down

### What gets closed?

Boom only force quits **regular user applications** (apps with visible windows). It intentionally excludes:

- Finder
- Dock
- System UI Server
- Window Manager
- Control Center
- Notification Center
- Background agents and daemons
- Itself

This ensures your system remains stable while clearing out all your user apps.

## Requirements

- macOS 13.0 or later
- Xcode 15.0 or later (for building)

## Installation

### Download

Download the latest release from the [Releases](https://github.com/p32929/boom/releases) page.

### Build from Source

1. Clone the repository:
   ```bash
   git clone https://github.com/p32929/boom.git
   cd boom
   ```

2. Open the project in Xcode:
   ```bash
   open boom.xcodeproj
   ```

3. Build and run:
   - Select your Mac as the target device
   - Press `Cmd + R` to build and run

4. (Optional) Archive for distribution:
   - Go to **Product → Archive**
   - Export the app and move it to `/Applications`

### Important Notes

- **Launch at Login** works best when the app is run from a permanent location (e.g., `/Applications`)
- The app requires permission to control other applications. You may need to grant permissions in **System Settings → Privacy & Security → Automation**

## Usage

1. Launch Boom — a bolt icon appears in your menu bar
2. Click the icon to see options:
   - **Force Close All** — Closes all user apps immediately
   - **Force Shut Down** — Closes all apps and shuts down your Mac
   - **Launch at Login** — Toggle auto-start (checkmark indicates enabled)
   - **About** — View app information
   - **Exit** — Quit Boom

## Contributing

Contributions are warmly welcomed and greatly appreciated! Whether it's a bug fix, new feature, or improvement, your input helps make this project better for everyone.

Before submitting a pull request, please:

1. Create an issue describing the feature or bug fix you'd like to work on
2. Wait for discussion and approval to ensure alignment with project goals
3. Fork the repository and create your feature branch
4. Submit your pull request with a clear description of changes

This approach helps avoid duplicate efforts and ensures smooth collaboration. Thank you for considering contributing!

### Ideas for Contributions

- Custom keyboard shortcuts
- Confirmation dialog option before force closing
- Exclude specific apps from force close
- Menu bar icon customization
- Localization support

## Feedback

Have feedback, suggestions, or found a bug? Feel free to:

- [Open an issue](https://github.com/p32929/boom/issues)
- Reach out via [GitHub](https://github.com/p32929)

All feedback is appreciated!

## License

MIT License — see [LICENSE](LICENSE) for the full text.

## Author

**p32929**

- GitHub: [github.com/p32929](https://github.com/p32929)
- Portfolio: [p32929.github.io](https://p32929.github.io)

## Share

Sharing this repository with your friends is just one click away from here

[![facebook](https://user-images.githubusercontent.com/6418354/179013321-ac1d1452-0689-493f-9066-940cf2302b6e.png)](https://www.facebook.com/sharer/sharer.php?u=https://github.com/p32929/boom/)
[![twitter](https://user-images.githubusercontent.com/6418354/179013351-7d8d6d1c-4ce2-46ab-bef8-4c4765a1b888.png)](https://twitter.com/intent/tweet?url=https://github.com/p32929/boom/)
[![tumblr](https://user-images.githubusercontent.com/6418354/179013343-3111f55a-3b90-40c7-8487-9777348672b0.png)](https://www.tumblr.com/share?v=3&u=https://github.com/p32929/boom/)
[![pocket](https://user-images.githubusercontent.com/6418354/179013334-b095c45f-becf-49f4-9ee1-5a731a9b1f85.png)](https://getpocket.com/save?url=https://github.com/p32929/boom/)
[![pinterest](https://user-images.githubusercontent.com/6418354/179013331-44cd9206-11b1-4b65-becb-5863b61c828f.png)](https://pinterest.com/pin/create/button/?url=https://github.com/p32929/boom/)
[![reddit](https://user-images.githubusercontent.com/6418354/179013338-7416ae3f-73ba-4522-86e1-1374d7082d22.png)](https://www.reddit.com/submit?url=https://github.com/p32929/boom/)
[![linkedin](https://user-images.githubusercontent.com/6418354/179013327-ca7b7102-1da8-4b1c-858f-1a6e5f21bd70.png)](https://www.linkedin.com/shareArticle?mini=true&url=https://github.com/p32929/boom/)
[![whatsapp](https://user-images.githubusercontent.com/6418354/179013353-f477fa0b-3e6f-4138-a357-c9991b23ff88.png)](https://api.whatsapp.com/send?text=https://github.com/p32929/boom/)

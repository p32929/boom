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

Contributions are welcome! Here's how you can help:

1. **Fork** the repository
2. **Create** a feature branch:
   ```bash
   git checkout -b feature/amazing-feature
   ```
3. **Commit** your changes:
   ```bash
   git commit -m "Add amazing feature"
   ```
4. **Push** to the branch:
   ```bash
   git push origin feature/amazing-feature
   ```
5. **Open** a Pull Request

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

This project is open source. Feel free to use, modify, and distribute.

## Author

**p32929**

- GitHub: [github.com/p32929](https://github.com/p32929)
- Portfolio: [p32929.github.io](https://p32929.github.io)


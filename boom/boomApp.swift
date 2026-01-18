//
//  boomApp.swift
//  boom
//
//  Created by mac on 18/01/2026.
//

import SwiftUI
import AppKit
import ServiceManagement

@main
struct boomApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        Settings {
            EmptyView()
        }
    }
}

class AppDelegate: NSObject, NSApplicationDelegate {
    private var statusItem: NSStatusItem?
    private var aboutWindow: NSWindow?
    private var launchAtLoginItem: NSMenuItem?

    func applicationDidFinishLaunching(_ notification: Notification) {
        // Prevent multiple instances
        if isAlreadyRunning() {
            NSApp.terminate(nil)
            return
        }

        setupMenuBar()

        // Hide dock icon since this is a menu bar only app
        NSApp.setActivationPolicy(.accessory)
    }

    private func isAlreadyRunning() -> Bool {
        let currentPID = ProcessInfo.processInfo.processIdentifier
        guard let bundleID = Bundle.main.bundleIdentifier else { return false }

        let runningApps = NSWorkspace.shared.runningApplications.filter {
            $0.bundleIdentifier == bundleID
        }

        // If more than one instance with same bundle ID, we're a duplicate
        return runningApps.count > 1 || runningApps.first?.processIdentifier != currentPID
    }

    private func setupMenuBar() {
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)

        if let button = statusItem?.button {
            button.image = NSImage(systemSymbolName: "bolt.circle.fill", accessibilityDescription: "Boom")
        }

        let menu = NSMenu()

        // Force Close All
        let forceCloseItem = NSMenuItem(
            title: "Force Close All",
            action: #selector(forceCloseAll),
            keyEquivalent: ""
        )
        forceCloseItem.target = self
        menu.addItem(forceCloseItem)

        // Force Shut Down
        let forceShutDownItem = NSMenuItem(
            title: "Force Shut Down",
            action: #selector(forceShutDown),
            keyEquivalent: ""
        )
        forceShutDownItem.target = self
        menu.addItem(forceShutDownItem)

        menu.addItem(NSMenuItem.separator())

        // Launch at Login
        launchAtLoginItem = NSMenuItem(
            title: "Launch at Login",
            action: #selector(toggleLaunchAtLogin),
            keyEquivalent: ""
        )
        launchAtLoginItem?.target = self
        updateLaunchAtLoginState()
        menu.addItem(launchAtLoginItem!)

        menu.addItem(NSMenuItem.separator())

        // About
        let aboutItem = NSMenuItem(
            title: "About",
            action: #selector(showAbout),
            keyEquivalent: ""
        )
        aboutItem.target = self
        menu.addItem(aboutItem)

        menu.addItem(NSMenuItem.separator())

        // Exit
        let exitItem = NSMenuItem(
            title: "Exit",
            action: #selector(exitApp),
            keyEquivalent: "q"
        )
        exitItem.target = self
        menu.addItem(exitItem)

        statusItem?.menu = menu
    }

    @objc private func toggleLaunchAtLogin() {
        do {
            if SMAppService.mainApp.status == .enabled {
                try SMAppService.mainApp.unregister()
            } else {
                try SMAppService.mainApp.register()
            }
        } catch {
            print("Failed to toggle launch at login: \(error)")
        }
        updateLaunchAtLoginState()
    }

    private func updateLaunchAtLoginState() {
        launchAtLoginItem?.state = SMAppService.mainApp.status == .enabled ? .on : .off
    }

    @objc private func forceCloseAll() {
        let runningApps = NSWorkspace.shared.runningApplications

        // Get the bundle identifier of this app to exclude it
        let myBundleID = Bundle.main.bundleIdentifier

        // System apps and processes to exclude
        let excludedBundleIDs: Set<String> = [
            "com.apple.finder",
            "com.apple.dock",
            "com.apple.SystemUIServer",
            "com.apple.WindowManager",
            "com.apple.controlcenter",
            "com.apple.notificationcenterui"
        ]

        for app in runningApps {
            // Skip this app
            if let bundleID = app.bundleIdentifier, bundleID == myBundleID {
                continue
            }

            // Skip system apps
            if let bundleID = app.bundleIdentifier, excludedBundleIDs.contains(bundleID) {
                continue
            }

            // Only force quit regular apps (not background agents)
            if app.activationPolicy == .regular {
                app.forceTerminate()
            }
        }
    }

    @objc private func forceShutDown() {
        // First, force close all apps
        forceCloseAll()

        // Clear saved application state to prevent apps from reopening
        let savedStateDir = FileManager.default.homeDirectoryForCurrentUser
            .appendingPathComponent("Library/Saved Application State")
        try? FileManager.default.removeItem(at: savedStateDir)

        // Shut down the Mac
        let script = NSAppleScript(source: "tell application \"System Events\" to shut down")
        script?.executeAndReturnError(nil)
    }

    @objc private func showAbout() {
        if aboutWindow == nil {
            aboutWindow = createAboutWindow()
        }

        aboutWindow?.makeKeyAndOrderFront(nil)
        NSApp.activate(ignoringOtherApps: true)
    }

    private func createAboutWindow() -> NSWindow {
        let window = NSWindow(
            contentRect: NSRect(x: 0, y: 0, width: 300, height: 200),
            styleMask: [.titled, .closable],
            backing: .buffered,
            defer: false
        )
        window.title = "About Boom"
        window.center()
        window.isReleasedWhenClosed = false

        let contentView = NSView(frame: window.contentView!.bounds)

        // App name
        let titleLabel = NSTextField(labelWithString: "Boom")
        titleLabel.font = NSFont.boldSystemFont(ofSize: 24)
        titleLabel.alignment = .center
        titleLabel.frame = NSRect(x: 0, y: 150, width: 300, height: 30)
        contentView.addSubview(titleLabel)

        // Version
        let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "1.0"
        let build = Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? "1"
        let versionLabel = NSTextField(labelWithString: "Version \(version) (\(build))")
        versionLabel.font = NSFont.systemFont(ofSize: 11)
        versionLabel.textColor = .secondaryLabelColor
        versionLabel.alignment = .center
        versionLabel.frame = NSRect(x: 0, y: 130, width: 300, height: 16)
        contentView.addSubview(versionLabel)

        // Tagline
        let taglineLabel = NSTextField(labelWithString: "Force quit all apps with one click")
        taglineLabel.font = NSFont.systemFont(ofSize: 12)
        taglineLabel.textColor = .secondaryLabelColor
        taglineLabel.alignment = .center
        taglineLabel.frame = NSRect(x: 0, y: 105, width: 300, height: 20)
        contentView.addSubview(taglineLabel)

        // Developer link
        let developerButton = createLinkButton(
            title: "Developer: p32929",
            url: "https://github.com/p32929",
            frame: NSRect(x: 50, y: 75, width: 200, height: 20)
        )
        contentView.addSubview(developerButton)

        // Portfolio link
        let portfolioButton = createLinkButton(
            title: "Portfolio: p32929.github.io",
            url: "https://p32929.github.io",
            frame: NSRect(x: 50, y: 50, width: 200, height: 20)
        )
        contentView.addSubview(portfolioButton)

        // Source code link
        let sourceButton = createLinkButton(
            title: "Source Code",
            url: "https://github.com/p32929/boom",
            frame: NSRect(x: 50, y: 25, width: 200, height: 20)
        )
        contentView.addSubview(sourceButton)

        window.contentView = contentView
        return window
    }

    private func createLinkButton(title: String, url: String, frame: NSRect) -> NSButton {
        let button = NSButton(frame: frame)
        button.title = title
        button.bezelStyle = .inline
        button.isBordered = false
        button.contentTintColor = .linkColor

        let attributes: [NSAttributedString.Key: Any] = [
            .underlineStyle: NSUnderlineStyle.single.rawValue,
            .foregroundColor: NSColor.linkColor,
            .font: NSFont.systemFont(ofSize: 13)
        ]
        button.attributedTitle = NSAttributedString(string: title, attributes: attributes)

        button.target = self
        button.action = #selector(openLink(_:))
        button.toolTip = url

        return button
    }

    @objc private func openLink(_ sender: NSButton) {
        if let urlString = sender.toolTip, let url = URL(string: urlString) {
            NSWorkspace.shared.open(url)
        }
    }

    @objc private func exitApp() {
        NSApp.terminate(nil)
    }
}

//
//  AppIcons.swift
//  boringNotch
//
//  Created by Harsh Vardhan  Goswami  on 16/08/24.
//

import SwiftUI
import AppKit

struct AppIcons {
    
    func getIcon(file path: String) -> NSImage? {
        guard FileManager.default.fileExists(atPath: path)
        else { return nil }
        
        return NSWorkspace.shared.icon(forFile: path)
    }
    
    func getIcon(bundleID: String) -> NSImage? {
        guard let path = NSWorkspace.shared.urlForApplication(
            withBundleIdentifier: bundleID
        )?.absoluteString
        else { return nil }
        
        return getIcon(file: path)
    }
    
        /// Easily read Info.plist as a Dictionary from any bundle by accessing .infoDictionary on Bundle
    func bundle(forBundleID: String) -> Bundle? {
        guard let url = NSWorkspace.shared.urlForApplication(withBundleIdentifier: forBundleID)
        else { return nil }
        
        return Bundle(url: url)
    }
    
}

func AppIcon(for bundleID: String) -> Image {
    let workspace = NSWorkspace.shared
    
    if let appURL = workspace.urlForApplication(withBundleIdentifier: bundleID) {
        let appIcon = workspace.icon(forFile: appURL.path)
        return Image(nsImage: appIcon)
    }
    
    return Image(nsImage: workspace.icon(for: .applicationBundle))
}


func AppIconAsNSImage(for bundleID: String) -> NSImage? {
    let workspace = NSWorkspace.shared
    
    if let appURL = workspace.urlForApplication(withBundleIdentifier: bundleID) {
        let appIcon = workspace.icon(forFile: appURL.path)
        appIcon.size = NSSize(width: 256, height: 256)
        return appIcon
    }
    return nil
}

enum BetterNotchAppIcon {
    static let image: NSImage = {
        let size = NSSize(width: 1024, height: 1024)
        let image = NSImage(size: size)
        image.lockFocus()

        let bounds = NSRect(origin: .zero, size: size)
        let background = NSBezierPath(roundedRect: bounds, xRadius: 220, yRadius: 220)
        NSGradient(
            starting: NSColor(calibratedRed: 0.16, green: 0.22, blue: 0.34, alpha: 1),
            ending: NSColor(calibratedRed: 0.055, green: 0.075, blue: 0.13, alpha: 1)
        )?.draw(in: background, angle: -45)

        NSGraphicsContext.saveGraphicsState()
        let glow = NSShadow()
        glow.shadowColor = NSColor(calibratedRed: 0.35, green: 0.68, blue: 0.9, alpha: 0.55)
        glow.shadowBlurRadius = 92
        glow.set()
        NSColor(calibratedRed: 0.28, green: 0.56, blue: 0.8, alpha: 0.2).setFill()
        NSBezierPath(ovalIn: NSRect(x: 620, y: 590, width: 250, height: 250)).fill()
        NSGraphicsContext.restoreGraphicsState()

        let islandRect = NSRect(x: 220, y: 510, width: 584, height: 250)
        let island = NSBezierPath(roundedRect: islandRect, xRadius: 100, yRadius: 100)
        NSColor(calibratedWhite: 0.015, alpha: 1).setFill()
        island.fill()
        NSColor(calibratedWhite: 1, alpha: 0.14).setStroke()
        island.lineWidth = 3
        island.stroke()

        let waveformHeights: [CGFloat] = [84, 142, 190, 122, 164, 96]
        let waveformColor = NSColor(calibratedRed: 0.75, green: 0.9, blue: 1, alpha: 1)
        for (index, height) in waveformHeights.enumerated() {
            let bar = NSBezierPath(
                roundedRect: NSRect(
                    x: 378 + CGFloat(index) * 43,
                    y: islandRect.midY - height / 2,
                    width: 22,
                    height: height
                ),
                xRadius: 11,
                yRadius: 11
            )
            waveformColor.setFill()
            bar.fill()
        }

        image.unlockFocus()
        return image
    }()
}

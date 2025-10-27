import SwiftUI
import AppKit

class TouchBarController: NSObject, NSTouchBarDelegate {
    static let shared = TouchBarController()
    private var touchBar: NSTouchBar?
    
    var onButtonTapped: ((String) -> Void)?
    
    func setupTouchBar() {
        DispatchQueue.main.async {
            self.touchBar = NSTouchBar()
            self.touchBar?.delegate = self
            self.touchBar?.defaultItemIdentifiers = [
                .fixedSpaceSmall,
                .niebiescy,
                .zieloni,
                .zolci,
                .fixedSpaceSmall
            ]
        }
    }
    
    func showTouchBar() {
        DispatchQueue.main.async {
            if let window = NSApplication.shared.windows.first {
                window.touchBar = self.touchBar
            }
            NSApplication.shared.touchBar = self.touchBar
            NSLog("Touch Bar should be visible now")
        }
    }
    
    func hideTouchBar() {
        DispatchQueue.main.async {
            if let window = NSApplication.shared.windows.first {
                window.touchBar = nil
            }
            NSApplication.shared.touchBar = nil
        }
    }
    
    // MARK: - NSTouchBarDelegate
    func touchBar(_ touchBar: NSTouchBar, makeItemForIdentifier identifier: NSTouchBarItem.Identifier) -> NSTouchBarItem? {
        switch identifier {
        case .niebiescy:
            return createButtonItem(identifier: identifier, title: "Niebiescy", color: .systemBlue)
        case .zieloni:
            return createButtonItem(identifier: identifier, title: "Zieloni", color: .systemGreen)
        case .zolci:
            return createButtonItem(identifier: identifier, title: "Żółci", color: .systemYellow)
        default:
            return nil
        }
    }
    
    private func createButtonItem(identifier: NSTouchBarItem.Identifier, title: String, color: NSColor) -> NSTouchBarItem {
        let item = NSCustomTouchBarItem(identifier: identifier)
        let button = NSButton(title: title, target: self, action: #selector(buttonTapped(_:)))
        
        button.bezelColor = color
        button.font = NSFont.systemFont(ofSize: 16, weight: .bold)
        
        button.widthAnchor.constraint(greaterThanOrEqualToConstant: 320).isActive = true
        
        item.view = button
        item.visibilityPriority = .high
        
        return item
    }
    
    @objc private func buttonTapped(_ sender: NSButton) {
        onButtonTapped?(sender.title)
        NSLog("Touch Bar button tapped: \(sender.title)")
    }
}

extension NSTouchBarItem.Identifier {
    static let niebiescy = NSTouchBarItem.Identifier("niebiescy")
    static let zieloni = NSTouchBarItem.Identifier("zieloni")
    static let zolci = NSTouchBarItem.Identifier("zolci")
}

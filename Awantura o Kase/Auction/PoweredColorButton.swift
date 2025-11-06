import AppKit
import PoweredTouchBar

class PoweredColorButton: PoweredTouchBarItem {
    
    private let identifier: String
    var action: () -> Void
    
    var itemBuilder: (PoweredColorButton) -> NSCustomTouchBarItem
    
    public init(identifier: String, title: String, color: NSColor, action: @escaping () -> Void) {
        self.action = action
        self.identifier = identifier
        
        self.itemBuilder = {
            let buttonItem = NSCustomTouchBarItem(identifier: NSTouchBarItem.Identifier(identifier))
            let button = NSButton(title: title, target: $0, action: #selector(self.objAction))
            
            button.bezelColor = color
            button.font = NSFont.systemFont(ofSize: 16, weight: .bold)
            button.widthAnchor.constraint(greaterThanOrEqualToConstant: 300).isActive = true
            
            buttonItem.view = button
            buttonItem.visibilityPriority = .high
            
            return buttonItem
        }
    }
    
    public func touchBarItem() -> NSTouchBarItem {
        return itemBuilder(self)
    }
    
    public func getIdentifier() -> NSTouchBarItem.Identifier {
        return NSTouchBarItem.Identifier(identifier)
    }
    
    @objc func objAction(_ sender: Any) {
        action()
    }
}


import UIKit

class LCDDisplay: UILabel {
    
    var historyMenuItem: UIMenuItem {
        return UIMenuItem(title: "History", action: #selector(self.displayMathEquationHistory(_:)))
    }
    
    // MARK: - Initialisers
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.sharedInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        sharedInit()
    }
    
    private func sharedInit() {
        self.isUserInteractionEnabled = true
        self.addGestureRecognizer(UILongPressGestureRecognizer(target: self, action: #selector(self.showMenu)))
    }
    
    // MARK: - UIMenuController
    @objc private func showMenu(_ recognizer: UILongPressGestureRecognizer) {
        self.becomeFirstResponder()
        
        let menu = UIMenuController.shared
        menu.menuItems = [historyMenuItem]
        
        let locationOfTouchInLabel = recognizer.location(in: self)

        if !menu.isMenuVisible {
            var rect = bounds
            rect.origin = locationOfTouchInLabel
            rect.origin.y = rect.origin.y - 20
            rect.size = CGSize(width: 1, height: 44)
            menu.showMenu(from: self, rect: rect)
            
        }
    }
    
    @objc override func copy(_ sender: Any?) {
        UIPasteboard.general.string = text
        UIMenuController.shared.hideMenu()
        resignFirstResponder()
    }
    
    @objc override func paste(_ sender: Any?) {
        
        guard
            let proposedNumericValue = UIPasteboard.general.string,
            let decimal = Double(proposedNumericValue) else { return }
        
        UIMenuController.shared.hideMenu()
        resignFirstResponder()
        
        let userInfo: [AnyHashable: Any] = ["iOSBFree.com.calc.CopyableLabel.paste": decimal]
        NotificationCenter.default.post(name: Notification.Name("iOSBFree.com.calc.CopyableLabel.paste"), object: nil, userInfo: userInfo)
    }
    
    
    @objc private func displayMathEquationHistory(_ sender: Any?) {
        
        UIMenuController.shared.hideMenu()
        resignFirstResponder()
        NotificationCenter.default.post(name: Notification.Name("iOSBFree.com.calc.CopyableLabel.displayHistory"), object: nil)
    }
    
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        return action == #selector(UIResponderStandardEditActions.copy(_:)) || action == #selector(UIResponderStandardEditActions.paste(_:)) ||  action == #selector(self.displayMathEquationHistory(_:))
        
        
    }

}

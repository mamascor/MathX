
import UIKit

class LCDDisplay: UILabel {
    
    //MARK: - Properties
    var colorPalette: ColorPalette = DarkColorPalette()
    
    var historyMenuItem: UIMenuItem {
        return UIMenuItem(title: "View Log", action: #selector(self.displayMathEquationHistory(_:)))
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
        
        layer.cornerRadius = 20
        layer.masksToBounds = true
    }
    
    private func registerNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.willHideEditMenu(_:)), name: UIMenuController.willHideMenuNotification, object: nil)
    }
    
    private func unregisterNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIMenuController.willHideMenuNotification, object: nil)
    }
    
    // MARK: - UIMenuController
    @objc private func showMenu(_ recognizer: UILongPressGestureRecognizer) {
        
        registerNotifications()
        
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
        
        highlightScreen()
    }
    
    private func highlightScreen() {
        UIView.animate(withDuration: 0.35, delay: 0, options: .curveEaseInOut) { [weak self] in
            guard let theme = self?.colorPalette else { return }
            
            self?.backgroundColor = UIColor(hex:theme.operatorNormal)
            self?.textColor = UIColor(hex:theme.operatorTitle)
        } completion: { _ in
            
        }
    }
    
    private func unhighlightScreen() {
        UIView.animate(withDuration: 0.35, delay: 0, options: .curveEaseInOut) { [weak self] in
            guard let theme = self?.colorPalette else { return }
            
            self?.backgroundColor = UIColor(hex:theme.background)
            self?.textColor = UIColor(hex:theme.display)
        } completion: { _ in
            
        }
    }
    
    private func hideMenu() {
        
        UIMenuController.shared.hideMenu()
        resignFirstResponder()
        unregisterNotifications()
    }
    
    @objc override func copy(_ sender: Any?) {
        UIPasteboard.general.string = text
        hideMenu()
    }
    
    @objc override func paste(_ sender: Any?) {
        
        guard
            let proposedNumericValue = UIPasteboard.general.string,
            let decimal = Double(proposedNumericValue) else { return }
        
        hideMenu()
        
        let userInfo: [AnyHashable: Any] = ["iOSBFree.com.calc.CopyableLabel.paste": decimal]
        NotificationCenter.default.post(name: Notification.Name("iOSBFree.com.calc.CopyableLabel.paste"), object: nil, userInfo: userInfo)
    }
    
    
    @objc private func displayMathEquationHistory(_ sender: Any?) {
        
        hideMenu()
        NotificationCenter.default.post(name: Notification.Name("iOSBFree.com.calc.CopyableLabel.displayHistory"), object: nil)
    }
    
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        return action == #selector(UIResponderStandardEditActions.copy(_:)) || action == #selector(UIResponderStandardEditActions.paste(_:)) ||  action == #selector(self.displayMathEquationHistory(_:))
    }
    
    @objc private func willHideEditMenu(_ notification: Notification) {
        unhighlightScreen()
    }
}

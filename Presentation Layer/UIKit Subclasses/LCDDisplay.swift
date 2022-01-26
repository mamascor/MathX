///
//  LCDDisplay.swift
//  Calc
//
//  Created by Matthew Paul Harding on 25/01/2022.
//
//  iOSB Free Ltd                   → All rights reserved
//  Website                         → https://www.iosbfree.com
//
//  👉 Free Courses                 → https://www.udemy.com/user/iosbfree
//
//  YouTube                         → https://www.youtube.com/channel/UCWBUOVRbtKNml4jN_4bRkCQ
//  Linked In                       → http://www.linkedin.com/in/mattharding-iosbfree
//  Tell us what you want to learn  → community@iosbfree.com
// *******************************************************************************************

import UIKit

class LCDDisplay: UILabel {
    
    //MARK: - Properties
    var theme: CalculatorTheme = DarkTheme()
    
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
        isUserInteractionEnabled = true
        addGestureRecognizer(UILongPressGestureRecognizer(target: self, action: #selector(self.longPressGestureEventFired)))
        
        layer.cornerRadius = 20
        layer.masksToBounds = true
        
        setupBackgroundColorInOrderToAnimate()
    }
    
    
    @objc private func longPressGestureEventFired(_ recognizer: UILongPressGestureRecognizer) {
        guard UIMenuController.shared.isMenuVisible == false else {
            return
        }
        
        showMenu(from: recognizer)
    }
    
    private func setupBackgroundColorInOrderToAnimate() {
        backgroundColor = .clear
    }
    
    private func registerNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.willHideEditMenu(_:)), name: UIMenuController.willHideMenuNotification, object: nil)
    }
    
    private func unregisterNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIMenuController.willHideMenuNotification, object: nil)
    }
    
    // MARK: - UIMenuController
    @objc private func showMenu(from recognizer: UILongPressGestureRecognizer) {
        
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
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseInOut) { [weak self] in
            guard let theme = self?.theme else { return }
            
            self?.layer.backgroundColor = UIColor(hex:theme.operatorNormal)?.cgColor
            self?.textColor = UIColor(hex:theme.operatorTitle)
        } completion: { _ in
            
        }
    }
    
    func prepareForThemeUpdate() {
        unhighlightScreen(false)
        hideMenu()
    }
    
    private func unhighlightScreen(_ animated: Bool) {
        
        let actionToPerform: (() -> Void) = { [weak self] in
            guard let theme = self?.theme else { return }
            
            self?.layer.backgroundColor = UIColor.clear.cgColor
            self?.textColor = UIColor(hex:theme.display)
        }
        
        guard animated else {
            actionToPerform()
            return
        }
        
        UIView.animate(withDuration: 0.15, delay: 0, options: .curveEaseInOut) {
            actionToPerform()
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
        unhighlightScreen(true)
    }
}

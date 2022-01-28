///
//  LCDDisplay.swift
//  Calc
//
//  Created by iOSB Free on 25/01/2022.
//
//  iOSB Free Ltd                   → All rights reserved
//  Website                         → https://www.iosbfree.com
//
//  👉🏽 Free Courses                 → https://www.udemy.com/user/iosbfree
//
//  YouTube                         → https://www.youtube.com/channel/UCWBUOVRbtKNml4jN_4bRkCQ
//  Linked In                       → http://www.linkedin.com/in/mattharding-iosbfree
//
//  Tell us what
//  you want to learn
//
//  💛 iOSB Free
//  community@iosbfree.com
//  🧕🏻👨🏿‍💼👩🏼‍💼👩🏻‍💻👨🏼‍💼🧛🏻‍♀️👩🏼‍💻💁🏽‍♂️🕵🏻‍♂️🧝🏼‍♀️🦹🏼‍♀🧕🏾🧟‍♂️
// *******************************************************************************************
//
// → What's This File?
//   It's a subclass. This is our label to display input and the results of equations.
//   Architecural Layer: Presentation Layer
//
// *******************************************************************************************


import UIKit

class LCDDisplay: UIView {
    
    @IBOutlet var label: UILabel!
    
    //MARK: - Properties
    
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
        layer.cornerRadius = 20
        layer.masksToBounds = true
        setupBackgroundColorInOrderToAnimate()
        addMenuGestureRecogniser()
    }
    
    
    private func setupBackgroundColorInOrderToAnimate() {
        backgroundColor = .clear
    }
    
    // MARK: - Notifications
    
    private func registerNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.willHideEditMenu(_:)), name: UIMenuController.willHideMenuNotification, object: nil)
    }
    
    private func unregisterNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIMenuController.willHideMenuNotification, object: nil)
    }
    
    // MARK: - Gesture Recogniser
    
    private func addMenuGestureRecogniser() {
        addGestureRecognizer(UILongPressGestureRecognizer(target: self, action: #selector(self.longPressGestureEventFired)))
    }
    
    @objc private func longPressGestureEventFired(_ recognizer: UILongPressGestureRecognizer) {
        guard UIMenuController.shared.isMenuVisible == false else {
            return
        }
        
        showMenu(from: recognizer)
    }
    
    // MARK: - UIMenuController
    
    @objc private func showMenu(from recognizer: UILongPressGestureRecognizer) {
        registerNotifications()
        becomeFirstResponder()
        
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
        let theme = ThemeManager.shared.currentTheme
        
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseInOut) { [weak self] in
            self?.layer.backgroundColor = UIColor(hex:theme.operatorNormal)?.cgColor
            self?.label.textColor = UIColor(hex:theme.operatorTitle)
        } completion: { _ in
            
        }
    }
    
    func prepareForThemeUpdate() {
        unhighlightScreen(false)
        hideMenu()
    }
    
    private func unhighlightScreen(_ animated: Bool) {
        let theme = ThemeManager.shared.currentTheme
        
        let actionToPerform: (() -> Void) = { [weak self] in
            self?.layer.backgroundColor = UIColor.clear.cgColor
            self?.label.textColor = UIColor(hex:theme.display)
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
        UIPasteboard.general.string = label.text
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

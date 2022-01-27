//
//  CalcViewController.swift
//  Calc
//
//  Created by Matthew Paul Harding on 24/01/2022.
//
//
//  iOSB Free Ltd                   → All rights reserved
//  Website                         → https://www.iosbfree.com
//
//  👉🏾 Free Courses                 → https://www.udemy.com/user/iosbfree
//
//  YouTube                         → https://www.youtube.com/channel/UCWBUOVRbtKNml4jN_4bRkCQ
//  Linked In                       → http://www.linkedin.com/in/mattharding-iosbfree
//
//  Tell us what
//  you want to learn
//
//  🤎 iOSB Free
//  community@iosbfree.com
//  🧕🏻👨🏿‍💼👩🏼‍💼👩🏻‍💻👨🏼‍💼🧛🏻‍♀️👩🏼‍💻💁🏽‍♂️🕵🏻‍♂️🧝🏼‍♀️🦹🏼‍♀🧕🏾🧟‍♂️
// *******************************************************************************************
//
// → What's This File?
//   It's a screen. It displays the calculator itself.
//   💡 Architecture Tip 👉🏻 The UI layer should ideally only contain UI. Place all other code
//   into other files creating types such as managers and data storage.
// *******************************************************************************************

import UIKit


class CalcViewController: UIViewController {

    // MARK: - IBOutlets
    
    @IBOutlet weak var calculatorView: UIView!
    @IBOutlet weak var lcdDisplay: LCDDisplay!
    
    @IBOutlet weak var pinPadButton0: UIButton!
    @IBOutlet weak var pinPadButton1: UIButton!
    @IBOutlet weak var pinPadButton2: UIButton!
    @IBOutlet weak var pinPadButton3: UIButton!
    @IBOutlet weak var pinPadButton4: UIButton!
    @IBOutlet weak var pinPadButton5: UIButton!
    @IBOutlet weak var pinPadButton6: UIButton!
    @IBOutlet weak var pinPadButton7: UIButton!
    @IBOutlet weak var pinPadButton8: UIButton!
    @IBOutlet weak var pinPadButton9: UIButton!
    @IBOutlet weak var decimalButton: UIButton!
    
    @IBOutlet weak var clearButton: UIButton!
    @IBOutlet weak var negateButton: UIButton!
    @IBOutlet weak var percentageButton: UIButton!
    
    @IBOutlet weak var divideButton: UIButton!
    @IBOutlet weak var multiplyButton: UIButton!
    @IBOutlet weak var minusButton: UIButton!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var equalsButton: UIButton!
    
    private var needsToSetupView = true
     
    // MARK: - Gesture Properties
    
    private var themeGestureRecogniser: UITapGestureRecognizer?
    
    // MARK: - Calculator Engine
    
    private var calculator = iOSBFreeCalculatorEngine()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addThemeGestureRecogniser()
        lcdDisplay.alpha = 0
        registerForNotifications()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        decorateView(withTheme: ThemeManager.shared.currentTheme)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        calculator.restoreFromLastSession()
        lcdDisplay.text = calculator.lcdDisplayText
        
        if calculator.decimalRepresentationOfEditingOperand == 0 {
            fadeInLCDDisplay()
        } else {
            moveInLCDDisplay()
        }
    }
    
    // MARK: - Decorate
    
    private func decorateView(withTheme theme: CalculatorTheme) {
        
        view.backgroundColor = UIColor(hex: theme.background)
        calculatorView.backgroundColor = view.backgroundColor
        
        lcdDisplay.prepareForThemeUpdate()
        lcdDisplay.backgroundColor = .clear
        lcdDisplay.textColor = UIColor(hex: theme.display)
        
        decoratePinPadButton(pinPadButton0)
        decoratePinPadButton(pinPadButton1)
        decoratePinPadButton(pinPadButton2)
        decoratePinPadButton(pinPadButton3)
        decoratePinPadButton(pinPadButton4)
        decoratePinPadButton(pinPadButton5)
        decoratePinPadButton(pinPadButton6)
        decoratePinPadButton(pinPadButton7)
        decoratePinPadButton(pinPadButton8)
        decoratePinPadButton(pinPadButton9)
        decoratePinPadButton(decimalButton)
        
        decorateOperatorButton(divideButton, theme: theme)
        decorateOperatorButton(multiplyButton, theme: theme)
        decorateOperatorButton(minusButton, theme: theme)
        decorateOperatorButton(addButton, theme: theme)
        decorateOperatorButton(equalsButton, theme: theme)
        
        decorateExtraFunctionsButton(clearButton)
        decorateExtraFunctionsButton(negateButton)
        decorateExtraFunctionsButton(percentageButton)
    }
    
    private func decoratePinPadButton(_ button: UIButton) {
        let selectedTheme = ThemeManager.shared.currentTheme
        button.backgroundColor = UIColor(hex: selectedTheme.pinPad)
        button.tintColor = UIColor(hex: selectedTheme.pinPadTitle)
        button.becomeRound()
    }
    
    private func decorateOperatorButton(_ button: UIButton, theme: CalculatorTheme) {
        button.backgroundColor = UIColor(hex: theme.operatorNormal)
        button.tintColor = UIColor(hex: theme.operatorTitle)
        button.becomeRound()
    }
    
    private func decorateOperatorButtonsWithTheme(_ theme: CalculatorTheme) {
        decorateOperatorButton(divideButton, theme: theme)
        decorateOperatorButton(multiplyButton, theme: theme)
        decorateOperatorButton(minusButton, theme: theme)
        decorateOperatorButton(addButton, theme: theme)
    }
    
    private func decorateExtraFunctionsButton(_ button: UIButton) {
        let selectedTheme = ThemeManager.shared.currentTheme
        button.backgroundColor = UIColor(hex: selectedTheme.extraFunctions)
        button.tintColor = UIColor(hex: selectedTheme.extraFunctionsTitle)
        button.becomeRound()
    }
    
    // MARK: - Select Operator Buttons
    private func deselectOperatorButtons() {
        selectOperatorButton(divideButton, false)
        selectOperatorButton(multiplyButton, false)
        selectOperatorButton(minusButton, false)
        selectOperatorButton(addButton, false)
    }
    
    private func selectOperatorButton(_ button: UIButton, _ selected: Bool = false) {
        let selectedTheme = ThemeManager.shared.currentTheme
        
        button.backgroundColor = selected ? UIColor(hex: selectedTheme.operatorSelected) : UIColor(hex: selectedTheme.operatorNormal)
        button.tintColor = selected ? UIColor(hex: selectedTheme.operatorTitleSelected) : UIColor(hex: selectedTheme.operatorTitle)
        button.becomeRound()
    }
    
    // MARK: - Gesture Recognisers
    
    private func addThemeGestureRecogniser() {
        
        themeGestureRecogniser = UITapGestureRecognizer(target: self, action: #selector(self.themeGestureRecogniserDidTap))
        themeGestureRecogniser?.numberOfTapsRequired = 2
        if let gesture = themeGestureRecogniser {
            lcdDisplay.addGestureRecognizer(gesture)
        }
    }
    
    @objc private func themeGestureRecogniserDidTap (_ gesture: UITapGestureRecognizer) {
        decorateViewWithNextTheme()
    }
    
    // MARK: - Themes
    
    private func decorateViewWithNextTheme() {
        ThemeManager.shared.moveToNextTheme()
        refreshViewWithTheme(ThemeManager.shared.currentTheme)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        switch ThemeManager.shared.currentTheme.statusBarStyle {
        case .light: return .lightContent
        case .dark: return .darkContent
        }
    }
    
    private func refreshViewWithTheme(_ theme: CalculatorTheme) {
        let theme = ThemeManager.shared.currentTheme
        decorateView(withTheme: theme)
        setNeedsStatusBarAppearanceUpdate()
    }
    
    // MARK: - IBActions
    
    @IBAction func clearButtonPressed(_ sender: UIButton) {
        
        deselectOperatorButtons()
        sender.bounce()
        
        lcdDisplay.alpha = 0
        
        calculator.clearPressed()
        lcdDisplay.text = calculator.lcdDisplayText
        fadeInLCDDisplay()
    }
    
    @IBAction func negateButtonPressed(_ sender: UIButton) {
         
        sender.bounce()
        calculator.negatePressed()
        lcdDisplay.text = calculator.lcdDisplayText
    }
    
    @IBAction func percentageButtonPressed(_ sender: UIButton) {
         
        sender.bounce()
        calculator.percentagePressed()
        lcdDisplay.text = calculator.lcdDisplayText
    }
    
    @IBAction func divideButtonPressed(_ sender: UIButton) {
        
        deselectOperatorButtons()
        selectOperatorButton(divideButton, true)
        
        sender.bounce()
        
        calculator.dividePressed()
        lcdDisplay.text = calculator.lcdDisplayText
    }
    
    @IBAction func multiplyButtonPressed(_ sender: UIButton) {
         
        deselectOperatorButtons()
        selectOperatorButton(multiplyButton, true)
        
        sender.bounce()
        
        calculator.multiplyPressed()
        lcdDisplay.text = calculator.lcdDisplayText
    }
    
    @IBAction func minusButtonPressed(_ sender: UIButton) {
         
        deselectOperatorButtons()
        selectOperatorButton(minusButton, true)
        
        sender.bounce()
        
        calculator.minusPressed()
        lcdDisplay.text = calculator.lcdDisplayText
    }
    
    @IBAction func addButtonPressed(_ sender: UIButton) {
         
        deselectOperatorButtons()
        selectOperatorButton(addButton, true)
        
        sender.bounce()
        
        calculator.addPressed()
        lcdDisplay.text = calculator.lcdDisplayText
    }
    
    @IBAction func equalButtonPressed(_ sender: UIButton) {
        
        deselectOperatorButtons()
        sender.bounce()
        
        calculator.equalsPressed()
        lcdDisplay.text = calculator.lcdDisplayText
    }
    
    @IBAction func decimalButtonPressed(_ sender: UIButton) {
        
        deselectOperatorButtons()
        sender.bounce()
        
        calculator.decimalPressed()
        lcdDisplay.text = calculator.lcdDisplayText
    }
    
    @IBAction func numberButtonPressed(_ sender: UIButton) {
        
        deselectOperatorButtons()
        sender.bounce()
        let number = sender.tag
        
        calculator.numberPressed(number)
        lcdDisplay.text = calculator.lcdDisplayText
    }
    
    // MARK: - Animate
    
    private func fadeInLCDDisplay() {
        UIView.animate(withDuration: 1.0, animations: { [weak self] in
            self?.lcdDisplay.alpha = 1
        })
    }
    
    private func moveInLCDDisplay() {
        lcdDisplay.transform = CGAffineTransform(translationX: 0, y: lcdDisplay.frame.height * 0.5)
        
        UIView.animate(withDuration: 0.35, delay: 0.2, options: .curveEaseOut) { [weak self] in
            
            self?.lcdDisplay.alpha = 1
            self?.lcdDisplay.transform = CGAffineTransform(translationX: 0, y: 0)
        } completion: { _ in
        }
    }
    
    // MARK: - Navigation
    
    private func presentLogScreen() {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let logViewController: LogViewController = storyboard.instantiateViewController(withIdentifier: "LogViewController") as? LogViewController else { return }
        
        logViewController.setDataSource(calculator.copyOfEquationLog)
        
        let navigationController = UINavigationController(rootViewController: logViewController)
        navigationController.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        present(navigationController, animated: true, completion: nil)
    }
    
    // MARK: - Notifications
    private func registerForNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.didReceivePasteNotification(notification:)), name: Notification.Name("iOSBFree.com.calc.CopyableLabel.paste"), object: nil)
        
            NotificationCenter.default.addObserver(self, selector: #selector(self.didReceiveHistoryNotification(notification:)), name: Notification.Name("iOSBFree.com.calc.CopyableLabel.displayHistory"), object: nil)
        
        
            NotificationCenter.default.addObserver(self, selector: #selector(self.didReceivePasteMathEquationNotification(notification:)), name: Notification.Name("iOSBFree.com.calc.LogViewController.pasteMathEquation"), object: nil)
    }
    
    @objc private func didReceiveHistoryNotification(notification: Notification) {
        presentLogScreen()
    }
    
    @objc private func didReceivePasteNotification(notification: Notification) {
        
        guard let decimalValue = notification.userInfo?["iOSBFree.com.calc.CopyableLabel.paste"] as? Double else { return }
        pasteNewValueIntoCalculator(Decimal(decimalValue))
    }
    
    @objc private func didReceivePasteMathEquationNotification(notification: Notification) {
        
        guard let mathEquation = notification.userInfo?["iOSBFree.com.calc.LogViewController.pasteMathEquation"] as? MathEquation else { return }
        pasteNewValueIntoCalculator(mathEquation)
    }
    
    private func pasteNewValueIntoCalculator(_ decimal: Decimal) {
        
        calculator.pasteIn(decimal)
        lcdDisplay.text = calculator.lcdDisplayText
    }
    
    private func pasteNewValueIntoCalculator(_ mathEquation: MathEquation) {
        
        calculator.pasteIn(mathEquation)
        lcdDisplay.text = calculator.lcdDisplayText
    }
}

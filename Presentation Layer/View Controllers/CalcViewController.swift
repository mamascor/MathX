//
//  CalcViewController.swift
//  Calc
//
//  Created by Matthew Paul Harding on 24/01/2022.
//

import UIKit

class CalcViewController: UIViewController {

    // MARK: - IBOutlets
    
    @IBOutlet weak var calculatorView: UIView!
    @IBOutlet weak var lcdDisplay: UILabel!
    
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
    
    // MARK: - Color Palette
    
    private var colorPalette: ColorPalette = DarkColorPalette()
    private var currentThemeIndex = 0
    private let themeDataStore = DataStore(key: "iOSBFree.com.calc.CalcViewController.themeIndex")
    
    // MARK: - Gesture Properties
    
    private var themeGestureRecogniser: UITapGestureRecognizer?
    
    // MARK: - Calculator Engine
    
    private var calculator = CalculatorEngine()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addThemeGestureRecogniser()
        loadThemeIndex()
        lcdDisplay.alpha = 0
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        decorateView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let number = calculator.restoreFromLastSession()
        lcdDisplay.text = calculator.formatForDisplay(number: number)
        if number == 0 {
            fadeInLCDDisplay()
        } else {
            moveInLCDDisplay()
        }
    }
    
    // MARK: - Decorate
    
    private func decorateView() {
        
        view.backgroundColor = UIColor(hex: colorPalette.background)
        calculatorView.backgroundColor = view.backgroundColor
        
        lcdDisplay.textColor = UIColor(hex: colorPalette.display)
        
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
        
        decorateOperatorButton(divideButton)
        decorateOperatorButton(multiplyButton)
        decorateOperatorButton(minusButton)
        decorateOperatorButton(addButton)
        decorateOperatorButton(equalsButton)
        
        decorateExtraFunctionsButton(clearButton)
        decorateExtraFunctionsButton(negateButton)
        decorateExtraFunctionsButton(percentageButton)
    }
    
    private func decoratePinPadButton(_ button: UIButton) {
        button.backgroundColor = UIColor(hex: colorPalette.pinPad)
        button.tintColor = UIColor(hex: colorPalette.pinPadTitle)
        button.becomeRound()
    }
    
    private func decorateOperatorButton(_ button: UIButton, _ selected: Bool = false) {
        button.backgroundColor = selected ? UIColor(hex: colorPalette.operatorSelected) : UIColor(hex: colorPalette.operatorNormal)
        button.tintColor = selected ? UIColor(hex: colorPalette.operatorTitleSelected) : UIColor(hex: colorPalette.operatorTitle)
        button.becomeRound()
    }
    
    private func deselectOperatorButtons() {
        decorateOperatorButton(divideButton, false)
        decorateOperatorButton(multiplyButton, false)
        decorateOperatorButton(minusButton, false)
        decorateOperatorButton(addButton, false)
    }
    
    private func decorateExtraFunctionsButton(_ button: UIButton) {
        button.backgroundColor = UIColor(hex: colorPalette.extraFunctions)
        button.tintColor = UIColor(hex: colorPalette.extraFunctionsTitle)
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
        
        // loop to the beginning
        let numberOfThemes = 7
        currentThemeIndex = currentThemeIndex + 1
        if currentThemeIndex >= numberOfThemes {
            currentThemeIndex = 0
        }
        
        loadThemeFromCurrentThemeIndex()
        
        saveCurrentThemeIndex()
    }
    
    private func loadThemeFromCurrentThemeIndex() {
        switch currentThemeIndex {
        case 1: loadTheme(ElectroColorPalette())
        case 2: loadTheme(LightColorPalette())
        case 3: loadTheme(PinkColorPalette())
        case 4: loadTheme(LightBlueColorPalette())
        case 5: loadTheme(DarkBlueColorPalette())
        case 6: loadTheme(PurpleColorPalette())
        default: loadTheme(DarkColorPalette())
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        switch colorPalette.statusBarStyle {
        case .light: return .lightContent
        case .dark: return .darkContent
        }
    }
    
    private func loadTheme(_ theme: ColorPalette) {
        colorPalette = theme
        decorateView()
        setNeedsStatusBarAppearanceUpdate()
    }
    
    private func saveCurrentThemeIndex() {
        themeDataStore.saveInt(currentThemeIndex)
    }
    
    private func loadThemeIndex() {
        currentThemeIndex = themeDataStore.loadInt()
        loadThemeFromCurrentThemeIndex()
    }
    
    // MARK: - IBActions
    
    @IBAction func clearButtonPressed(_ sender: UIButton) {
        
        deselectOperatorButtons()
        sender.bounce()
        
        lcdDisplay.alpha = 0
        
        let numberToDisplay = calculator.clearPressed()
        lcdDisplay.text = calculator.formatForDisplay(number: numberToDisplay)
        fadeInLCDDisplay()
    }
    
    @IBAction func negateButtonPressed(_ sender: UIButton) {
         
        sender.bounce()
        let numberToDisplay = calculator.negatePressed()
        lcdDisplay.text = calculator.formatForDisplay(number: numberToDisplay)
    }
    
    @IBAction func percentageButtonPressed(_ sender: UIButton) {
         
        sender.bounce()
        let numberToDisplay = calculator.percentagePressed()
        lcdDisplay.text = calculator.formatForDisplay(number: numberToDisplay)
    }
    
    @IBAction func divideButtonPressed(_ sender: UIButton) {
        
        deselectOperatorButtons()
        decorateOperatorButton(divideButton, true)
        
        sender.bounce()
        if let numberToDisplay = calculator.dividePressed() {
            lcdDisplay.text = calculator.formatForDisplay(number: numberToDisplay)
        }
    }
    
    @IBAction func multiplyButtonPressed(_ sender: UIButton) {
         
        deselectOperatorButtons()
        decorateOperatorButton(multiplyButton, true)
        
        sender.bounce()
        if let numberToDisplay = calculator.multiplyPressed() {
            lcdDisplay.text = calculator.formatForDisplay(number: numberToDisplay)
        }
    }
    
    @IBAction func minusButtonPressed(_ sender: UIButton) {
         
        deselectOperatorButtons()
        decorateOperatorButton(minusButton, true)
        
        sender.bounce()
        if let numberToDisplay = calculator.minusPressed() {
            lcdDisplay.text = calculator.formatForDisplay(number: numberToDisplay)
        }
    }
    
    @IBAction func addButtonPressed(_ sender: UIButton) {
         
        deselectOperatorButtons()
        decorateOperatorButton(addButton, true)
        
        sender.bounce()
        if let numberToDisplay = calculator.addPressed() {
            lcdDisplay.text = calculator.formatForDisplay(number: numberToDisplay)
        }
    }
    
    @IBAction func equalButtonPressed(_ sender: UIButton) {
        
        deselectOperatorButtons()
        sender.bounce()
        if let numberToDisplay = calculator.equalsPressed() {
            lcdDisplay.text = calculator.formatForDisplay(number: numberToDisplay)
        }
        
        if let numberToDisplay = calculator.equalsPressed() {
            lcdDisplay.text = calculator.formatForDisplay(number: numberToDisplay)
        }
    }
    
    @IBAction func decimalButtonPressed(_ sender: UIButton) {
        
        deselectOperatorButtons()
        sender.bounce()
        let numberToDisplay = calculator.decimalPressed()
        lcdDisplay.text = calculator.formatForDisplay(number: numberToDisplay)
    }
    
    @IBAction func numberButtonPressed(_ sender: UIButton) {
        
        deselectOperatorButtons()
        sender.bounce()
        let number = sender.tag
        let numberToDisplay = calculator.numberPressed(number)
            lcdDisplay.text = calculator.formatForDisplay(number: numberToDisplay)
    }
    
    // MARK: - Animate
    
    private func fadeInLCDDisplay() {
        UIView.animate(withDuration: 1.0, animations: { [weak self] in
            self?.lcdDisplay.alpha = 1
        })
    }
    
    private func moveInLCDDisplay() {
        lcdDisplay.transform = CGAffineTransform(translationX: 0, y: lcdDisplay.frame.height)
        UIView.animate(withDuration: 0.5,
            animations: { [weak self] in
            self?.lcdDisplay.alpha = 1
            self?.lcdDisplay.transform = CGAffineTransform(translationX: 0, y: -8)
            },
            completion: { [weak self] _ in
                UIView.animate(withDuration: 0.15) {
                    self?.lcdDisplay.transform = CGAffineTransform.identity
                }
            })
    }
}

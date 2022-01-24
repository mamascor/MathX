//
//  ViewController.swift
//  Calc
//
//  Created by Matthew Paul Harding on 24/01/2022.
//

import UIKit

class ViewController: UIViewController {

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
    
    var calculatorColors: CalculatorColors = DarkCalculator()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        decorateView()
    }
    
    // MARK: - Decorate
    
    private func decorateView() {
        
        view.backgroundColor = UIColor(hex: calculatorColors.background)
        calculatorView.backgroundColor = view.backgroundColor
        
        lcdDisplay.textColor = UIColor(hex: calculatorColors.display)
        
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
        
        decorateOperandButton(divideButton)
        decorateOperandButton(multiplyButton)
        decorateOperandButton(minusButton)
        decorateOperandButton(addButton)
        decorateOperandButton(equalsButton)
        
        decorateExtraFunctionsButton(clearButton)
        decorateExtraFunctionsButton(negateButton)
        decorateExtraFunctionsButton(percentageButton)
    }
    
    private func decoratePinPadButton(_ button: UIButton) {
        button.backgroundColor = UIColor(hex: calculatorColors.pinPad)
        button.tintColor = UIColor(hex: calculatorColors.pinPadTitle)
        button.becomeRound()
    }
    
    private func decorateOperandButton(_ button: UIButton, _ selected: Bool = false) {
        button.backgroundColor = selected ? UIColor(hex: calculatorColors.operandSelected) : UIColor(hex: calculatorColors.operand)
        button.tintColor = selected ? UIColor(hex: calculatorColors.operatorTitleSelected) : UIColor(hex: calculatorColors.operatorTitle)
        button.becomeRound()
    }
    
    private func decorateExtraFunctionsButton(_ button: UIButton) {
        button.backgroundColor = UIColor(hex: calculatorColors.extraFunctions)
        button.tintColor = UIColor(hex: calculatorColors.extraFunctionsTitle)
        button.becomeRound()
    }
    
}


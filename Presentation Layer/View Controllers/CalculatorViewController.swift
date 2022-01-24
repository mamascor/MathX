//
//  HomeViewController.swift
//  Calc
//
//  Created by Matthew Paul Harding on 01/01/22.
//  Copyright © 2022 iOSB Free Ltd. All rights reserved.
//

import UIKit

final class CalculatorViewController: UIViewController {

    // MARK: - IBOutlets
    
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
    @IBOutlet weak var pinPadButtonDecimal: UIButton!
    
    @IBOutlet weak var clearButton: UIButton!
    @IBOutlet weak var negateButton: UIButton!
    @IBOutlet weak var percentButton: UIButton!
    @IBOutlet weak var executeEquationButton: UIButton!
    
    @IBOutlet weak var addOperatorButton: UIButton!
    @IBOutlet weak var minusOperatorButton: UIButton!
    @IBOutlet weak var multiplyOperatorButton: UIButton!
    @IBOutlet weak var divideOperatorButton: UIButton!
    
    @IBOutlet weak var display: UILabel!
    
    // MARK: - Decoration Properties
    
    var operatorColor: UIColor?
    var operatorTitleColor: UIColor?
    
    // MARK: - Calculator Engine
    
    private var calculator = CalculatorEngine()
    
    // MARK: - Life Cycle
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        extractMathOperatorColors()
        pinPadButtonDecimal.setTitle(calculator.decimalSymbol, for: .normal)
        
        display.text = calculator.formatForDisplay(number: calculator.restoreFromLastSession())
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        decorateView()
    }
    
    // MARK: - Setup
    
    private func extractMathOperatorColors() {
        
        operatorColor = divideOperatorButton.backgroundColor
        operatorTitleColor = divideOperatorButton.currentTitleColor
    }
    
    private func decorateView() {
        
        pinPadButton0.becomeRound()
        pinPadButton1.becomeRound()
        pinPadButton2.becomeRound()
        pinPadButton3.becomeRound()
        pinPadButton4.becomeRound()
        pinPadButton5.becomeRound()
        pinPadButton6.becomeRound()
        pinPadButton7.becomeRound()
        pinPadButton8.becomeRound()
        pinPadButton9.becomeRound()
        pinPadButtonDecimal.becomeRound()
        
        clearButton.becomeRound()
        negateButton.becomeRound()
        percentButton.becomeRound()
        executeEquationButton.becomeRound()
        addOperatorButton.becomeRound()
        minusOperatorButton.becomeRound()
        multiplyOperatorButton.becomeRound()
        divideOperatorButton.becomeRound()
    }
    
    // MARK: - @IBAction
    
    @IBAction func clearButtonPressed(_ sender: UIButton) {
        
        let numberToDisplay = calculator.clear() // todo update the display with this value!!
        display.text = calculator.formatForDisplay(number: numberToDisplay)
        clearButton.setTitle("AC", for: .normal)
        
        unhighlightOperationButtons()
    }
    
    @IBAction func negateButtonPressed(_ sender: UIButton) {
        let numberToDisplay = calculator.negateNumber()
        display.text = calculator.formatForDisplay(number: numberToDisplay)
        
        highlightOperationButton()
    }
    
    @IBAction func percentageButtonPressed(_ sender: UIButton) {
        let numberToDisplay = calculator.applyPercentage()
        display.text = calculator.formatForDisplay(number: numberToDisplay)
        
        highlightOperationButton()
    }
    
    @IBAction func pinPadButtonPressed(_ sender: UIButton) {
        let numberToDisplay = calculator.inputNumber(sender.tag)
        display.text = calculator.formatForDisplay(number: numberToDisplay)
        
        highlightOperationButton()
    }
    
    // MARK: - Math DMAS Actions
    
    @IBAction func addOperatorPressed(_ sender: UIButton) {
        
        if let numberToDisplay = calculator.addOperation() {
            display.text = calculator.formatForDisplay(number: numberToDisplay)
        }
        
        highlightOperationButton()
    }
    
    @IBAction func minusOperatorPressed(_ sender: UIButton) {
        if let numberToDisplay = calculator.substractOperation() {
            display.text = calculator.formatForDisplay(number: numberToDisplay)
        }
        
        highlightOperationButton()
    }
    
    @IBAction func multiplyOperatorPressed(_ sender: UIButton) {
        if let numberToDisplay = calculator.multiplyOperation() {
            display.text = calculator.formatForDisplay(number: numberToDisplay)
        }
        
        highlightOperationButton()
    }
    
    @IBAction func divideOperatorPressed(_ sender: UIButton) {
        if let numberToDisplay = calculator.divideOperation() {
            display.text = calculator.formatForDisplay(number: numberToDisplay)
        }
        
        highlightOperationButton()
    }
    
    // MARK: - Decimal
    
    @IBAction func decimalButtonPressed(_ sender: UIButton) {
        let numberToDisplay = calculator.applyDecimal()
        display.text = calculator.formatForDisplay(number: numberToDisplay)
        if display.text?.contains(calculator.decimalSymbol) == false {
            display.text = display.text?.appending("\(calculator.decimalSymbol)")
        }
        
        highlightOperationButton()
    }
    
    // MARK: - Execute Equation
    
    @IBAction func executeEquationPressed(_ sender: UIButton) {
        
        if let displayValue = calculator.resultOperation() {
            display.text = calculator.formatForDisplay(number: displayValue)
        }
        highlightOperationButton()
    }
    
    // MARK: - Operator Button Decoration
    
    private func unhighlightOperationButtons() {
        
        highlightOperator(addOperatorButton,  selected:false)
        highlightOperator(minusOperatorButton,  selected:false)
        highlightOperator(multiplyOperatorButton,  selected:false)
        highlightOperator(divideOperatorButton,  selected:false)
        
    }
    
    private func highlightOperationButton() {
        
        unhighlightOperationButtons()
        
        if calculator.operating {
            switch calculator.operation {
            case .none:
                break
            case .addiction:
                highlightOperator(addOperatorButton, selected:true)
            case .substraction:
                highlightOperator(minusOperatorButton, selected:true)
            case .multiplication:
                highlightOperator(multiplyOperatorButton, selected:true)
            case .division:
                highlightOperator(divideOperatorButton, selected:true)
            }
        }
    }
    
    private func highlightOperator(_ button: UIButton, selected: Bool) {
        button.setTitleColor(selected ? operatorColor : operatorTitleColor, for: .normal)
        button.backgroundColor = selected ? operatorTitleColor : operatorColor
    }
}
 

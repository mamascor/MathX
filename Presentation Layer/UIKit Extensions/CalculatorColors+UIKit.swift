//
//  CalculatorColors+UIKit.swift
//  Calc
//
//  Created by Matthew Paul Harding on 24/01/2022.
//

import UIKit

extension CalculatorColors {
    var backgroundColor: UIColor { UIColor(hex: background)! }
    var displayColor: UIColor { UIColor(hex: display)! }
    
    var operandColor: UIColor { UIColor(hex: operand)! }
    var operandSelectedColor: UIColor { UIColor(hex: operandSelected)! }
    
    var operatorTitleColor: UIColor { UIColor(hex: operatorTitle)! }
    var operatorTitleSelectedColor: UIColor { UIColor(hex: operatorTitleSelected)! }
    
    var pinPadColor: UIColor { UIColor(hex: pinPad)! }
    var pinPadTitleColor: UIColor { UIColor(hex: pinPadTitle)! }
    
    var extraFunctionsColor: UIColor { UIColor(hex: extraFunctions)! }
    var extraFunctionsTitleColor: UIColor { UIColor(hex: extraFunctionsTitle)! }
}

extension UIColor {
    public convenience init?(hex: String) {
        let r, g, b: CGFloat

        if hex.hasPrefix("#") {
            let start = hex.index(hex.startIndex, offsetBy: 1)
            let hexColor = String(hex[start...])

            if hexColor.count == 6 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0

                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff0000) >> 16) / 255
                    g = CGFloat((hexNumber & 0x00ff00) >> 8) / 255
                    b = CGFloat((hexNumber & 0x0000ff) >> 0) / 255

                    self.init(red: r, green: g, blue: b, alpha: 1)
                    return
                }
            }
        }

        return nil
    }
}

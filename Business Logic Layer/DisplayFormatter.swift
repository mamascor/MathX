//
//  DisplayFormatter.swift
//  Calc
//
//  Created by Matthew Paul Harding on 23/01/2022.
//  Copyright © 2022 iOSB Free Ltd. All rights reserved.
//

import Foundation

struct DisplayFormatter {
    
    let maximumCharactersForDisplay: Int
    
    func formatForDisplay(number: Double) -> String? {
        if
            let currentTotal = auxTotalFormatter.string(from: NSNumber(value: number)),
                currentTotal.count > maximumCharactersForDisplay {
            return printScientificFormatter.string(from: NSNumber(value: number))
        } else {
            return printFormatter.string(from: NSNumber(value: number))
        }
    }
    
    let auxFormatter: NumberFormatter = {
        
        let formatter = NumberFormatter()
        let locale = Locale.current
        formatter.groupingSeparator = ""
        formatter.decimalSeparator = locale.decimalSeparator
        formatter.numberStyle = .decimal
        formatter.maximumIntegerDigits = 100
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 100
        return formatter
    }()
    
    let auxTotalFormatter: NumberFormatter = {
        
        let formatter = NumberFormatter()
        formatter.groupingSeparator = ""
        formatter.decimalSeparator = ""
        formatter.numberStyle = .decimal
        formatter.maximumIntegerDigits = 100
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 100
        return formatter
    }()
    
    // Formateo de valores por pantalla por defecto
    let printFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        let locale = Locale.current
        formatter.groupingSeparator = locale.groupingSeparator
        formatter.decimalSeparator = locale.decimalSeparator
        formatter.numberStyle = .decimal
        formatter.maximumIntegerDigits = 9
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 8
        return formatter
    }()
    
    // Formateo de valores por pantalla en formato científico
    let printScientificFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .scientific
        formatter.maximumFractionDigits = 3
        formatter.exponentSymbol = "e"
        return formatter
    }()
}

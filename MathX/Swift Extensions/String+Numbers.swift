//
//  String+Numbers.swift
//  MathX


import Foundation

extension String {
    //make string to doubli
    var doubleValue: Double? {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter.number(from: self)?.doubleValue
    }
}

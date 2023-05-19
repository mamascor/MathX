//
//  String+Prefix.swift
//  MathX



import Foundation

extension String {
    
    mutating func addPrefixIfNeeded(_ prefix: String) {
        guard hasPrefix(prefix) == false else { return }
        self = prefix + self
    }
    
    mutating func removePrefixIfNeeded(_ prefix: String) {
        guard hasPrefix(prefix) == true else { return }
        self = replacingOccurrences(of: prefix, with: "", options: NSString.CompareOptions.literal, range: nil)
    }
}

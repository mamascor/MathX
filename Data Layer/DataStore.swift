//
//  DataStore.swift
//  Calc
//
//  Created by Matthew Paul Harding on 01/01/22.
//  Copyright © 2022 iOSB Free Ltd. All rights reserved.
//

import Foundation

struct DataStore {
    
    let key: String
    
    func saveResult(_ number: Double) {
        UserDefaults.standard.set(number, forKey: key)
    }
    
    func loadResult() -> Double? {
        return UserDefaults.standard.double(forKey: key)
    }
}

//
//  UIButton+Decorate.swift
//  Calc
//
//  Created by Matthew Paul Harding on 01/01/22.
//  Copyright © 2022 iOSB Free Ltd. All rights reserved.
//

import UIKit

extension UIButton {
    
    func becomeRound() {
        clipsToBounds = true
        layer.cornerRadius = bounds.height / 2
    }

}

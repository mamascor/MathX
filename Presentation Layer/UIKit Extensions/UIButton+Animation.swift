//
//  UIButton+Animation.swift
//  Calc
//
//  Created by Matthew Paul Harding on 25/01/2022.
//

import UIKit

extension UIView {
    
    func bounce() {
        UIView.animate(withDuration: 0.1,
            animations: {
            self.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            self.alpha = 1
            },
            completion: { _ in
                UIView.animate(withDuration: 0.05) {
                    self.transform = CGAffineTransform.identity
                }
            })
    }
    
}

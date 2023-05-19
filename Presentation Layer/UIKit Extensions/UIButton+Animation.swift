//
//  UIButton+Animation.swift
//  MathX


import UIKit

extension UIButton {
    
    func bounce() {
        
        UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseOut) { [weak self] in
            self?.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            self?.alpha = 1
        } completion: { [weak self] _ in
            UIView.animate(withDuration: 0.15, delay: 0, options: .curveEaseInOut, animations: { [weak self] in
                self?.transform = CGAffineTransform.identity
            }, completion: nil)
        }
    }
}

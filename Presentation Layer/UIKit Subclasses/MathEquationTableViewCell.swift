//
//  MathEquationTableViewCell.swift
//  Calc
//
//  Created by Matthew Paul Harding on 26/01/2022.
//

import UIKit

class MathEquationTableViewCell: UITableViewCell {

    @IBOutlet var lhsLabel: UILabel!
    @IBOutlet var rhsLabel: UILabel!
    @IBOutlet var resultLabel: UILabel!
    @IBOutlet var tick: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        selectedBackgroundView = UIView()
        tick.alpha = 0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func displayTick() {
        bounce(tick)
    }

    private func bounce(_ view: UIView) {
        UIView.animate(withDuration: 0.25,
            animations: {
            view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            view.alpha = 1
            },
            completion: { _ in
                UIView.animate(withDuration: 0.1) {
                    view.transform = CGAffineTransform.identity
                }
            })
    }
    
}

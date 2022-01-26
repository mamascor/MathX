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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        selectedBackgroundView = UIView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}

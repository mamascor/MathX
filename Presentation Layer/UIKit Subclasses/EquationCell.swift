//
//  EquationCell.swift
//  MathX



import UIKit

class EquationCell: UITableViewCell {
    
    // MARK: - IBOutlets
    
    @IBOutlet var lhsLabel: UILabel!    // → 💡 Unwrapping Optionals: If this label is not connected then the app will crash!
    @IBOutlet var rhsLabel: UILabel!
    @IBOutlet var resultLabel: UILabel!
    @IBOutlet var tick: UIImageView!
    
    // MARK: - Initialise
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectedBackgroundView = UIView()
        tick.alpha = 0
    }
    
    // MARK: - Selected

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    // MARK: - Animation
    
    func displayTick() {
        bounce(tick)
    }

    private func bounce(_ view: UIView) {
        UIView.animate(withDuration: 0.25,
        animations: { [weak view] in
        view?.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        view?.alpha = 1
        },
        completion: { _ in
            UIView.animate(withDuration: 0.1) { [weak view] in
                view?.transform = CGAffineTransform.identity
            }
        })
    }
}

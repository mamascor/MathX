//
//  LogViewController.swift
//  Calc
//
//  Created by Matthew Paul Harding on 26/01/2022.
//
//
//  iOSB Free Ltd                   → All rights reserved
//  Website                         → https://www.iosbfree.com
//
//  👉 Free Courses                 → https://www.udemy.com/user/iosbfree
//
//  YouTube                         → https://www.youtube.com/channel/UCWBUOVRbtKNml4jN_4bRkCQ
//  Linked In                       → http://www.linkedin.com/in/mattharding-iosbfree
//  Tell us what you want to learn  → community@iosbfree.com
// *******************************************************************************************

import UIKit

class LogViewController: UITableViewController {

    private var datasource: [MathEquation] = []
    private var colorPalette: ColorPalette = DarkColorPalette()
    
    
    //MARK: - Set Datasource
    func setDataSource(_ newDatasource: [MathEquation]) {
        datasource = newDatasource
        tableView.reloadData()
    }
    
    func setTheme(_ theme: ColorPalette) {
        colorPalette = theme
        tableView.backgroundColor = UIColor(hex: colorPalette.background)
        tableView.separatorColor = UIColor(hex: colorPalette.operatorNormal)
        navigationItem.rightBarButtonItem?.tintColor = UIColor(hex: colorPalette.operatorNormal)
    }
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(self.doneButtoonPressed))
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return datasource.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MathEquationTableViewCell", for: indexPath) as? MathEquationTableViewCell else {
            return UITableViewCell()
        }
        
        cell.backgroundColor = UIColor(hex: colorPalette.background)
        cell.selectedBackgroundView?.backgroundColor = UIColor(hex: colorPalette.operatorNormal )
        cell.lhsLabel.textColor = UIColor(hex: colorPalette.display)
        cell.lhsLabel.highlightedTextColor = UIColor(hex: colorPalette.background)
        cell.rhsLabel.textColor = UIColor(hex: colorPalette.display)
        cell.rhsLabel.highlightedTextColor = UIColor(hex: colorPalette.background)
        cell.resultLabel.textColor = UIColor(hex: colorPalette.display)
        cell.resultLabel.highlightedTextColor = UIColor(hex: colorPalette.background)
        
        cell.tick.tintColor = UIColor(hex: colorPalette.operatorTitle)
        
        let mathEquation = datasource[indexPath.row]
        cell.lhsLabel.text = mathEquation.lhs.formatted()
        cell.rhsLabel.text = mathEquation.stringRepresentationOfOperator + " " + (mathEquation.rhs?.formatted() ?? "")
        cell.resultLabel.text = "= " + (mathEquation.result?.formatted() ?? "")
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let cell = tableView.cellForRow(at: indexPath) as? MathEquationTableViewCell else { return }
        
        let mathEquation = datasource[indexPath.row]
        let userInfo: [AnyHashable: Any] = ["iOSBFree.com.calc.LogViewController.pasteMathEquation": mathEquation]
        NotificationCenter.default.post(name: Notification.Name("iOSBFree.com.calc.LogViewController.pasteMathEquation"), object: nil, userInfo: userInfo)
        
        view.isUserInteractionEnabled = false
        cell.displayTick()
        dismissAfterDelay()
    }
    
    private func dismissAfterDelay() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            self?.dismiss(animated: true, completion: nil)
        }
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @objc private func doneButtoonPressed() {
        dismiss(animated: true, completion: nil)
    }
}

//
//  HistoryTableCell.swift
//  recruitment-sdd_study_case_1
//
//  Created by Jonathan Kristian on 03/04/24.
//

import UIKit

class HistoryTableCell: UITableViewCell {
    
    @IBOutlet weak var name_lab: UILabel!
    @IBOutlet weak var transID_lab: UILabel!
    @IBOutlet weak var value_lab: UILabel!
    var thisTransaction: Transaction?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupCell(thisTransaction: Transaction?){
        self.thisTransaction = thisTransaction
        
        self.name_lab.text = "(\(thisTransaction?.bankName ?? "-")) \(thisTransaction?.merchName ?? "-")"
        
        self.transID_lab.text = thisTransaction?.transID
        
        if thisTransaction?.type ?? "credits" == "credits"{
            self.value_lab.text = "- Rp.\(  (thisTransaction?.value ?? 0).formatted() )"
            self.value_lab.textColor = UIColor.red
        }else{
            self.value_lab.text = "Rp.\(  (thisTransaction?.value ?? 0).formatted() )"
            self.value_lab.textColor = UIColor.green
        }
    }

}

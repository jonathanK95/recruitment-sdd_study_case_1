//
//  TransactionController.swift
//  recruitment-sdd_study_case_1
//
//  Created by Jonathan Kristian on 03/04/24.
//

import UIKit

protocol TransactionDelegate: AnyObject{
    func payAction(thisTransaction: Transaction)
}

class TransactionController: UIViewController {
    
    
    @IBOutlet weak var receiverName_lab: UILabel!
    @IBOutlet weak var transID_lab: UILabel!
    @IBOutlet weak var value_lab: UILabel!
    @IBOutlet weak var myBalance_lab: UILabel!
    @IBOutlet weak var pay_btn: UIButton!
    
    var thisTransaction: Transaction?
    var thisUser: User?
    
    var delegate: TransactionDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()

        // Do any additional setup after loading the view.
    }
    
    
    func setupView(){
        self.receiverName_lab.text = "(\(self.thisTransaction?.bankName ?? "-")) \(self.thisTransaction?.merchName ?? "-")"
        self.transID_lab.text = "(\(self.thisTransaction?.bankName ?? "-"))"
        
        self.value_lab.text = "Rp.\( (self.thisTransaction?.value ?? 0).formatted() )"
        
        self.myBalance_lab.text = "Rp.\( (self.thisUser?.balance ?? 0).formatted() )"
    
        if self.thisUser?.balance ?? 0 >= self.thisTransaction?.value ?? 0{
            self.pay_btn.backgroundColor = UIColor.systemBlue
        }else{
            self.pay_btn.backgroundColor = UIColor.lightGray
        }
    }
    
    
    @IBAction func payAction(_ sender: Any) {
        if self.thisUser?.balance ?? 0 >= self.thisTransaction?.value ?? 0{
            let ac = UIAlertController(title: "Transaction Successful", message: "Yei, you've just made a transaction for Rp.\((self.thisTransaction?.value ?? 0).formatted()).", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
                self.delegate?.payAction(thisTransaction: self.thisTransaction!)
                self.navigationController?.popViewController(animated: true)
            }))
            self.present(ac, animated: true)
        }else{
            let ac = UIAlertController(title: "Insufficient Saldo", message: "Your saldo is insufficient for this transaction.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Ok", style: .default))
            self.present(ac, animated: true)
//
        }
    }
    

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

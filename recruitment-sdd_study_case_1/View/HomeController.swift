//
//  HomeController.swift
//  recruitment-sdd_study_case_1
//
//  Created by Jonathan Kristian on 03/04/24.
//

import UIKit

class HomeController: UIViewController {
    
    @IBOutlet weak var profile_img: UIImageView!
    @IBOutlet weak var name_lab: UILabel!
    @IBOutlet weak var balance_lab: UILabel!
    
    var thisUser: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadUserHistory()
        self.setupView()
        
        // MARK: - Navigation
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
    
    @IBAction func topUpAction() {
        guard let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TopUpController") as? TopUpController else { return }
        vc.delegate = self
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func payAction() {
        guard let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "QRPaymentController") as? QRPaymentController else { return }
        vc.delegate = self
        vc.modalPresentationStyle = .formSheet
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func historyAction() {
        
        guard let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HistoryController") as? HistoryController else { return }
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    

    func setupView(){
        self.name_lab.text = self.thisUser?.name
        self.balance_lab.text = "Rp. \( (self.thisUser?.balance ?? 0).formatted() )"
        self.profile_img.image = self.thisUser?.image
    }
}

// MARK: - Load History Data
extension HomeController{
    func loadUserHistory(){
        self.thisUser = User(dictionary: [
            "name" : "Jonathan Kristian",
            "balance" : 1000000,
            "image": UIImage(named: "Profile") ?? UIImage(systemName: "person.fill")!,
            "history": [
                ["bankName" : "BNI",
                 "transID" : "ID12345670",
                 "merchName" : "MERCHANT History MOCK TEST 1",
                 "value" : 50000,
                 "type" : "credits"],
                
                ["bankName" : "BRI",
                 "transID" : "ID12345671",
                 "merchName" :  "MERCHANT History MOCK TEST 2",
                 "value" : 100000,
                 "type" : "credits"],
                
                ["bankName" : "BRI",
                 "transID" : "ID12345672",
                 "merchName" :  "MERCHANT History MOCK TEST 2",
                 "value" : 20000,
                 "type" : "credits"],
            ]
        ])
    }
}

// MARK: - Top Up Delegate
extension HomeController: TopUpDelegate{
    func addBalance(value: Int) {
        self.thisUser?.balance =  (self.thisUser?.balance ?? 0) + value
        self.thisUser?.history.append(Transaction(dictionary: [
            "bankName" : "BNI",
            "transID" : "D_\(Date.currentTimeStamp)",
            "merchName" : "Top Up Rekening Pribadi",
            "value" : value,
            "type" : "debits"
        ])!)
        self.balance_lab.text = "Rp. \( (self.thisUser?.balance ?? 0).formatted() )"
        
    }
}

// MARK: - Top Up Delegate
extension HomeController: QRPaymentDelegate{
    func finalizeTransaction(transaction: Transaction) {
        guard let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TransactionController") as? TransactionController else { return }
        vc.thisUser = self.thisUser
        vc.thisTransaction = transaction
        vc.delegate = self
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: -  Transaction Delegate
extension HomeController: TransactionDelegate{
    func payAction(thisTransaction: Transaction) {
        self.thisUser?.balance =  (self.thisUser?.balance ?? 0) - thisTransaction.value
        self.thisUser?.history.append(thisTransaction)
        self.balance_lab.text = "Rp. \( (self.thisUser?.balance ?? 0).formatted() )"
    }
}

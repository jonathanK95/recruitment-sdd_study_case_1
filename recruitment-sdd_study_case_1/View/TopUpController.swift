//
//  TopUpController.swift
//  recruitment-sdd_study_case_1
//
//  Created by Jonathan Kristian on 03/04/24.
//

import UIKit

protocol TopUpDelegate: AnyObject{
    func addBalance(value: Int)
}

class TopUpController: UIViewController {
    var delegate: TopUpDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func add10k_action() {
        let ac = UIAlertController(title: "Top Up Successful", message: "Yei, you've just made a top up for Rp.10.000", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
            self.delegate?.addBalance(value: 10000)
        }))
        self.present(ac, animated: true)
    }
    
    @IBAction func add20k_action() {
        let ac = UIAlertController(title: "Top Up Successful", message: "Yei, you've just made a top up for Rp.20.000", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
            self.delegate?.addBalance(value: 20000)
        }))
        self.present(ac, animated: true)
    }
    
    @IBAction func add50k_action() {
        let ac = UIAlertController(title: "Top Up Successful", message: "Yei, you've just made a top up for Rp.50.000", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
            self.delegate?.addBalance(value: 50000)
        }))
        self.present(ac, animated: true)
    }
    
    @IBAction func add100k_action() {
        let ac = UIAlertController(title: "Top Up Successful", message: "Yei, you've just made a top up for Rp.100.000", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
            self.delegate?.addBalance(value: 100000)
        }))
        self.present(ac, animated: true)
    }
    
    @IBAction func add200k_action() {
        
        let ac = UIAlertController(title: "Top Up Successful", message: "Yei, you've just made a top up for Rp.200.000", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
            self.delegate?.addBalance(value: 200000)
        }))
        self.present(ac, animated: true)
    }
    
    @IBAction func add500k_action() {
        let ac = UIAlertController(title: "Top Up Successful", message: "Yei, you've just made a top up for Rp.500.000", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
            self.delegate?.addBalance(value: 500000)
        }))
        self.present(ac, animated: true)
    }
    
    @IBAction func add1M_action() {
        let ac = UIAlertController(title: "Top Up Successful", message: "Yei, you've just made a top up for Rp.1.000.000", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
            self.delegate?.addBalance(value: 1000000)
        }))
        self.present(ac, animated: true)
    }
    
    @IBAction func add2M_action() {
        let ac = UIAlertController(title: "Top Up Successful", message: "Yei, you've just made a top up for Rp.2.000.000", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
            self.delegate?.addBalance(value: 2000000)
        }))
        self.present(ac, animated: true)
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

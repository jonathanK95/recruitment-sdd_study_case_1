//
//  ViewController.swift
//  recruitment-sdd_study_case_1
//
//  Created by Jonathan Kristian on 03/04/24.
//

import UIKit

class ViewController: UIViewController {
    
    var thisUser: User?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.userSetup()
        // Do any additional setup after loading the view.
    }
    
    func userSetup(){
        self.thisUser = User(dictionary: [
            "name" : "Jonathan Kristian",
            "balance" : 1000000,
            "image": UIImage(named: "Profile") ?? UIImage(systemName: "person.fill")!
        ])
    }
}


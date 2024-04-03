//
//  User.swift
//  recruitment-sdd_study_case_1
//
//  Created by Jonathan Kristian on 03/04/24.
//

import Foundation
import UIKit

final class User: NSObject {
    var name: String = ""
    var balance: Int = 0
    var image: UIImage?
    var history: [Transaction] = []
    
    init?(dictionary: [String: Any]) {
        
        if let name = dictionary["name"] as? String {
            self.name = name
        }
        
        if let balance = dictionary["balance"] as? Int {
            self.balance = balance
        }
        
        if let image = dictionary["image"] as? UIImage {
            self.image = image
        }

        if let transactions = dictionary["history"] as? [[String: Any]] {
            var temp:[Transaction] = []
            for row in transactions{
                temp.append( Transaction(dictionary: row)! )
            }
            self.history = temp
            
        }
    }
}

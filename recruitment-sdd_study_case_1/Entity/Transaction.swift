//
//  Transaction.swift
//  recruitment-sdd_study_case_1
//
//  Created by Jonathan Kristian on 03/04/24.
//

import Foundation

final class Transaction: NSObject {
    var bankName: String = ""
    var transID: String = ""
    var merchName: String = ""
    var value: Int = 0
    var type: String = "credits"
    
    init?(dictionary: [String: Any]) {
        if let bankName = dictionary["bankName"] as? String {
            self.bankName = bankName
        }
        if let transID = dictionary["transID"] as? String {
            self.transID = transID
        }
        if let merchName = dictionary["merchName"] as? String {
            self.merchName = merchName
        }
        
        if let value = dictionary["value"] as? Int {
            self.value = value
        }
        
        if let type = dictionary["type"] as? String {
            self.type = type
        }
    }
}

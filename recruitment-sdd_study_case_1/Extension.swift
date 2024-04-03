//
//  Extension.swift
//  recruitment-sdd_study_case_1
//
//  Created by Jonathan Kristian on 03/04/24.
//

import Foundation

extension Date {
    static var currentTimeStamp: Int64{
        return Int64(Date().timeIntervalSince1970 * 1000)
    }
}

//
//  recruitment_sdd_study_case_1Tests.swift
//  recruitment-sdd_study_case_1Tests
//
//  Created by Jonathan Kristian on 03/04/24.
//

import XCTest

@testable import recruitment_sdd_study_case_1

final class recruitment_sdd_study_case_1Tests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testUserInitializer() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
        
        let thisUser = User(dictionary: [
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
    
        XCTAssertEqual(thisUser?.name, "Jonathan Kristian")
        XCTAssertEqual(thisUser?.balance, 1000000)
        XCTAssertEqual(thisUser?.history.count, 3)
        XCTAssertEqual(thisUser?.history[0].value, 50000)
        
    }
    

    func testTransactionInitializer() throws {
        let thisTransaction = Transaction(dictionary: ["bankName" : "BRI",
                                                       "transID" : "ID12345672",
                                                       "merchName" :  "MERCHANT History MOCK TEST 2",
                                                       "value" : 20000,
                                                       "type" : "credits"])
        XCTAssertEqual(thisTransaction?.bankName, "BRI")
        XCTAssertEqual(thisTransaction?.transID, "ID12345672")
        XCTAssertEqual(thisTransaction?.merchName, "MERCHANT History MOCK TEST 2")
        XCTAssertEqual(thisTransaction?.value, 20000)
        XCTAssertEqual(thisTransaction?.type, "credits")
        
    }

    func testPerformance() throws {
        // This is an example of a performance test case.
        var vc = HomeController()
        
        self.measure {
            vc.loadUserHistory()
            // Put the code you want to measure the time of here.
        }
    }

}

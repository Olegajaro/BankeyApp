//
//  AccountTests.swift
//  BankeyAppUnitTests
//
//  Created by Олег Федоров on 19.01.2022.
//

import Foundation
import XCTest

@testable import BankeyApp

class AccountTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    func testCanParse() throws {
        let json = """
         [
           {
             "id": "1",
             "type": "Banking",
             "name": "Basic Savings",
             "amount": 929466.23,
             "createdDateTime" : "2010-06-21T15:29:32Z"
           },
           {
             "id": "2",
             "type": "Banking",
             "name": "No-Fee All-In Chequing",
             "amount": 17562.44,
             "createdDateTime" : "2011-06-21T15:29:32Z"
           },
          ]
        """
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        
        guard
            let data = json.data(using: .utf8),
            let result = try? decoder.decode([Account].self, from: data)
        else { return }
        
        XCTAssertEqual(result.count, 2)
        
        let account1 = result[0]
         
        XCTAssertEqual(account1.id, "1")
        XCTAssertEqual(account1.type, .banking)
        XCTAssertEqual(account1.name, "Basic Savings")
        XCTAssertEqual(account1.amount, 929466.23)
        XCTAssertEqual(account1.createdDateTime.monthDayYearString, "Jun 21, 2010")
    }
}

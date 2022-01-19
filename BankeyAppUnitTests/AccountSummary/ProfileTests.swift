//
//  ProfileTests.swift
//  BankeyAppUnitTests
//
//  Created by Олег Федоров on 19.01.2022.
//

import Foundation
import XCTest

@testable import BankeyApp

class ProfileTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    func testCanParse() throws {
        let json = """
        {
        "id": "1"
        "first_name": "Kevin"
        "last_name": "Flynn"
        }
        """
        
        guard
            let data = json.data(using: .utf8),
            let result = try? JSONDecoder().decode(Profile.self, from: data)
        else { return }
        
        XCTAssertEqual(result.id, "1")
        XCTAssertEqual(result.firstName, "Kevin")
        XCTAssertEqual(result.lastName, "Flynn")
    }
}

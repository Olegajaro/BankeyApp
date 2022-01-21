//
//  AccountSummaryViewControllerTests.swift
//  BankeyAppUnitTests
//
//  Created by Олег Федоров on 21.01.2022.
//

import Foundation
import XCTest

@testable import BankeyApp

class AccountSummaryViewControllerTests: XCTestCase {
    var vc: AccountSummaryViewController!
    var mockManager: MockProfileManager!
    
    class MockProfileManager: ProfileManageable {
        var profile: Profile?
        var error: NetworkError?
        
        func fetchProfile(
            forUserID userID: String,
            completion: @escaping (Result<Profile, NetworkError>) -> Void
        ) {
            if error != nil {
                completion(.failure(error!))
                return
            }
            profile = Profile(id: "1", firstName: "FirstName", lastName: "LastName")
            completion(.success(profile!))
        }
    }
    
    override func setUp() {
        super.setUp()
        vc = AccountSummaryViewController()
//        vc.loadViewIfNeeded()
        
        mockManager = MockProfileManager()
        vc.profileManager = mockManager
    }
    
    func testTitleAndMessageForServerError() throws {
        let titleAndMessage = vc.titleAndMessageForTesting(for: .serverError)
        
        XCTAssertEqual("Server Error", titleAndMessage.0)
        XCTAssertEqual("Ensure you are connected to the internet. Please try again.",
                       titleAndMessage.1)
    }
    
    func testTitleAndMessageForResponseError() throws {
        let titleAndMessage = vc.titleAndMessageForTesting(for: .responseError)
        
        XCTAssertEqual("Response Error", titleAndMessage.0)
        XCTAssertEqual("Problem with the response from the server. Please try again.",
                       titleAndMessage.1)
    }
    
    func testTitleAndMessageForDecodingError() throws {
        let titleAndMessage = vc.titleAndMessageForTesting(for: .decodingError)
        
        XCTAssertEqual("Decoding Error", titleAndMessage.0)
        XCTAssertEqual("We could not process your request. Please try again.",
                       titleAndMessage.1)
    }
    
    func testAlertForServerError() throws {
        mockManager.error = NetworkError.serverError
        vc.forceFetchProfile()
        
        XCTAssertEqual("Server Error", vc.errorAlert.title)
        XCTAssertEqual("Ensure you are connected to the internet. Please try again.",
                       vc.errorAlert.message)
    }
    
    func testAlertForResponseError() throws {
        mockManager.error = NetworkError.responseError
        vc.forceFetchProfile()
        
        XCTAssertEqual("Response Error", vc.errorAlert.title)
        XCTAssertEqual("Problem with the response from the server. Please try again.",
                       vc.errorAlert.message)
    }
    
    func testAlertForDecodingError() throws {
        mockManager.error = NetworkError.decodingError
        vc.forceFetchProfile()
        
        XCTAssertEqual("Decoding Error", vc.errorAlert.title)
        XCTAssertEqual("We could not process your request. Please try again.",
                       vc.errorAlert.message)
    }
}

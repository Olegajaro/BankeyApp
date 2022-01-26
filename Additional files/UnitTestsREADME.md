# Unit Tests

____

## CurrencyFormatterTests

Произведено тестирование методов структуры CurrencyFormatter, чтобы проверить формат получаемых значений.

```swift
class Test: XCTestCase {
    
    var formatter: CurrencyFormatter!
    
    override func setUp() {
        super.setUp()
        
        formatter = CurrencyFormatter()
    }
    
    func testShouldBeVisible() throws {
        let result = formatter.breakIntoDollarsAndCents(929466.23)
        XCTAssertEqual(result.0, "929,466")
        XCTAssertEqual(result.1, "23")
    }
    
    func testDollarsFormatted() throws {
        let result = formatter.dollarsFormatted(929466.23)
        XCTAssertEqual(result, "$929,466.23")
    }
    
    func testZeroDollarsFormatted() throws {
        let result = formatter.dollarsFormatted(0)
        XCTAssertEqual(result, "$0.00")
    }
    
    func testDollarsFormattedWithCurrencySymbol() throws {
        let locale = Locale.current
        let currencySymbol = locale.currencySymbol!
        
        let result = formatter.dollarsFormatted(929466.23)
        print("\(currencySymbol)")
        XCTAssertEqual(result, "\(currencySymbol)929,466.23")
    }
}
```
## ProfileTests & AccountTests

Протестировано правильность декодирования данных из JSON файлов, представляющих собой профиль и аккаунты клиента. __[ProfileTests](https://github.com/Olegajaro/BankeyApp/blob/main/BankeyAppUnitTests/AccountSummary/ProfileTests.swift)__.

```swift
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
```

## AccountSummaryViewControllerTestsTests

Для класса AccountSummaryViewController произведено тестирование методов для отображения названий и сообщений предупреждающих об ошибке, содержащихся в errorAlert.
Так же с помощью мок объекта MockProfileManager реализована имитация ошибки, для того, чтобы другим способом получить аналогичные сообщения об ошибках для разных сценариев NetworkError.
```swift
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
```





















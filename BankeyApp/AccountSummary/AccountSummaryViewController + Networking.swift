//
//  AccountSummaryViewController + Networking.swift
//  BankeyApp
//
//  Created by Олег Федоров on 19.01.2022.
//

import Foundation



struct Account: Codable {
    let id: String
    let type: AccountType
    let name: String
    let amount: Decimal
    let createdDateTime: Date
    
    static func makeSkeleton() -> Account {
        Account(
            id: "1", type: .banking, name: "Account name",
            amount: 0.0, createdDateTime: Date()
        )
    }
}

extension AccountSummaryViewController {
        
    func fetchAccounts(
        forUserID userID: String,
        completion: @escaping (Result<[Account], NetworkError>) -> Void
    ) {
        guard
            let url = URL(string: "https://fierce-retreat-36855.herokuapp.com/bankey/profile/\(userID)/accounts")
        else { return }
        
        let urlSession = URLSession.shared
        
        let task = urlSession.dataTask(with: url) { data, response, error in
            
            guard let data = data, error == nil else {
                completion(.failure(.serverError))
                print("DEBUG: error here...1")
                return
            }
            
            guard
                let httpResponse = response as? HTTPURLResponse,
                (200...299).contains(httpResponse.statusCode)
            else {
                completion(.failure(.responseError))
                print("DEBUG: error here...2")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                
                let accounts = try decoder.decode([Account].self, from: data)
                DispatchQueue.main.async {
                    completion(.success(accounts))
                }
            } catch {
                completion(.failure(.decodingError))
                print("DEBUG: error here...3")
            }
        }
        
        task.resume()
    }
}

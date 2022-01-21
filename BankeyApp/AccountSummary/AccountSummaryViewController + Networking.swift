//
//  AccountSummaryViewController + Networking.swift
//  BankeyApp
//
//  Created by Олег Федоров on 19.01.2022.
//

import Foundation

enum NetworkError: Error {
    case serverError
    case responseError
    case decodingError
}

struct Profile: Codable {
    let id: String
    let firstName: String
    let lastName: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
    }
}

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
    
    func fetchProfile(
        forUserID userID: String,
        completion: @escaping (Result<Profile, NetworkError>) -> Void
    ) {
        guard
            let url = URL(string: "https://fierce-retreat-36855.herokuapp.com/bankey/profile/\(userID)")
        else { return }

        let urlSession = URLSession.shared

        let task = urlSession.dataTask(with: url) { data, response, error in

            guard let data = data, error == nil else {
                completion(.failure(.serverError))
                return
            }

            guard
                let httpResponse = response as? HTTPURLResponse,
                (200...299).contains(httpResponse.statusCode)
            else {
                completion(.failure(.responseError))
                return
            }

            do {
                let profile = try JSONDecoder().decode(Profile.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(profile))
                }
            } catch {
                completion(.failure(.decodingError))
            }
        }

        task.resume()
    }
    
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

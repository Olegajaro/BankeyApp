//
//  ProfileManager.swift
//  BankeyApp
//
//  Created by Олег Федоров on 21.01.2022.
//

import Foundation

protocol ProfileManageable: AnyObject {
    func fetchProfile(
        forUserID userID: String,
        completion: @escaping (Result<Profile, NetworkError>) -> Void
    )
}

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

class ProfileManager {
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

}

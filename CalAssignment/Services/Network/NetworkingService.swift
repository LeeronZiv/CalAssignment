//
//  NetworkingService.swift
//  CalAssignment
//
//  Created by Leeron Ziv on 19/11/2024.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError(Error)
    case serverError(Int)
    case unknown(Error)
}

class NetworkService {
    static let shared = NetworkService()
    private init() {}

    /// Perform a network request and decode the result
    /// - Parameters:
    ///   - urlString: The URL string for the request
    ///   - completion: A completion handler returning the decoded object or an error
    func request<T: Codable>(
        from urlString: String,
        completion: @escaping (Result<T, NetworkError>) -> Void
    ) {
        guard let url = URL(string: urlString) else {
            completion(.failure(.invalidURL))
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(.unknown(error)))
                return
            }

            if let httpResponse = response as? HTTPURLResponse, !(200...299).contains(httpResponse.statusCode) {
                completion(.failure(.serverError(httpResponse.statusCode)))
                return
            }

            guard let data = data else {
                completion(.failure(.noData))
                return
            }

            // Decode the JSON
            do {
                let decodedObject = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedObject))
            } catch {
                completion(.failure(.decodingError(error)))
            }
        }

        task.resume()
    }
}

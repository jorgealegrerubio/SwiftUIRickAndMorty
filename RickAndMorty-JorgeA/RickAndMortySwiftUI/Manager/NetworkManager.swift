//
//  Network.swift
//  RickAndMortySwiftUI
//
//  Created by Jorge on 16/4/24.
//

import Foundation

enum NetworkError: Error {
    case badURL
    case badResponse
    case decodeError
    case badRequest
    case invalidResponse
}

final class Network {
    static let shared = Network()
    func fetchData<T: Decodable>(this url: URLRequest, of type: T.Type) async throws -> T {
        do {
            let (data, response) = try await URLSession.shared.data(for: url)
            guard let response = response as? HTTPURLResponse else {
                throw NetworkError.invalidResponse
            }
            let decoder = JSONDecoder()
            do {
                if (200..<300).contains(response.statusCode) {
                    print("☎️ [\(response.statusCode)] \(response.url?.absoluteString ?? "-")")
                    return try decoder.decode(T.self, from: data)
                } else {
                    throw NetworkError.badResponse
                }
            } catch {
                throw NetworkError.decodeError
            }
        } catch {
            throw NetworkError.badRequest
        }
    }
}

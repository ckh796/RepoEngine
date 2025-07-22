//
//  APIService.swift
//  RepoEngine
//
//  Created by Charbel Khalifeh Hachem on 21/07/2025.
//

import Foundation
import Combine

protocol APIServiceProtocol {
    func request<T: Decodable>(_ type: T.Type, from url: URL) -> AnyPublisher<T, Error>
}

final class APIService: APIServiceProtocol {
    func request<T: Decodable>(_ type: T.Type, from url: URL) -> AnyPublisher<T, Error> {
        URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { result -> Data in
                guard let httpResponse = result.response as? HTTPURLResponse,
                      (200...299).contains(httpResponse.statusCode) else {
                    throw URLError(.badServerResponse)
                }
                return result.data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}

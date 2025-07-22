//
//  RepositoryServiceImpl.swift
//  RepoEngine
//
//  Created by Charbel Khalifeh Hachem on 21/07/2025.
//

import Foundation
import Combine

final class RepositoryServiceImpl: RepositoryServiceProtocol {
    private let apiService: APIServiceProtocol
    private let org: String

    init(apiService: APIServiceProtocol = APIService(), org: String = "google") {
        self.apiService = apiService
        self.org = org
    }

    func fetchRepositories(
        org: String,
        page: Int,
        perPage: Int,
        searchQuery: String?
    ) -> AnyPublisher<[RepositoryEntity], Error> {
        var components = URLComponents(string: "https://api.github.com/orgs/\(org)/repos")!
        components.queryItems = [
            URLQueryItem(name: "page", value: "\(page)"),
            URLQueryItem(name: "per_page", value: "\(perPage)")
        ]

        guard let url = components.url else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }

        return apiService
            .request([RepositoryDTO].self, from: url)
            .map { dtos in
                let entities = dtos.map { $0.toEntity() }
                if let query = searchQuery?.lowercased(), !query.isEmpty {
                    return entities.filter { $0.name.lowercased().contains(query) }
                }
                return entities
            }
            .eraseToAnyPublisher()
    }
}


//
//  MockRepositoryProvider.swift
//  RepoEngine
//
//  Created by Charbel Khalifeh Hachem on 22/07/2025.
//

import Foundation
import Combine

class MockRepositoryProvider: RepositoryProviding {
    var cachedRepositories: [RepositoryEntity] = []
    
    func fetchRepositories(searchQuery: String?, reset: Bool) -> AnyPublisher<[RepositoryEntity], Error> {
        let dummy = [RepositoryEntity(id: 1, name: "Test", createdAt: Date(), avatarURL: nil, stargazersCount: 10)]
        return Just(dummy)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}

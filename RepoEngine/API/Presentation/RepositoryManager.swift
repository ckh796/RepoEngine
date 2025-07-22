//
//  RepositoryManager.swift
//  RepoEngine
//
//  Created by Charbel Khalifeh Hachem on 22/07/2025.
//

import Foundation
import Combine

final class RepositoryManager: RepositoryProviding {
    static let shared = RepositoryManager()

    private init() {}

    // MARK: - Dependencies
    private lazy var useCase: FetchRepositoriesUseCaseProtocol = {
        let service = RepositoryServiceImpl()
        return FetchRepositoriesUseCaseImpl(repositoryService: service)
    }()

    // MARK: - Cache
    private(set) var cachedRepositories: [RepositoryEntity] = []
    private var currentPage: Int = 1
    private var canLoadMore: Bool = true
    private let perPage = 20

    // MARK: - Fetch
    func fetchRepositories(searchQuery: String? = nil, reset: Bool = false) -> AnyPublisher<[RepositoryEntity], Error> {
        if reset {
            currentPage = 1
            canLoadMore = true
            cachedRepositories = []
        }

        guard canLoadMore else {
            return Just(cachedRepositories)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }

        return useCase.execute(org: "google", page: currentPage, perPage: perPage, searchQuery: searchQuery)
            .map { [weak self] newRepos -> [RepositoryEntity] in
                guard let self = self else { return [] }

                if reset {
                    self.cachedRepositories = newRepos
                } else {
                    self.cachedRepositories.append(contentsOf: newRepos)
                }

                self.canLoadMore = newRepos.count == self.perPage
                self.currentPage += 1

                return self.cachedRepositories // ✅ return full cache always
            }
            .eraseToAnyPublisher()
    }

    func clearCache() {
        cachedRepositories = []
        currentPage = 1
        canLoadMore = true
    }
}


protocol RepositoryProviding {
    var cachedRepositories: [RepositoryEntity] { get }
    func fetchRepositories(searchQuery: String?, reset: Bool) -> AnyPublisher<[RepositoryEntity], Error>
}

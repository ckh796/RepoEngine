//
//  FetchRepositoriesUseCaseImpl.swift
//  RepoEngine
//
//  Created by Charbel Khalifeh Hachem on 21/07/2025.
//

import Foundation
import Combine

final class FetchRepositoriesUseCaseImpl: FetchRepositoriesUseCaseProtocol {
    private let repositoryService: RepositoryServiceProtocol

    init(repositoryService: RepositoryServiceProtocol) {
        self.repositoryService = repositoryService
    }

    func execute(
        org: String,
        page: Int,
        perPage: Int,
        searchQuery: String?
    ) -> AnyPublisher<[RepositoryEntity], Error> {
        repositoryService.fetchRepositories(
            org: org,
            page: page,
            perPage: perPage,
            searchQuery: searchQuery
        )
    }
}

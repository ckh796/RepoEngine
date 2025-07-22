//
//  FetchRepositoriesUseCase.swift.swift
//  RepoEngine
//
//  Created by Charbel Khalifeh Hachem on 21/07/2025.
//

import Combine
import Foundation

protocol FetchRepositoriesUseCaseProtocol {
    func execute(
        org: String,
        page: Int,
        perPage: Int,
        searchQuery: String?
    ) -> AnyPublisher<[RepositoryEntity], Error>
}

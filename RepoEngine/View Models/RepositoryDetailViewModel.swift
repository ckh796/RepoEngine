//
//  RepositoryDetailViewModel.swift
//  RepoEngine
//
//  Created by Charbel Khalifeh Hachem on 22/07/2025.
//

import Foundation

final class RepositoryDetailViewModel: ObservableObject {
    @Published private(set) var name: String = ""
    @Published private(set) var createdAt: String = ""
    @Published private(set) var avatarURL: URL?
    @Published private(set) var stargazersCount: Int = 0

    private var isInitialized = false

    func initialize(with repo: RepositoryUIModel) {
        guard !isInitialized else { return }
        isInitialized = true

        print("🚀 Opening Detail for:", repo.name)

        self.name = repo.name
        self.createdAt = repo.createdAt
        self.avatarURL = repo.avatarURL
        self.stargazersCount = repo.stargazersCount
    }
}

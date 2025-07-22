//
//  RepositoryUIModel.swift
//  RepoEngine
//
//  Created by Charbel Khalifeh Hachem on 21/07/2025.
//

import Foundation

struct RepositoryUIModel: Identifiable, Hashable {
    let id: Int
    let name: String
    let createdAt: String
    let avatarURL: URL?
    let stargazersCount: Int

    init(entity: RepositoryEntity) {
        self.id = entity.id
        self.name = entity.name
        self.createdAt = RepositoryUIModel.formatDate(entity.createdAt)
        self.avatarURL = entity.avatarURL
        self.stargazersCount = entity.stargazersCount
    }

    private static func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter.string(from: date)
    }
}

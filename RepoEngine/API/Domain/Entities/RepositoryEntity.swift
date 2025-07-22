//
//  RepositoryEntity.swift
//  RepoEngine
//
//  Created by Charbel Khalifeh Hachem on 21/07/2025.
//

import Foundation

struct RepositoryEntity: Identifiable {
    let id: Int
    let name: String
    let createdAt: Date
    let avatarURL: URL?
    let stargazersCount: Int
}

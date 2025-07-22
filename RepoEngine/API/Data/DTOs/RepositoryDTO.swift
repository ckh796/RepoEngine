//
//  RepositoryDTO.swift
//  RepoEngine
//
//  Created by Charbel Khalifeh Hachem on 21/07/2025.
//

import Foundation

struct RepositoryDTO: Decodable {
    let id: Int
    let name: String
    let created_at: String
    let owner: OwnerDTO
    let stargazers_count: Int

    struct OwnerDTO: Decodable {
        let avatar_url: String
    }

    func toEntity() -> RepositoryEntity {
        RepositoryEntity(
            id: id,
            name: name,
            createdAt: ISO8601DateFormatter().date(from: created_at) ?? Date(),
            avatarURL: URL(string: owner.avatar_url),
            stargazersCount: stargazers_count
        )
    }
}

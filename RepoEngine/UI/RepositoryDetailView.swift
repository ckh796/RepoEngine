//
//  RepositoryDetailView.swift
//  RepoEngine
//
//  Created by Charbel Khalifeh Hachem on 22/07/2025.
//

import Foundation
import SwiftUI
import Kingfisher



struct RepositoryDetailView: View {
    let repo: RepositoryUIModel
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                // Close button
                HStack {
                    Spacer()
                    Button(action: {
                        dismiss()
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .resizable()
                            .frame(width: 24, height: 24)
                            .foregroundColor(.secondary)
                    }
                }

                // Avatar Image centered
                KFImage(repo.avatarURL)
                    .resizable()
                    .placeholder { ProgressView() }
                    .scaledToFill()
                    .frame(width: 100, height: 100)
                    .clipShape(Circle())
                    .shadow(radius: 6)
                    .frame(maxWidth: .infinity, alignment: .center)

                // Left-aligned repo details
                VStack(alignment: .leading, spacing: 16) {
                    DetailRow(title: "Repository Name", value: repo.name)
                    DetailRow(title: "Created At", value: repo.createdAt)
                    DetailRow(title: "Stargazers", value: "\(repo.stargazersCount)")
                }
            }
            .padding()
        }
        .navigationTitle(repo.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

private struct DetailRow: View {
    let title: String
    let value: String

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .font(.caption)
                .foregroundColor(.secondary)
            Text(value)
                .font(.body)
        }
    }
}

//
//  RepositoryRow.swift
//  RepoEngine
//
//  Created by Charbel Khalifeh Hachem on 21/07/2025.
//

import SwiftUI
import Kingfisher

struct RepositoryRow: View {
    let repo: RepositoryUIModel

    var body: some View {
        HStack(spacing: 12) {
            KFImage(repo.avatarURL)
                .placeholder {
                    ProgressView()
                        .frame(width: 44, height: 44)
                }
                .retry(maxCount: 2, interval: .seconds(1))
                .onFailure { error in
                    print("Image load failed: \(error.localizedDescription)")
                }
                .resizable()
                .scaledToFill()
                .frame(width: 44, height: 44)
                .clipShape(Circle())

            VStack(alignment: .leading, spacing: 4) {
                Text(repo.name)
                    .font(.headline)
                Text("Created: \(repo.createdAt)")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }

            Spacer()
        }
        .padding(.vertical, 6)
    }
}

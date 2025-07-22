//
//  CoordinatorView.swift
//  RepoEngine
//
//  Created by Charbel Khalifeh Hachem on 21/07/2025.
//

import Foundation
import SwiftUI

struct CoordinatorView: View {
    @EnvironmentObject var coordinator: AppCoordinator

    var body: some View {
        NavigationStack(path: $coordinator.path) {
            Group {
                if coordinator.isLoading {
                    SplashView()
                } else {
                    if Config.isUnitTesting {
                        RepositoryListView(viewModel: coordinator.mockRepoListViewModel)
                    } else {
                        RepositoryListView(viewModel: coordinator.repoListViewModel)
                    }
                }
            }
            .navigationDestination(for: Int.self) { id in
                if let entity = RepositoryManager.shared.cachedRepositories.first(where: { $0.id == id }) {
                    let repo = RepositoryUIModel(entity: entity)
                    RepositoryDetailView(repo: repo)
                } else {
                    Text("⚠️ Repo not found.")
                        .foregroundColor(.red)
                }
            }
        }
        .onAppear {
            coordinator.start()
        }
    }
}

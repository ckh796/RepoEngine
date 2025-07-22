//
//  AppCoordinator.swift
//  RepoEngine
//
//  Created by Charbel Khalifeh Hachem on 21/07/2025.
//

import Foundation
import Combine
import SwiftUI


final class AppCoordinator: ObservableObject {
    @Published var path = NavigationPath()
    @Published var isLoading = true

    let repoListViewModel = RepositoryListViewModel()
    let mockRepoListViewModel = RepositoryListViewModel(repositoryProvider: MockRepositoryProvider())

    func append(_ id: Int) {
        path.append(id) // Make sure this is called with exactly `Int`
    }
    
    func start() {
        // Simulate splash delay or startup logic
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            self.isLoading = false
        }
    }
}

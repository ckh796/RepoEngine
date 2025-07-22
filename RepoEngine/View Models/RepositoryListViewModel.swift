//
//  RepositoryListViewModel.swift
//  RepoEngine
//
//  Created by Charbel Khalifeh Hachem on 21/07/2025.
//

import SwiftUI
import Combine

final class RepositoryListViewModel: ObservableObject {
    // MARK: - Inputs
    @Published var searchText: String = ""

    // MARK: - Outputs
    @Published var repositories: [RepositoryUIModel] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?

    // MARK: - State
    private var hasLoaded = false
    private var currentPage = 1
    private var canLoadMore = true
    private let perPage = 20

    // MARK: - Dependencies
    private var cancellables = Set<AnyCancellable>()
    var onSelectRepo: ((RepositoryUIModel) -> Void)?

    // MARK: - Init
    private let repositoryProvider: RepositoryProviding

     init(repositoryProvider: RepositoryProviding = RepositoryManager.shared) {
         self.repositoryProvider = repositoryProvider
         setupSearchBinding()
     }

    // MARK: - Bindings
    private func setupSearchBinding() {
        $searchText
            .removeDuplicates()
            .debounce(for: .milliseconds(500), scheduler: RunLoop.main)
            .sink { [weak self] query in
                guard let self = self else { return }

                if query.isEmpty {
                    // Reset and show all
                    self.resetToInitialState()
                } else {
                    // Perform filtered search
                    self.fetchInitial(searchQuery: query)
                }
            }
            .store(in: &cancellables)
    }

    // MARK: - Public Methods
    func loadIfNeeded() {
        guard !hasLoaded else { return }
        hasLoaded = true

        if !repositoryProvider.cachedRepositories.isEmpty {
            self.repositories = repositoryProvider.cachedRepositories.map { RepositoryUIModel(entity: $0) }
            return
        }

        fetchInitial()
    }

    func fetchInitial(searchQuery: String? = nil) {
        currentPage = 1
        canLoadMore = true
        errorMessage = nil

        repositories = [] // Always clear before loading fresh results
        fetchRepositories(searchQuery: searchQuery)
    }

    func fetchNextPageIfNeeded(currentItem: RepositoryUIModel) {
        guard canLoadMore,
              let last = repositories.last,
              last.id == currentItem.id else { return }

        currentPage += 1
        fetchRepositories(searchQuery: searchText)
    }

    func select(repo: RepositoryUIModel) {
        onSelectRepo?(repo)
    }

    // MARK: - Reset State on Clear
    private func resetToInitialState() {
        hasLoaded = false
        currentPage = 1
        canLoadMore = true
        repositories = []
        errorMessage = nil
        fetchRepositories(searchQuery: nil)
    }

    // MARK: - Private Fetch
    private func fetchRepositories(searchQuery: String?) {
        isLoading = true
        errorMessage = nil

        repositoryProvider
            .fetchRepositories(searchQuery: searchQuery, reset: currentPage == 1)
            .map { $0.map { RepositoryUIModel(entity: $0) } }
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                self?.isLoading = false
                if case let .failure(error) = completion {
                    self?.errorMessage = error.localizedDescription
                }
            }, receiveValue: { [weak self] repos in
                self?.repositories = repos
                self?.canLoadMore = repos.count == self?.perPage
            })
            .store(in: &cancellables)
    }
}

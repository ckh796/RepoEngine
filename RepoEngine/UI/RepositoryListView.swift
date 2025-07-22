//
//  RepositoryListView.swift
//  RepoEngine
//
//  Created by Charbel Khalifeh Hachem on 21/07/2025.
//

import Foundation
import SwiftUI

struct RepositoryListView: View {

    @StateObject private var viewModel: RepositoryListViewModel
    @EnvironmentObject var coordinator: AppCoordinator
    @State private var selectedRepo: RepositoryUIModel?

    
    
    init(viewModel: RepositoryListViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        ZStack {
            Color(.systemBackground)
                .ignoresSafeArea()

            VStack(spacing: 0) {
                SearchBar(text: $viewModel.searchText)
                    .frame(height: 60)

                if viewModel.repositories.isEmpty && !viewModel.isLoading && viewModel.errorMessage == nil {
                    Spacer()
                    Text("No repositories found.")
                        .foregroundColor(.gray)
                    Spacer()
                } else if let error = viewModel.errorMessage {
                    Spacer()
                    Text(error)
                        .foregroundColor(.red)
                        .multilineTextAlignment(.center)
                        .padding()
                    Spacer()
                } else if viewModel.isLoading && viewModel.repositories.isEmpty {
                    Spacer()
                    ProgressView()
                    Spacer()
                } else {
                    List(viewModel.repositories) { repo in
                        Button(action: {
                            selectedRepo = repo
                        }) {
                            RepositoryRow(repo: repo)
                                .contentShape(Rectangle())
                        }
                        .buttonStyle(PlainButtonStyle())
                        .listRowBackground(
                            selectedRepo?.id == repo.id
                            ? Color(.systemGray5)
                            : Color.clear
                        )
                        .onAppear {
                            viewModel.fetchNextPageIfNeeded(currentItem: repo)
                        }
                    }
                    .listStyle(.plain)
                    .simultaneousGesture(
                        DragGesture().onChanged { _ in
                            hideKeyboard()
                        }
                    )
                }
            }
        }
        .sheet(item: $selectedRepo) { repo in
            RepositoryDetailView(repo: repo)
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 45)
                    .foregroundColor(Color(.label))
                    .accessibilityHidden(true)
                    .padding(.vertical, 16)
            }
        }
        .onAppear {
            viewModel.onSelectRepo = { repo in
                selectedRepo = repo // optional: if needed for programmatic sheet open
            }
            viewModel.loadIfNeeded()
        }
        .simultaneousGesture(
            TapGesture().onEnded {
                hideKeyboard()
            }
        )
    }
}

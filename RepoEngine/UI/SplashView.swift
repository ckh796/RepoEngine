//
//  SplashView.swift
//  RepoEngine
//
//  Created by Charbel Khalifeh Hachem on 15/07/2025.
//

import SwiftUI

struct SplashView: View {
    @StateObject private var viewModel = SplashViewModel()
    @EnvironmentObject var coordinator: AppCoordinator

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color.black.ignoresSafeArea()

                Image("splash_logo")
                    .resizable()
                    .aspectRatio(1, contentMode: .fit)
                    .padding(.horizontal, 20)
                    .offset(y: -geometry.size.height * 0.015)

                VStack {
                    Spacer()
                    ProgressView(value: viewModel.progress)
                        .progressViewStyle(LinearProgressViewStyle(tint: .white))
                        .frame(height: 4)
                        .padding(.horizontal, 20)
                        .padding(.bottom, geometry.safeAreaInsets.bottom + 30)
                }
            }
            .onAppear {
                viewModel.onFinish = {
                    coordinator.isLoading = false
                }
                viewModel.startLoading()
            }
        }
    }
}

#Preview {
    SplashView()
}

//
//  SplashViewModel.swift
//  RepoEngine
//
//  Created by Charbel Khalifeh Hachem on 21/07/2025.
//

import SwiftUI
import Combine

final class SplashViewModel: ObservableObject {
    @Published var progress: Double = 0.0

    private var timer: Timer?
    private let duration: TimeInterval = 3.0
    private let steps: Int = 60
    private var currentStep = 0

    var onFinish: (() -> Void)?

    func startLoading() {
        progress = 0.0
        currentStep = 0

        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: duration / Double(steps), repeats: true) { [weak self] t in
            guard let self = self else { return }

            self.currentStep += 1
            self.progress = min(Double(self.currentStep) / Double(self.steps), 1.0)

            if self.currentStep >= self.steps {
                t.invalidate()
                self.timer = nil
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    self.onFinish?()
                }
            }
        }
    }

    deinit {
        timer?.invalidate()
    }
}

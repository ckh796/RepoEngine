//
//  RepoEngineApp.swift
//  RepoEngine
//
//  Created by Charbel Khalifeh Hachem on 15/07/2025.
//

import SwiftUI

@main
struct RepoEngineApp: App {
    @StateObject private var coordinator = AppCoordinator()

    var body: some Scene {
        WindowGroup {
            CoordinatorView().environmentObject(coordinator)
        }
    }
}

struct Config {
    static var isUnitTesting = false 
}


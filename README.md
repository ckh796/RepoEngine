# RepoEngine

RepoEngine is a modern SwiftUI iOS app that lets users search and browse GitHub repositories with a clean architecture and responsive UI. It demonstrates best practices in MVVM, dependency injection, pagination, and async data loading.

## 🚀 Features

- 🔍 GitHub repository search with live debounce filtering
- 📄 Detailed repository view with avatar, stars, and creation date
- 📥 Infinite scroll / pagination
- 🧪 Unit-testable architecture with mocked data source
- 🧼 Clean UI with SwiftUI + Combine
- 💡 Loading indicators and error handling
- 🧭 Splash screen on launch
- ✅ Keyboard dismissal on scroll or tap
- 👋 Modal-based repository detail presentation (`.sheet`)

## 🛠 Architecture

- **MVVM**: Model-View-ViewModel pattern
- **Dependency Injection**: `RepositoryProviding` protocol allows injecting mock or real implementations
- **Combine**: Handles search debounce, loading states, and reactive bindings
- **SwiftUI**: Entire UI built with SwiftUI, using `NavigationStack`, `.sheet`, and `@StateObject`

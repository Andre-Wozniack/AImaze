import SwiftUI

@main
struct AImazeApp: App {
    var navigationManager = NavigationManager()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(navigationManager)
        }
    }
}

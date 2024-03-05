import Foundation

class NavigationManager: ObservableObject {
    @Published var currentScreen: Screen = .home
    @Published var complete = true
    
    enum Screen {
        case home
        case maze
        case superMaze
        case talk
        case freePlay
        case explain
    }

    func navigate(to screen: Screen) {
        currentScreen = screen
    }
}

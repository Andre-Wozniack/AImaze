
import SwiftUI

struct ContentView: View {
    @EnvironmentObject var navigationManager: NavigationManager

    var body: some View {
        switch navigationManager.currentScreen {
        case .home:
            HomeView()
        case .maze:
            MazePlayer()
        case .superMaze:
            MazeView()
        case .explain:
            ExplainView()
        case .talk:
            TalkView()
        case .freePlay:
            FreePlay()
        }
    }
}

#Preview {
    ContentView()
}

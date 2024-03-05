import SwiftUI

struct MazePlayer: View {
    @EnvironmentObject var navigationManager: NavigationManager
    
    @State private var mazeGenerator = MazeGenerator(width: 7, height: 7)
    @State private var playerPosition = (row: 1, col: 1)
    @State private var hasWon = false
    @State private var maze: [[Int]] = []

    let tamanho: CGFloat = 28

    var body: some View {
        NavigationStack{
            VStack {
                if hasWon {
                    Text("You found it!")
                        .font(.largeTitle)
                        .foregroundColor(.green)
                        .padding()
                        .padding(.top)
                        .bold()
                        .padding(.top)
                    
                } else {
                    Text("Help bob find the way")
                        .font(.largeTitle)
                        .padding()
                        .padding(.top)
                        .bold()
                        .padding(.top)
                }
                //Maze
                VStack(spacing: 0) {
                    ForEach(0..<maze.count, id: \.self) { rowIndex in
                        HStack(spacing: 0) {
                            ForEach(0..<maze[rowIndex].count, id: \.self) { columnIndex in
                                let isGoalCell = rowIndex == maze.count - 2 && columnIndex == maze[0].count - 2
                                let isPlayerCell = rowIndex == playerPosition.row && columnIndex == playerPosition.col
                                let isWallCell = maze[rowIndex][columnIndex] == 1
                                
                                if isPlayerCell {
                                    Image("bob")
                                        .resizable()
                                        .frame(width: tamanho, height: tamanho)
                                    
                                } else if isGoalCell {
                                    Rectangle()
                                        .fill(Color.green)
                                        .frame(width: tamanho, height: tamanho)
                                } else if isWallCell {
                                    Rectangle()
                                        .fill(Color.black)
                                        .frame(width: tamanho, height: tamanho)
                                } else {
                                    Rectangle()
                                        .fill(Color.clear)
                                        .frame(width: tamanho, height: tamanho)
                                }
                            }
                        }
                    }
                }
                .padding(12)
                .background(Color.white)
                    
                .padding()
                if hasWon {
                    Button {
                        navigationManager.navigate(to: .superMaze)
                    } label: {
                        Text("Next Challenge")
                            .font(.title)
                            .font(.system(size: 80))
                            .bold()
                            .foregroundStyle(Color.white)
                            .shadow(color: .black, radius: 0, x: 1, y: 1)
                            .padding()
                            .background {
                                RoundedRectangle(cornerRadius: 12, style: .circular)
                                    .backgroundStyle(Color.blue)
                            }
                    }
                } else {
                    Text(" ")
                        .font(.title)
                        .font(.system(size: 80))
                        .bold()
                        .foregroundStyle(Color.green)
                        .shadow(color: .black, radius: 0, x: 1, y: 1)
                        .padding()
                }
                    
                
                // Controlls
                VStack(spacing: -18) {
                    Button {
                        movePlayer(to: .up)
                    } label: {
                        Text(.init(systemName: "arrow.up.square"))
                    }
                    HStack(spacing: -10){
                        Button {
                            movePlayer(to: .left)
                        } label: {
                            Text(.init(systemName: "arrow.left.square"))
                        }
                        Button {
                            movePlayer(to: .down)
                        } label: {
                            Text(.init(systemName: "arrow.down.square"))
                        }
                        Button {
                            movePlayer(to: .right)
                        } label: {
                            Text(.init(systemName: "arrow.right.square"))
                        }
                    }
                }.font(.system(size: 100))
                    

            }
            .onAppear {
                mazeGenerator.generateMaze(startingAt: Cell(x: 0, y: 0))
                self.maze = mazeGenerator.maze
                
            }
        }
        .navigationBarBackButtonHidden()
    }
    

    
    func movePlayer(to direction: Direction) {
        let (row, col) = playerPosition
        switch direction {
        case .up where row > 0 && maze[row - 1][col] == 0:
            playerPosition.row -= 1
        case .down where row < maze.count - 1 && maze[row + 1][col] == 0:
            playerPosition.row += 1
        case .left where col > 0 && maze[row][col - 1] == 0:
            playerPosition.col -= 1
        case .right where col < maze[row].count - 1 && maze[row][col + 1] == 0:
            playerPosition.col += 1
        default: break
        }
        
        if playerPosition.row == maze.count - 2 && playerPosition.col == maze[0].count - 2 {
            hasWon = true
        }
    }
    


}

#Preview {
    MazePlayer()
}

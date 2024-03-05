import SwiftUI

struct MazeView: View {
    @EnvironmentObject var navigationManager: NavigationManager
    
    @State private var mazeGenerator = MazeGenerator(width: 23, height: 21)
    @State private var playerPosition = (row: 1, col: 1)
    @State private var hasWon = false
    @State private var maze: [[Int]] = []
    @State private var path: [PathFinder.Cell] = []
    @State private var searchingPath: Bool = false
    @State private var movingInPath: Bool = false
    @State private var currentSearchStateIndex = 0
    @State private var searchStates: [[PathFinder.Cell]] = []
    @State private var exploringCells: Set<PathFinder.Cell> = []
    @State private var clickCounter: Int = 0

    let tamanho: CGFloat = 16

    var body: some View {
        VStack {
            Spacer()
            if hasWon {
                Text("The path was found!")
                    .font(.largeTitle)
                    .foregroundColor(.green)
                    .padding()
                    .bold()
                    .padding(.top, 22)
            } else if searchingPath {
                Text("Searching..")
                    .font(.largeTitle)
                    .foregroundColor(.yellow)
                    .padding()
                    .bold()
                    .padding(.top, 22)
            }
            else if movingInPath {
                Text("Moving...")
                    .font(.largeTitle)
                    .foregroundColor(.blue)
                    .padding()
                    .bold()
                    .padding(.top, 22)
            } else {
                Text("Find the path")
                    .font(.largeTitle)
                    .padding()
                    .bold()
                    .padding(.top, 22)
            }
            
            
            //Maze
            VStack(spacing: 0) {
                ForEach(0..<maze.count, id: \.self) { rowIndex in
                    HStack(spacing: 0) {
                        ForEach(0..<maze[rowIndex].count, id: \.self) { columnIndex in
                            let isGoalCell = rowIndex == maze.count - 2 && columnIndex == maze[0].count - 2
                            let isPathCell = path.contains { $0.i == rowIndex && $0.j == columnIndex }
                            let isPlayerCell = rowIndex == playerPosition.row && columnIndex == playerPosition.col
                            let isWallCell = maze[rowIndex][columnIndex] == 1
                            let cell = PathFinder.Cell(i: rowIndex, j: columnIndex)
                            let isExploringCell = self.exploringCells.contains(cell)
                            
                            if isExploringCell {
                                Rectangle()
                                    .fill(Color.yellow)
                                    .frame(width: tamanho, height: tamanho)
                            } else if isPlayerCell {
                                Image("bob")
                                    .resizable()
                                    .frame(width: tamanho, height: tamanho)
                            } else if isGoalCell {
                                Rectangle()
                                    .fill(Color.green)
                                    .frame(width: tamanho, height: tamanho)
                            } else if isPathCell {
                                Rectangle()
                                    .fill(Color.blue.opacity(0.5))
                                    .frame(width: tamanho, height: tamanho)
                            } else if isWallCell {
                                Rectangle()
                                    .fill(Color.black)
                                    .frame(width: tamanho, height: tamanho)
                            } else {
                                Rectangle()
                                    .fill(Color.white)
                                    .frame(width: tamanho, height: tamanho)
                            }
                        }
                    }
                }
            }
            .padding(12)
            .frame(maxHeight: .infinity)
            .background(Color.white)
            
            // Controlls
            VStack{
                Spacer()
                if clickCounter >= 10  && !hasWon {
                    VStack{
                        Text("Too difficult? Let me help you with AI:")
                            .fontWeight(.semibold)
                            .padding()
                            .font(.system(size: 20))
//                            .background(Color.gray.opacity(0.3))
                            .cornerRadius(10)
                            .padding(.bottom, 3)
                        
                        Button {
                            findPathInMaze()
                        } label: {
                            Text("Help")
                                .foregroundStyle(Color.white)
                                .font(.system(size: 25))
                                .bold()
                                .padding()
                                .padding(.horizontal, 50)
                                .background(RoundedRectangle(cornerRadius: 12, style: .circular).fill(Color.blue))
                        }
                    }.padding(.bottom, -20)
                    
                } else if hasWon {
                    VStack{
                        Text("Do you see how AI can help us solve complex problems?")
                            .fontWeight(.semibold)
                            .font(.system(size: 20))
                            .padding()
                            .cornerRadius(10)
                            .padding(.bottom, 3)
                        
                        Button {
                            navigationManager.navigate(to: .talk)
                        } label: {
                            Text("Let's talk about this")
                                .foregroundStyle(Color.white)
                                .font(.system(size: 25))
                                .bold()
                                .padding()
                                .padding(.horizontal, 50)
                                .background(RoundedRectangle(cornerRadius: 12, style: .circular).fill(Color.blue))
                        }
                    }.padding(-25)
                }
                VStack(spacing: -18) {
                    Button {
                        movePlayer(to: .up)
                        clickCounter += 1
                    } label: {
                        Text(.init(systemName: "arrow.up.square"))
                    }
                    HStack(spacing: -10){
                        Button {
                            movePlayer(to: .left)
                            clickCounter += 1
                        } label: {
                            Text(.init(systemName: "arrow.left.square"))
                        }
                        Button {
                            movePlayer(to: .down)
                            clickCounter += 1
                        } label: {
                            Text(.init(systemName: "arrow.down.square"))
                        }
                        Button {
                            movePlayer(to: .right)
                            clickCounter += 1
                        } label: {
                            Text(.init(systemName: "arrow.right.square"))
                        }
                    }
                }.font(.system(size: 100))
                Spacer()
            }
            .frame(maxHeight: .infinity, alignment: .bottom)
        }
        .onAppear {
            mazeGenerator.generateMaze(startingAt: Cell(x: 0, y: 0))
            self.maze = mazeGenerator.maze
        }
        .padding()
//        .ignoresSafeArea()
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
    func findPathInMaze() {
        let pathFinder = PathFinder(maze: self.maze)
        let startCell = PathFinder.Cell(i: 1, j: 1)
        let goalCell = PathFinder.Cell(i: maze.count - 2, j: maze[0].count - 2)
        searchingPath = true
        DispatchQueue.global(qos: .userInitiated).async {
            _ = pathFinder.findPath(from: startCell, to: goalCell)
            DispatchQueue.main.async {
                self.searchStates = pathFinder.searchStates
                self.visualizeSearchProcess()
            }
        }
    }
    func visualizeSearchProcess() {
        var delay = 0.0
        for state in searchStates {
            DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                self.exploringCells = Set(state)
            }
            delay += 0.01
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            searchingPath.toggle()
            movingInPath.toggle()
            self.exploringCells.removeAll()
            self.path = self.searchStates.last ?? []
            self.visualizePathStepByStep()
            
        }
    }
    func visualizePathStepByStep() {
        let stepsPerInterval = max(1, path.count / 100)
        Timer.scheduledTimer(withTimeInterval: 0.0005, repeats: true) { timer in
            for _ in 0..<stepsPerInterval {
                if path.isEmpty {
                    timer.invalidate()
                    searchingPath = false
                    return
                }

                let nextCell = path.removeFirst()
                playerPosition = (row: nextCell.i, col: nextCell.j)

                if playerPosition.row == maze.count - 2 && playerPosition.col == maze[0].count - 2 {
                    movingInPath.toggle()
                    hasWon = true
                    timer.invalidate()
                    return
                }
            }
        }
    }
    func movePlayerAlongPath(from index: Int) {
        guard index < path.count else {
            self.hasWon = true
            return
        }

        let cell = path[index]
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
            self.playerPosition = (row: cell.i, col: cell.j)
            self.movePlayerAlongPath(from: index + 1)
        }
    }
}

#Preview {
    MazeView()
}

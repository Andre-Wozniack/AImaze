import Foundation

struct Cell {
    var x: Int
    var y: Int
}

class MazeGenerator {
    var maze: [[Int]]
    let width: Int
    let height: Int

    init(width: Int, height: Int) {
        self.width = width
        self.height = height
        self.maze = Array(repeating: Array(repeating: 1, count: width * 2 + 1), count: height * 2 + 1)
    }

    func generateMaze(startingAt start: Cell) {
        visitCell(at: start)
    }

    private func visitCell(at cell: Cell) {
        let mazeX = cell.x * 2 + 1
        let mazeY = cell.y * 2 + 1
        maze[mazeY][mazeX] = 0

        let directions = [(-1, 0), (0, -1), (1, 0), (0, 1)].shuffled()

        for (dx, dy) in directions {
            let nextX = cell.x + dx
            let nextY = cell.y + dy

            if isValid(x: nextX, y: nextY) && maze[nextY * 2 + 1][nextX * 2 + 1] == 1 {
            
                maze[mazeY + dy][mazeX + dx] = 0
                visitCell(at: Cell(x: nextX, y: nextY))
            }
        }
    }

    private func isValid(x: Int, y: Int) -> Bool {
        return x >= 0 && y >= 0 && x < width && y < height
    }

    func regenerate(startingAt start: Cell) {
        generateMaze(startingAt: start)
    }
}

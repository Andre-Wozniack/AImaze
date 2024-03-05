import Foundation

class PathFinder {
    
    class Cell: Hashable {
        let i: Int
        let j: Int
        var g: Int
        var h: Int
        var f: Int { return g + h }
        var parent: Cell?
        
        init(i: Int, j: Int, g: Int = 0, h: Int = 0, parent: Cell? = nil) {
            self.i = i
            self.j = j
            self.g = g
            self.h = h
            self.parent = parent
        }
        
        static func == (lhs: Cell, rhs: Cell) -> Bool {
            return lhs.i == rhs.i && lhs.j == rhs.j
        }
        
        func hash(into hasher: inout Hasher) {
            hasher.combine(i)
            hasher.combine(j)
        }
    }
    var maze: [[Int]]
    var searchStates: [[Cell]] = []

    init(maze: [[Int]]) {
        self.maze = maze
    }
    
    private func heuristic(cellA: Cell, cellB: Cell) -> Int {
        return abs(cellA.i - cellB.i) + abs(cellA.j - cellB.j)
    }
    
    private func getNeighbors(for cell: Cell) -> [Cell] {
        var neighbors = [Cell]()
        let directions = [(-1, 0), (1, 0), (0, -1), (0, 1)]
        for (di, dj) in directions {
            let newI = cell.i + di
            let newJ = cell.j + dj
            if newI >= 0 && newI < maze.count && newJ >= 0 && newJ < maze[0].count && maze[newI][newJ] == 0 {
                neighbors.append(Cell(i: newI, j: newJ))
            }
        }
        return neighbors
    }
    
    private func constructPath(from cell: Cell) -> [Cell] {
        var path = [Cell]()
        var current = cell
        while let parent = current.parent {
            path.append(current)
            current = parent
        }
        return path.reversed()
    }
    
    func findPath(from start: Cell, to goal: Cell) -> [Cell]? {
        var openList = [start]
        var closedList = Set<Cell>()
        searchStates.append([start])

        while !openList.isEmpty {
            openList.sort { $0.f < $1.f }
            let currentCell = openList.removeFirst()

            searchStates.append(closedList.map { $0 } + openList)
            
            if currentCell == goal {
                let finalPath = constructPath(from: currentCell)
                searchStates.append(finalPath)
                return finalPath
            }
            
            closedList.insert(currentCell)
            
            for neighbor in getNeighbors(for: currentCell) {
                if closedList.contains(neighbor) { continue }
                let tentativeGScore = currentCell.g + 1
                
                if let index = openList.firstIndex(of: neighbor) {
                    if tentativeGScore < openList[index].g {
                        openList[index].g = tentativeGScore
                        openList[index].parent = currentCell
                    }
                } else {
                    neighbor.g = tentativeGScore
                    neighbor.h = heuristic(cellA: neighbor, cellB: goal)
                    neighbor.parent = currentCell
                    openList.append(neighbor)
                }
            }
        }
        
        return nil
    }
}

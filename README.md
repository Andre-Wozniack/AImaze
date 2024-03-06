# AImaze

AImaze is a simple app for introducing discussions about AI. It's a basic maze app where you, with some help from artificial intelligence, find your way around.

**Generate Maze**

AImaze employs a backtracking algorithm to generate mazes. Starting from an initial cell, it forges a path by marking passages and removing walls. Directions are chosen randomly and pursued if they lead to an unvisited cell. The algorithm backtracks at dead ends and continues until every cell is explored, creating a perfect maze with a unique path between any two points, ensuring a novel challenge every time.

**Find Path**

AImaze uses the A* algorithm to quickly navigate mazes and find the shortest path. A* smartly assesses each step, focusing on moves that seem most likely to lead directly to the goal. It avoids dead-ends and unnecessary detours by prioritizing the most promising directions. This method ensures AImaze efficiently solves even the most complex puzzles, demonstrating the power and speed of A* in finding the best route through the maze.



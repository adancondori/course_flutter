class Maze {
  final List<List<int>> layout;

  Maze(this.layout);

  bool isWall(int x, int y) {
    return layout[x][y] == 1;
  }
}

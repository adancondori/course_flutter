class Player {
  double x;
  double y;

  Player(this.x, this.y);

  void move(double dx, double dy) {
    x += dx;
    y += dy;
  }
}

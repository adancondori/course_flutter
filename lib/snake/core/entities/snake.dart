import '../../domain/game_logic/direction.dart';

class Snake {
  List<int> positions; // Almacena la posición de cada parte de la serpiente
  int head; // Almacena la posición actual de la cabeza de la serpiente
  Direction headDirection; // Dirección actual de la cabeza de la serpiente

  Snake(this.positions, this.headDirection) : head = positions.first;

  // Método para mover la serpiente
  void move(Direction direction, int column) {
    headDirection = direction; // Actualiza la dirección actual de la serpiente

    // Movimiento basado en la dirección
    switch (direction) {
      case Direction.up:
        positions.insert(0, head - column);
        break;
      case Direction.down:
        positions.insert(0, head + column);
        break;
      case Direction.right:
        positions.insert(0, head + 1);
        break;
      case Direction.left:
        positions.insert(0, head - 1);
        break;
    }

    head = positions.first; // Actualiza la posición de la cabeza
  }

  // Verifica si la serpiente colisiona consigo misma
  bool checkCollisionWithSelf() => positions.sublist(1).contains(head);
}

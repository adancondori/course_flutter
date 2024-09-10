class Horse {
  final int id;
  final String name;
  final String nameImg;
  int position;
  bool finished;

  Horse({
    required this.id,
    required this.name,
    required this.nameImg,
    this.position = 0,
    this.finished = false,
  });
}

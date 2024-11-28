class PostStates {}

class InitialState extends PostStates {}

class UpdateState extends PostStates {
  List<dynamic> data = [];
  UpdateState(this.data);
}

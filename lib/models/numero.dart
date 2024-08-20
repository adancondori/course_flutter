class Numero {
  String listEvenNumbers(int n) {
    return List.generate(n, (index) => 2 * (index + 1)).join(', ');
  }

  String listOddNumbers(int n) {
    return List.generate(n, (index) => 2 * index + 1).join(', ');
  }

  int sumNaturalNumbers(int n) {
    return List.generate(n, (index) => index + 1).reduce((a, b) => a + b);
  }

  //TODO
}

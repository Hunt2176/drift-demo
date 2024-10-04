class MockHttp {
  const MockHttp();

  Future<List<MockData>> get() async {
    await Future.delayed(const Duration(milliseconds: 25));
    return List.generate(100, (index) => MockData._(index, 'Name $index'));
  }
}

class MockData {
  const MockData._(this.id, this.name);

  final int id;
  final String name;
}
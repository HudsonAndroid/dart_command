class Product {
  final String name;
  final String description;

  const Product(this.name, this.description);

  void overrideFun() {}
}

class Computer extends Product {
  final String processor;
  final String memory;

  Computer(name, description, this.processor, this.memory)
      : super(name, description);

  void _helloWorld() {
    print('hello $name');
  }

  @override
  void overrideFun() {}
}

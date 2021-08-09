import 'dart:mirrors';

/// 注意：flutter中反射是被禁用的
class InvocationHandler {
  @override
  dynamic noSuchMethod(Invocation invocation) {
    // invoked when function not found
    var cm = reflectClass(ProxyHolder);
    return cm
        .invoke(invocation.memberName, invocation.positionalArguments)
        .reflectee;
  }
}

// 被代理人
class ProxyHolder {
  // can proxy
  static String hello(String content) {
    return 'hello $content';
  }

  //  cannot proxy
  String say(String content) {
    return 'say $content';
  }
}

void main() {
  // 这里使用dynamic类型，以避免下方直接编译器报错没有定义这个方法
  // 被代理的方法必须是静态方法或者抽象方法
  dynamic invocationHandler = InvocationHandler();
  print(invocationHandler.say('hudson'));
}

import 'package:dart_command/const_var.dart';

class PlutterHelper {
  void printHelpDoc() {
    var str = '';
    ConstVar.PARAMS.forEach((key, value) {
      str += '\n\t$key $value';
    });
    var HELP = '''
plutter命令帮助文档：
    
build 构建运行环境$str
clean 清理运行环境
-h -help 帮助
''';
    print(HELP);
  }
}

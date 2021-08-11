
import 'dart:io';

class BuildChecker {

  static void flutterProjectCheck() {
    if(!File('pubspec.yaml').existsSync()){
      throw Exception('Cannot find pubspec.yaml, are you sure run this command in flutter project?');
    }
  }

  static void dirCheck() {
    // .android 目录必须存在
    if(!Directory('.android').existsSync()){
      throw Exception("Cannot find .android directory, check if the command 'flutter pub get' run ok or not.");
    }
    // 检查 .android/app/src/main/res/drawable/ 目录是否存在
    final drawableDir = Directory('.android/app/src/main/res/drawable');
    if(!drawableDir.existsSync()){
      drawableDir.createSync(recursive: true);
    }
    // 检查 .android/app/src/main/res/drawable-xxhdpi/ 目录是否存在
    final drawableXXDir = Directory('.android/app/src/main/res/drawable-xxhdpi/');
    if(!drawableXXDir.existsSync()){
      drawableXXDir.createSync(recursive: true);
    }
    // 检查 lib/app/ 目录是否存在
    final appDir = Directory('lib/app/');
    if(!appDir.existsSync()){
      appDir.createSync(recursive: true);
    }
  }

  static bool isValidPackageName(String input) {
    if(input == null || input.isEmpty == true) return false;
    final regExp = RegExp('^([a-zA-Z_][a-zA-Z0-9_]*)+([.][a-zA-Z_][a-zA-Z0-9_]*)+\$',
        caseSensitive: false, multiLine: false);
    return regExp.stringMatch(input) == input;
  }
}

import 'dart:io';

class BuildEnvChecker {

  void checkEnv() {
    _flutterProjectCheck();
    _dirCheck();
  }

  void _flutterProjectCheck() {
    if(!File('pubspec.yaml').existsSync()){
      throw Exception('Cannot find pubspec.yaml, are you sure run this command in flutter project?');
    }
  }

  void _dirCheck() {
    // .android 目录必须存在
    if(!File('.android').existsSync()){
      throw Exception("Cannot find .android directory, check if the command 'flutter pub get' run ok or not.");
    }
    // 检查 .android/app/src/main/res/drawable/ 目录是否存在
    final drawableDir = File('.android/app/src/main/res/drawable');
    if(!drawableDir.existsSync()){
      drawableDir.createSync(recursive: true);
    }
    // 检查 .android/app/src/main/res/drawable-xxhdpi/ 目录是否存在
    final drawableXXDir = File('.android/app/src/main/res/drawable-xxhdpi/');
    if(!drawableXXDir.existsSync()){
      drawableXXDir.createSync(recursive: true);
    }
    // 检查 lib/app/ 目录是否存在
    final appDir = File('lib/app/');
    if(!appDir.existsSync()){
      appDir.createSync(recursive: true);
    }
  }
}
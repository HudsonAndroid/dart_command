
import 'dart:io';

import 'package:dart_command/const_var.dart';

class CleanProcessor {

  void cleanSpace() {
    // 仅清理Splash dart文件
    final splashFile = File(ConstVar.SPLASH_PATH);
    if(splashFile.existsSync()){
      splashFile.deleteSync();
    }else{
      print('Cannot find the generated file: ${ConstVar.SPLASH_PATH}');
    }
  }
}
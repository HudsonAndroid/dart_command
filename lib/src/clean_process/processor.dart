
import 'dart:io';

import 'package:dart_command/const_var.dart';
import 'package:process_run/shell.dart';

class CleanProcessor {

  void cleanSpace() async {
    // 仅清理Splash dart文件
    final splashFile = File(ConstVar.SPLASH_PATH);
    if(splashFile.existsSync()){
      splashFile.deleteSync();
    }else{
      print('Cannot find the generated file: ${ConstVar.SPLASH_PATH}');
    }

    var shell = Shell();
    await shell.run('flutter clean');
  }
}
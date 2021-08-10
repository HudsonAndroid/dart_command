import 'dart:io';

import 'package:dart_command/const_var.dart';
import 'package:dart_command/helper.dart';
import 'package:dart_command/src/clean_process/processor.dart';
import 'package:dart_command/src/param_docoder/decoder.dart';
import 'package:dart_command/src/space_process/processor.dart';
import 'package:dio/dio.dart';
import 'package:process_run/shell.dart';

dynamic main(List<String> args) async {
  final helper = PlutterHelper();
  if (args.isEmpty) {
    helper.printHelpDoc();
    return;
  }

  final type = args[0];
  if (type == 'build') {
    var shell = Shell();
    await shell.run('flutter pub get');
    // 解析参数  args1 appName; args2 packageName
    final paramModel = ParamDecoder().decode(args);
    await SpaceProcessor().buildRunnableSpace(paramModel.appName, paramModel.packageName);
  }else if(type == 'clean') {
    // 清空工作空间
    CleanProcessor().cleanSpace();
  }else if(type == '-h' || type == '-help'){
    helper.printHelpDoc();
  }
}

/// 获取Plutter原始所在路径，以备后面复制文件使用
Future<String> _grabPlutterPath(Shell shell) async {
  var result = await shell.run('dart pub global list');
  if (result != null && (result.outLines?.length ?? 0) > 0) {
    print('运行结果${result.outLines}');
    for (var line in result.outLines) {
      if (line.startsWith('plutter ')) {
        // 找到指令
        var startIndex = line.indexOf('"');
        if (startIndex != -1) {
          return line.substring(startIndex + 1, line.length - 1);
        }
      }
    }
  }
  return null;
}

void downloadFile() async {
  print('开始下载文件');

  var dio = Dio();

  // try {
  //   var response = await dio.download(
  //       'https://raw.githubusercontent.com/HudsonAndroid/dart_command/main/example/dart_command_example.dart',
  //       'tmp.jpg');
  //   print('内容${response}');
  // } on Exception catch (e) {
  //   print('执行出错$e');
  // }

  final appBuildGradle = '.android/app/build.gradle';
  print('地址${ConstVar.BASE_URL}${appBuildGradle}');
  var result = await dio.get('${ConstVar.BASE_URL}${appBuildGradle}');

  print('结果${result.toString().replaceAll('名字', '修改的名字')}');
  // writeFile('example.jpg', response.data.toString());
}

/// 复制并修复文件内容
void copyAndModify(String sourcePath, String target, String resContent,
    String dstContent) async {
  writeFile(target, await readFile(sourcePath));
}

Future<String> readFile(String rootPath) async {
  var file = File(rootPath);

  var content = await file.readAsString();
  return content.replaceAll('名字', '修改的名字');
}

void writeFile(String path, String content) async {
  var file = File(path);
  try {
    await file.writeAsString(content);
    print('写入文件成功');
  } catch (e) {
    print(e);
  }
}

Future<File> moveFile(File sourceFile, String newPath) async {
  try {
    // prefer using rename as it is probably faster
    return await sourceFile.rename(newPath);
  } on FileSystemException catch (e) {
    // if rename fails, copy the source file and then delete it
    final newFile = await sourceFile.copy(newPath);
    await sourceFile.delete();
    return newFile;
  }
}

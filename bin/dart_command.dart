import 'dart:io';

import 'package:dio/dio.dart';
import 'package:process_run/shell.dart';

dynamic main(List<String> args) async {
  var shell = Shell();
  await shell.run('pwd');
  // shell.run('flutter pub get');

  // moveFile(File('http://git.pupuvip.com:8005/frontend/flutter_plugins/plutter_scaffold/-/blob/master/android/app/build.gradle'), 'bin/build.gradle');
  // writeFile();

  await downloadFile();
  // var path = await _grabPlutterPath(shell);
  // print('路径是$path');

  // await File('${path}/files/build.gradle').copy('build.gradle');
  // copyAndModify('${path}/files/build.gradle', 'build.gradle', '名字', '修改后的名字');

  print('完成');
  // print('>>${args.length}>>${sayHello(args[0])}');
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

  var response =
      await dio.download('http://127.0.0.1:8080/favicon.ico', 'tmp.jpg');
  print('内容${response}');
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

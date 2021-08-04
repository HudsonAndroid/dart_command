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

  // print(await http.get(
  //     'https://raw.githubusercontent.com/HudsonAndroid/dart_command/main/example/dart_command_example.dart'));

  var dio = Dio();

  var response = await dio.download(
      'https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fhbimg.b0.upaiyun.com%2F8f736c32c26ba596a88d0fcab49667f2c662360727a30-cMBbHk_fw658&refer=http%3A%2F%2Fhbimg.b0.upaiyun.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1630640400&t=030964b45af2b3a249edcd8aa2f025f8',
      'tmp.jpg');
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

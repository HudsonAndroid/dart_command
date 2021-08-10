import 'dart:io';

import 'package:dart_command/const_var.dart';
import 'package:dio/dio.dart';

class SpaceProcessor {
  /// 构建可运行环境
  Future<bool> buildRunnableSpace(
      String appName, String packageName/*, String appEntryLocation*/) async {
    try {
      final dio = Dio();
      // STEP1： 构建android环境目录
      await _buildAndroidSpace(dio, appName, packageName);
      // STEP2:  修改Flutter代码，使其可用
      await _buildFlutterSpace(dio/*, appEntryLocation*/);
    } on Exception catch (e) {
      print('build runnable space error: $e');
      return false;
    }
    return true;
  }

  Future<void> _buildAndroidSpace(Dio dio, String appName, String packageName) async {
    // 1.下载并覆盖settings.gradle
    final settingGradle = '.android/settings.gradle';
    await dio.download('${ConstVar.BASE_URL}${settingGradle}', settingGradle);

    // 2.下载、修改并覆盖app/build.gradle
    final appBuildGradle = '.android/app/build.gradle';
    var result = await dio.get('${ConstVar.BASE_URL}${appBuildGradle}');

    var modifyContent = result.toString();
    if(packageName?.isEmpty == true){
      packageName = ConstVar.DEFAULT_PACKAGE_NAME;
    }
    if (appName?.isNotEmpty == true) {
      modifyContent =
          modifyContent
            ..replaceAll(ConstVar.APP_NAME_PLACEHOLDER, appName)
            ..replaceAll(ConstVar.PACKAGE_NAME_PLACEHOLDER, packageName);
    }
    var file = File(appBuildGradle);
    await file.writeAsString(modifyContent);

    // 3.下载并覆盖settings_aar.gradle
    final settingAarGradle = '.android/settings_aar.gradle';
    await dio.download('${ConstVar.BASE_URL}${settingAarGradle}', settingAarGradle);
  }

  Future<void> _buildFlutterSpace(Dio dio/*, String appEntryLocation*/) async {
    // // 1.根据外界指定的main中的runApp方法所属文件app.dart，复制
    //
    // // 并重命名为app_for_plutter.dart，
    // // 同时修改内部的splash页面为
    // if (appEntryLocation?.isEmpty == true) {
    //   appEntryLocation = ConstVar.DEFAULT_APP_ENTRY;
    // }
    // var file = File(appEntryLocation);
    // if (file.existsSync()) {
    //   // 1.1 复制该文件并修改splash页面
    //   var content = await file.readAsString();
    //   // 导包
    //   content = "import 'splash_page.dart';\n$content";
    //   // 修改启动页：修改方法onSubGenerateRoute，针对Splash提供我们的启动页，以触发登录
    //
    // } else {
    //   throw Exception('''Cannot find app entry file, path: $appEntryLocation.
    //       App entry file path will be ${ConstVar.DEFAULT_APP_ENTRY} by default
    //       if you don't set the param.
    //       ''');
    // }

    // 2.复制splash页面，并提示使用者更换splash页面
    final splashPath = ConstVar.SPLASH_PATH;
    await dio.download('${ConstVar.BASE_URL}${splashPath}', splashPath);

    // 3.提示替换
    print('''
      执行成功，现在你的工程中有新增一部分文件，你需要把${splashPath}启动页替换为你当前路由配置的启动页，
      之后重新运行项目即可应用配置信息。
      
      去除生成的文件请执行plutter clean。
    ''');
  }
}

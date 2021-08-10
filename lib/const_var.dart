class ConstVar {
  static const String BASE_URL = 'http://127.0.0.1:8080/plutter_scaffold/';

  static const String APP_NAME_PLACEHOLDER = '@{appName}';

  static const String PACKAGE_NAME_PLACEHOLDER = '@{packageName}';

  static const String DEFAULT_APP_NAME = 'plutter_demo';

  static const String DEFAULT_PACKAGE_NAME = 'com.example.plutter_demo';

  static const String DEFAULT_APP_ENTRY = 'lib/app/app.dart';

  static const String TARGET_APP_ENTRY = 'lib/plutter/app.dart';

  static const String SPLASH_PATH = 'lib/app/plutter_splash_page.dart';

  static const String MANIFEST_APP_NAME = '@string/app_name';


  ///  命令相关
  static const String PARAM_APP_NAME = '-n';

  static const String PARAM_PACKAGE_NAME = '-p';

  static const Map<String, String> PARAMS = {
    PARAM_APP_NAME: '配置应用名参数',
    PARAM_PACKAGE_NAME: '配置包名参数'
  };
}

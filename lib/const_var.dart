class ConstVar {
  static const String BASE_URL = 'http://127.0.0.1:8080/plutter_scaffold/';

  static const String APP_NAME_PLACEHOLDER = '@{appName}';

  static const String DEFAULT_APP_ENTRY = 'lib/app/app.dart';

  static const String TARGET_APP_ENTRY = 'lib/plutter/app.dart';

  static const String SPLASH_PATH = 'lib/app/plutter_splash_page.dart';

  static const Map<String, String> PARAMS = {
    '-entry': 'runApp的入口文件位置',
    '-app_name': '应用名'
  };
}

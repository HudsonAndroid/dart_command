class PlutterHelper {
  void noteInvalidCommand() {
    const HELP = '''
    参数不正确，可用的命令：
    build 构建运行环境
    clean 清理运行环境
    -h 帮助
    ''';
    print(HELP);
  }
}

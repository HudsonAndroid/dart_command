
import 'package:dart_command/const_var.dart';

class ParamDecoder {

  ParamModel decode(List<String> args){
    var model = ParamModel();
    // 第一个参数属于类型区分参数，因此略过
    if(args.length > 1){
      var type;
      for(var i = 1; i < args.length; i ++){
        // 奇数位为参数类型区分位
        if(i & 1 == 0){
          // 偶数
          attachParam(model, type, args[i]);
        }else{
          type = args[i];
        }
      }
    }
    return model;
  }

  void attachParam(ParamModel model, String type, String value){
    switch(type){
      case ConstVar.PARAM_APP_NAME:
        model.appName = value;
        break;

      case ConstVar.PARAM_PACKAGE_NAME:
        model.packageName = value;
        break;

      default:
        throw Exception('Syntax error, cannot identify param: ${type}');
    }
  }


}


class ParamModel {
  String packageName;

  String appName;
}
import 'dart:mirrors';

import 'package:dart_command/reflection/model.dart';

void getDataMembers(ClassMirror classMirror) {
  for (var v in classMirror.declarations.values) {
    var name = MirrorSystem.getName(v.simpleName);

    if (v is VariableMirror) {
      print('Variable: $name');
      print('const: ${v.isConst}');
      print('final: ${v.isFinal}');
      print('private: ${v.isPrivate}');
      print('static: ${v.isStatic}');
      print('extension: ${v.isExtensionMember}');
    } else if (v is MethodMirror) {
      print('Method: $name');
      print('abstract: ${v.isAbstract}');
      print('private: ${v.isPrivate}');
      print('static: ${v.isStatic}');
      print('extension: ${v.isExtensionMember}');
      print('constructor: ${v.isConstructor}');
      print('top level: ${v.isTopLevel}');

      /// 获取方法源代码
      print('source: ${v.source}');
      print('returnType: ${v.returnType}');

      if (v.returnType is ClassMirror) {
        print('是一个类型');
      }
    }

    print('-----------------------------');
  }
}

void main() {
  var computer = Computer('Computer One', 'No longer used', 'Dual-core', '1GB');
  var im = reflect(computer);
  var classMirror = im.type;
  getDataMembers(classMirror);

  // Get data members of superclass
  var superClassMirror = classMirror.superclass;

  if (superClassMirror != null) {
    getDataMembers(superClassMirror);
  }
}


import 'dart:io';

import 'package:dart_command/const_var.dart';
import 'package:xml/xml.dart';

class ManifestProcessor {

  /// 主要任务：把application节点的label更换为@string/app_name
  Future<void> processManifest(String manifestLocation) async {
    if(manifestLocation?.isNotEmpty == true){
      final file = File(manifestLocation);
      final document = XmlDocument.parse(file.readAsStringSync());
      final attributes = document.findAllElements('application').first.attributes;
      var hasModify = false;
      attributes.forEach((item) {
        final name = item.name;
        print('${name.prefix}  ${name.local}  ${name.qualified}  ${name.namespaceUri}');
        if(item.name.qualified == 'android:label'){
          item.value = ConstVar.MANIFEST_APP_NAME;
          hasModify = true;
        }
      });
      if(hasModify){
        await file.writeAsString(document.toXmlString(pretty: true, indent: '\t'));
      }
    }
  }
}
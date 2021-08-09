// see https://www.youtube.com/watch?v=H4HWB2Pmgcw

import 'dart:async';

import 'package:build/build.dart';

class CopyBuilder implements Builder {
  @override
  FutureOr<void> build(BuildStep buildStep) async {
    // current matched asset
    var inputId = buildStep.inputId;

    // create a new target 'assetId' based on the current one
    var copyAssetId = inputId.changeExtension('.copy.txt');
    var contents = await buildStep.readAsString(inputId);

    // write  out the new asset
    await buildStep.writeAsString(copyAssetId, contents);
  }

  @override
  Map<String, List<String>> get buildExtensions => {
        '.txt': ['.copy.txt']
      };
}

import 'dart:async';
import 'package:test/test.dart';
import 'package:build/build.dart';
import 'package:build_test/build_test.dart';
import 'package:logging/logging.dart';
import 'package:source_gen/source_gen.dart';
import 'package:reducer_extension_gen/src/reducer_generator.dart';
import 'constants.dart';

//Run the tests with `pub run test` as we don't use the flutter dependencies here

void main() {
  group('generator', () {
    test('produces correct output for correct input', () async {
      final result = await _generate(correctInput);
      expect(result, correctResult);
    });
  });
}

Builder get _builder => PartBuilder([ReducerGenerator()], '.g.dart');

Future<String> _generate(String source) async {
  final srcs = <String, String>{
    'reducer_extension|lib/reducer_extension.dart': annotationsBase,
    '$pkgName|lib/basic_class.dart': source,
  };

  String error;
  void captureError(LogRecord logRecord) {
    error = logRecord.error.toString();
  }

  final writer = InMemoryAssetWriter();
  await testBuilder(
    _builder,
    srcs,
    rootPackage: pkgName,
    writer: writer,
    onLog: captureError,
  );

  return error ??
      String.fromCharCodes(
        writer.assets[AssetId(pkgName, 'lib/basic_class.g.dart')] ?? [],
      );
}

import 'package:test/test.dart';
import 'package:reducer_extension/reducer_extension.dart';

void main() {
  test('annotation exists', () {
    final annotation = const SimpleObject();
    expect(annotation is Reducer, true);
  });
}

import 'package:reducer_extension/reducer_extension.dart';
import 'package:test/test.dart';

void main() {
  test('annotation exists', () {
    final annotation = const SimpleObject();
    expect(annotation is ActionReducer, true);
  });
}

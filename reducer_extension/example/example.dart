import 'package:meta/meta.dart' show immutable;
import 'package:reducer_extension/reducer_extension.dart';

// Make sure you add redux header as it is used in generated code
import 'package:redux/redux.dart';

/// Make sure that `part` is specified, even before launching the builder
part 'example.g.dart';

@immutable
@reducer
class SimpleObject {
  final String id;
  final int value;

  const SimpleObject({this.id, this.value});

  // Make sure you implement the copyWith pattern
  SimpleObject copyWith({String id, int value}) => SimpleObject(id: id ?? this.id, value: value ?? this.value);
}

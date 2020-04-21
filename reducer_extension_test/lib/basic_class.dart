import 'package:meta/meta.dart' show immutable;
import 'package:reducer_extension/reducer_extension.dart';
import 'package:redux/redux.dart';

part 'basic_class.g.dart';

@actionReducer
@immutable
class BasicClass {
  const BasicClass({this.test, this.id});

  final bool test;
  final String id;

  BasicClass copyWith({bool test, String id}) => BasicClass(test: test ?? this.test, id: id ?? this.id);
}

const String pkgName = "reducer_extension_gen";

const String annotationsBase = r'''
/// Provides annotation class to use with
/// [reducer_extension_gen](https://pub.dev/packages/reducer_extension_gen).
library reducer_extension;

/// Annotation used to indicate that the `Reducer` extension should be generated.
const reducer = Reducer();

class Reducer {
  /// Creates a new [Reducer] instance.
  const Reducer();
}
''';

const String correctInput = r'''
import 'package:meta/meta.dart' show immutable;
import 'package:reducer_extension/reducer_extension.dart';
import 'package:redux/redux.dart';

part 'basic_class.g.dart';

@immutable
@reducer
class BasicClass {
  const BasicClass({this.test, this.id});

  final bool test;
  final String id;

  BasicClass copyWith({bool test, String id}) => BasicClass(test: test ?? this.test, id: id ?? this.id);
}
''';

const String correctResult = r'''
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'basic_class.dart';

// **************************************************************************
// ReducerGenerator
// **************************************************************************

// ignore_for_file: argument_type_not_assignable, implicit_dynamic_type, always_specify_types

@immutable
class UpdateBasicClassId {
  const UpdateBasicClassId({this.id});
  final String id;
}

@immutable
class UpdateBasicClassTest {
  const UpdateBasicClassTest({this.test});
  final bool test;
}

BasicClass updateBasicClassId(BasicClass state, UpdateBasicClassId action) =>
    state.id != action.id ? state.copyWith(id: action.id) : state;

BasicClass updateBasicClassTest(BasicClass state, UpdateBasicClassTest action) =>
    state.test != action.test ? state.copyWith(test: action.test) : state;

Reducer<BasicClass> basicClassReducers = combineReducers<BasicClass>([
  TypedReducer<BasicClass, UpdateBasicClassId>(updateBasicClassId),
  TypedReducer<BasicClass, UpdateBasicClassTest>(updateBasicClassTest),
]);
''';

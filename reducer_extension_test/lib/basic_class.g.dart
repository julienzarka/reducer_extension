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

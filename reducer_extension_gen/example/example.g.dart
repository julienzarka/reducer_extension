// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'example.dart';

// **************************************************************************
// ReducerGenerator
// **************************************************************************

// ignore_for_file: argument_type_not_assignable, implicit_dynamic_type, always_specify_types

@immutable
class UpdateSimpleObjectId {
  const UpdateSimpleObjectId({this.id});
  final String id;
}

@immutable
class UpdateSimpleObjectValue {
  const UpdateSimpleObjectValue({this.value});
  final int value;
}

SimpleObject updateSimpleObjectId(
        SimpleObject state, UpdateSimpleObjectId action) =>
    state.id != action.id ? state.copyWith(id: action.id) : state;

SimpleObject updateSimpleObjectValue(
        SimpleObject state, UpdateSimpleObjectValue action) =>
    state.value != action.value ? state.copyWith(value: action.value) : state;

Reducer<SimpleObject> simpleObjectReducers = combineReducers<SimpleObject>([
  TypedReducer<SimpleObject, UpdateSimpleObjectId>(updateSimpleObjectId),
  TypedReducer<SimpleObject, UpdateSimpleObjectValue>(updateSimpleObjectValue),
]);

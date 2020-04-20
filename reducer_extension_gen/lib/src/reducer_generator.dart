import 'package:analyzer/dart/element/element.dart' show ClassElement, Element, ParameterElement, ConstructorElement;
import 'package:build/build.dart' show BuildStep;
import 'package:reducer_extension/reducer_extension.dart';
import 'package:source_gen/source_gen.dart' show GeneratorForAnnotation, ConstantReader;

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }

  String unCapitalize() {
    return "${this[0].toLowerCase()}${this.substring(1)}";
  }
}

/// A `Generator` for `package:build_runner`
class ReducerGenerator extends GeneratorForAnnotation<Reducer> {
  @override
  String generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    if (element is! ClassElement) throw "$element is not a ClassElement";
    final ClassElement classElement = element as ClassElement;
    final List<_FieldInfo> sortedFields = _sortedConstructorFields(classElement);

    //Since we do not support generic types, we must suppress these checks
    final ignored_analyzer_rules = '''
    // ignore_for_file: argument_type_not_assignable, implicit_dynamic_type, always_specify_types
    ''';

    return '''
    $ignored_analyzer_rules
    
    ${_generateActions(classElement, sortedFields)}
    ${_generateLocalReducers(classElement, sortedFields)}
    ${_generateReducer(classElement, sortedFields)}
    ''';
  }

  String _generateReducer(
    ClassElement classElement,
    List<_FieldInfo> sortedFields,
  ) {
    String buffer =
        'Reducer<${classElement.name}> ${classElement.name.unCapitalize()}Reducers = combineReducers<${classElement.name}>([';
//    String buffer = 'Reducer<${classElement.name}> combinedReducers<${classElement.name}>([';
    for (_FieldInfo field in sortedFields) {
      buffer += '''
          TypedReducer<${classElement.name}, Update${classElement.name}${field.name.capitalize()}>(update${classElement.name}${field.name.capitalize()}),
              ''';
    }
    buffer += ']);';

    return buffer;
  }

  String _generateLocalReducers(
    ClassElement classElement,
    List<_FieldInfo> sortedFields,
  ) {
    String buffer = '';
    for (_FieldInfo field in sortedFields) {
      buffer += '''
      ${classElement.name} update${classElement.name}${field.name.capitalize()}(${classElement.name} state, Update${classElement.name}${field.name.capitalize()} action) => state.${field.name} != action.${field.name} ? state.copyWith(${field.name}: action.${field.name}) : state; 
      
      ''';
    }

    return buffer;
  }

  String _generateActions(
    ClassElement classElement,
    List<_FieldInfo> sortedFields,
  ) {
    String buffer = '';
    for (_FieldInfo field in sortedFields) {
      buffer += '''
      @immutable
      class Update${classElement.name}${field.name.capitalize()} {
         const Update${classElement.name}${field.name.capitalize()}({this.${field.name}});
         final ${field.type} ${field.name};
      }
      
      ''';
    }

    return buffer;
  }

  List<_FieldInfo> _sortedConstructorFields(ClassElement element) {
    assert(element is ClassElement);

    final constructor = element.unnamedConstructor;
    if (constructor is! ConstructorElement) {
      throw "Default ${element.name} constructor is missing";
    }

    final parameters = constructor.parameters;
    if (parameters is! List<ParameterElement> || parameters.isEmpty) {
      throw "Unnamed constructor for ${element.name} has no parameters";
    }

    parameters.forEach((parameter) {
      if (!parameter.isNamed) {
        throw "Unnamed constructor for ${element.name} contains unnamed parameter. Only named parameters are supported.";
      }
    });

    final fields = parameters.map((v) => _FieldInfo(v)).toList();
    fields.sort((lhs, rhs) => lhs.name.compareTo(rhs.name));

    return fields;
  }
}

class _FieldInfo {
  final String name;
  final String type;

  _FieldInfo(ParameterElement element)
      : this.name = element.name,
        this.type = element.type.name;
}

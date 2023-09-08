part of '../reusable_tools_base.dart';

extension DynamicExt on dynamic {
  String get asString => '$this';
  Map<String, dynamic> get asMapOfStringDynamic => this as Map<String, dynamic>;
  List<dynamic> get asListOfDynamic => this as List<dynamic>;
}

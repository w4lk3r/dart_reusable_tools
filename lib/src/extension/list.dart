part of '../devsdocs_reusable_tools_base.dart';

extension ListOfStringExt on List<String> {
  String get joinPath {
    final pathSeparator = Platform.pathSeparator;
    return join(pathSeparator);
  }

  String get joinDot => join('.');
  String get joinComma => join(',');
}

extension ListOfMapOfStringDynamicExt on List<Map<String, dynamic>> {
  String get toJsonString => json.encode(this);
}

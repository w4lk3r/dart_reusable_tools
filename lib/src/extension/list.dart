part of '../devsdocs_reusable_tools_base.dart';

extension ListOfStringExt on List<String> {
  String get joinPath {
    final pathSeparator = Platform.pathSeparator;
    return join(pathSeparator);
  }

  String get joinDot => join('.');
  String get joinComma => join(',');
  String get joinSpace => join(' ');
}

extension IterableExt on Iterable<String> {
  String get joinSpace => toList().joinSpace;
}

extension ListOfMapOfStringDynamicExt on List<dynamic> {
  String get toJsonString => json.encode(this);
}

extension ListOfIntExt on List<int> {
  String get utf8DecodedString => utf8.decode(this);
}

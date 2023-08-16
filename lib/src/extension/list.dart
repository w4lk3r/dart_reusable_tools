part of '../devsdocs_reusable_tools_base.dart';

extension ListOfStringExt on List<String> {
  String get doJoinPath {
    final pathSeparator = Platform.pathSeparator;
    return join(pathSeparator);
  }

  String get doJoinDot => join('.');
  String get doJoinComma => join(',');
  String get doJoinSpace => join(' ');
}

extension IterableExt on Iterable<String> {
  String get doJoinSpace => toList().doJoinSpace;
}

extension ListOfMapOfStringDynamicExt on List<dynamic> {
  String get getJsonString => json.encode(this);
}

extension ListOfIntExt on List<int> {
  String get getDecodedString => utf8.decode(this);
}

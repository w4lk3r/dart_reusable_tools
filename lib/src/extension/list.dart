part of '../reusable_tools_base.dart';

extension ListOfStringExt on List<String> {
  String get joinPath {
    final pathSeparator = Platform.pathSeparator;
    return map(
      (e) => e.containsSlash
          ? e.replaceAll('/', '')
          : e.containsBackSlash
              ? e.replaceAll(r'\', '')
              : e,
    ).join(pathSeparator);
  }

  String get joinDot => join('.');
  String get joinComma => join(',');
  String get joinSpace => join(' ');
  String get getRandomItem =>
      this[length.getRandomNumberFromZeroToLessThanThis];
}

extension IterableExt on Iterable<String> {
  String get getRandomItem => toList().getRandomItem;
  String get joinSpace => toList().joinSpace;
}

extension ListOfMapOfStringDynamicExt on List<dynamic> {
  String get toJsonString => json.encode(this);
  String get toJsonStringPretty {
    const encoder = JsonEncoder.withIndent('  ');
    return encoder.convert(this);
  }
}

extension ListOfIntExt on List<int> {
  String get utf8DecodedString => utf8.decode(this);
}

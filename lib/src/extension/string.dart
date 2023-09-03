part of '../reusable_tools_base.dart';

extension StringExt on String {
  int get toInt => int.parse(this);
  int? get toIntNull => int.tryParse(this);

  double get toDouble => double.parse(this);
  double? get toDoubleNull => double.tryParse(this);

  num get toNum => num.parse(this);
  num? get toNumNull => num.tryParse(this);

  Uri get toUri => Uri.parse(this);
  Uri? get toUriNull => Uri.tryParse(this);

  List<int> get utf8EncodedBytes => utf8.encode(this);

  String get base64UrlSafeString => base64Url.encode(utf8EncodedBytes);

  String get base64String => base64.encode(utf8.encode(this));

  List<String> get splitDot => split('.');
  List<String> get splitSpace => split(' ');

  dynamic get toJsonObject => json.decode(this);
  Map<String, dynamic> get toJsonObjectAsMap =>
      toJsonObject as Map<String, dynamic>;
  List<dynamic> get toJsonObjectAsList => toJsonObject as List<dynamic>;

  bool get containsDot => contains('.');
  bool get containsSlash => contains('/');
  bool get containsBackSlash => contains(r'\');

  String get capitalizeWord =>
      this[0].toUpperCase() + substring(1).toLowerCase();

  String get capitalizeEachWordInSentence =>
      clean.splitSpace.map((e) => e.capitalizeWord).joinSpace;

  String get clean => trim().replaceAll(RegExp(r'\s{2,}|[\t\r\n]'), ' ');

  String get getRandomItem =>
      this[length.getRandomNumberFromZeroToLessThanThis];
}

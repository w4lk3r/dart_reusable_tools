part of '../devsdocs_reusable_tools_base.dart';

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

  dynamic get jsonObject => json.decode(this);

  bool get containsDot => contains('.');

  String get doCapitalizeWord =>
      this[0].toUpperCase() + substring(1).toLowerCase();

  String get doCapitalizeEachWordInSentence =>
      doClean.splitSpace.map((e) => e.doCapitalizeWord).joinSpace;

  String get doClean => trim().replaceAll(RegExp(r'\s{2,}|[\t\r\n]'), ' ');
}

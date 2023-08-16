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

  List<int> get toUtf8 => utf8.encode(this);

  String get toUrlEncodedBase64 => base64Url.encode(toUtf8);

  String get toBase64 => base64.encode(utf8.encode(this));

  List<String> get doSplitDot => split('.');
  List<String> get doSplitSpace => split(' ');

  dynamic get toJsonObject => json.decode(this);

  bool get isContainsDot => contains('.');

  String get doCapitalizeWord =>
      this[0].toUpperCase() + substring(1).toLowerCase();

  String get doCapitalizeEachWordInSentence =>
      doClean.doSplitSpace.map((e) => e.doCapitalizeWord).doJoinSpace;

  String get doClean => trim().replaceAll(RegExp(r'\s{2,}|[\t\r\n]'), ' ');
}

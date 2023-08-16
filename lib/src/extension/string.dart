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

  List<String> get splitDot => split('.');

  dynamic get toJsonObject => json.decode(this);

  bool get containsDot => contains('.');

  String get capitalizeWord =>
      this[0].toUpperCase() + substring(1).toLowerCase();

  String get clean => trim().replaceAll(RegExp(r'\s{2,}|[\t\r\n]'), ' ');
}

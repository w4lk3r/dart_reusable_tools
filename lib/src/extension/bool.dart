part of '../reusable_tools_base.dart';

extension BoolExt on bool? {
  /// either  '1' or '0'
  String get toStringFlag => this! ? '1' : '0';

  /// either null or '1' or '0'
  String? get toStringFlagOrNull => this != null ? toStringFlag : null;

  String get toCapitalizeString => '$this'.doCapitalizeWord;
}

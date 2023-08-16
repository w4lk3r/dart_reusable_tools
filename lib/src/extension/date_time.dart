part of '../devsdocs_reusable_tools_base.dart';

extension JiffyExt on Jiffy {
  /// YYYY-MM-DD
  String get toYYYYMMDD => yMd
      .split('/')
      .map((e) => e.length == 1 ? '0$e' : e)
      .toList()
      .reversed
      .join('-');

  /// example 2021-07-21 05:07:10
  String get toYYYYMMDDHMS => '$toYYYYMMDD $Hms';
}

extension DateTimeExt on DateTime {
  Jiffy get toJiffy => Jiffy.parseFromDateTime(this);

  String get toYYYYMMDD => toJiffy.toYYYYMMDD;

  String get toYYYYMMDDHMS => toJiffy.toYYYYMMDDHMS;
}

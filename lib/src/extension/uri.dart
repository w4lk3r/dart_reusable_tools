part of '../devsdocs_reusable_tools_base.dart';

extension UriExt on Uri {
  String get fileNameAndExt => pathSegments.last;
  String get fileName => fileNameAndExt.containsDot
      ? fileNameAndExt.splitDot.first
      : fileNameAndExt;
  String get fileExt => fileNameAndExt.containsDot
      ? fileNameAndExt.splitDot.last
      : fileNameAndExt;
}

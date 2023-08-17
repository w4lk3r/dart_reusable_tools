part of '../reusable_tools_base.dart';

extension UriExt on Uri {
  String get getFileNameAndExtension => pathSegments.last;
  String get getFileName => getFileNameAndExtension.containsDot
      ? getFileNameAndExtension.splitDot.first
      : getFileNameAndExtension;
  String get getFileExtension => getFileNameAndExtension.containsDot
      ? getFileNameAndExtension.splitDot.last
      : getFileNameAndExtension;
}

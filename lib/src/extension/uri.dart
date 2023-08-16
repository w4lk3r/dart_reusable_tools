part of '../devsdocs_reusable_tools_base.dart';

extension UriExt on Uri {
  String get getFileNameAndExtension => pathSegments.last;
  String get getFileName => getFileNameAndExtension.isContainsDot
      ? getFileNameAndExtension.doSplitDot.first
      : getFileNameAndExtension;
  String get getFileExtension => getFileNameAndExtension.isContainsDot
      ? getFileNameAndExtension.doSplitDot.last
      : getFileNameAndExtension;
}

part of '../devsdocs_reusable_tools_base.dart';

extension MapExt on Map<String, dynamic> {
  String get toJsonString => json.encode(this);
}

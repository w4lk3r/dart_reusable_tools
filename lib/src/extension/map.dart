part of '../reusable_tools_base.dart';

extension MapExt on Map<String, dynamic> {
  String get toJsonString => json.encode(this);
  String get toJsonStringPretty {
    const encoder = JsonEncoder.withIndent('  ');
    return encoder.convert(this);
  }
}

part of '../reusable_tools_base.dart';

extension MapOfStringDynamicExt on Map<String, dynamic> {
  String get toJsonString => json.encode(this);
  String get toJsonStringPretty {
    const encoder = JsonEncoder.withIndent('  ');
    return encoder.convert(this);
  }
}

extension MapExt on Map {
  void get removeNullOrEmptyValue => removeWhere((_, v) {
        if (v is List) {
          if (v.isEmpty) return true;
        }
        if (v is Map) {
          if (v.isEmpty) return true;
        }
        if (v is String) {
          if (v.isEmpty) return true;
        }
        if (v == null) return true;
        return false;
      });
}

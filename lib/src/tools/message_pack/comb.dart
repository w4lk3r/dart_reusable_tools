import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:async/async.dart';

part 'common.dart';
part 'writer.dart';
part 'des.dart';
part 'str_des.dart';
part 'ser.dart';
part 'str_ser.dart';

/// Copied from https://github.com/SilverMira/msgpack_dart

class JsonPacker {
  static Uint8List serialize(
    dynamic value, {
    ExtEncoder? extEncoder,
  }) {
    final s = Serializer(extEncoder: extEncoder);
    s.encode(value);
    return s.takeBytes();
  }

  static dynamic deserialize(
    Uint8List list, {
    ExtDecoder? extDecoder,
    bool copyBinaryData = false,
  }) {
    final d = Deserializer(
      list,
      extDecoder: extDecoder,
      copyBinaryData: copyBinaryData,
    );
    return d.decode();
  }
}

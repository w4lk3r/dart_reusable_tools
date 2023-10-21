part of 'comb.dart';

/// A [StreamTransformer] that serializes objects in the stream into [Uint8List]s
/// using MessagePack specification.
///
/// Internally, it uses the [Serializer] class to handles the serialization.
/// This class is useful as an abstraction layer for the [Serializer] class for streams.
/// Alternatively, you can use the [Serializer] class directly.
class StreamSerializer<T> extends StreamTransformerBase<T, Uint8List> {
  factory StreamSerializer({
    DataWriter? dataWriter,
    ExtEncoder? extEncoder,
  }) =>
      StreamSerializer.withSerializer(
        Serializer(
          dataWriter: dataWriter,
          extEncoder: extEncoder,
        ),
      );
  StreamSerializer.withSerializer(this.serializer);
  final Serializer serializer;

  @override
  Stream<Uint8List> bind(Stream<T> stream) async* {
    await for (final value in stream) {
      serializer.encode(value);
      yield serializer.takeBytes();
    }
  }
}

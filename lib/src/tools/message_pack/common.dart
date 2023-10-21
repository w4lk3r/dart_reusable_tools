part of 'comb.dart';

class FormatError implements Exception {
  FormatError(this.message);
  final String message;

  @override
  String toString() {
    return 'FormatError: $message';
  }
}

/// The upstream stream closed unexpectedly while in the midst of decoding a message.
/// Thrown from [StreamDeserializer]
class UpstreamClosedError implements Exception {
  UpstreamClosedError();
  final String message = 'Upstream closed unexpectedly';

  @override
  String toString() {
    return 'UpstreamClosedError: $message';
  }
}

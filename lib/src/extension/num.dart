part of '../reusable_tools_base.dart';

extension DoubleExt on double {
  num toPrecision(int fractionDigits) {
    if (_canBeInt) return toInt();
    final mod = pow(10, fractionDigits.toDouble()).toDouble();
    final calculation = (this * mod).round().toDouble() / mod;
    return calculation._canBeInt ? calculation.toInt() : calculation;
  }

  bool get _canBeInt => this % 1 == 0;

  num get toIntIfTrue => _canBeInt ? toInt() : this;

  double get getRandomDouble => Random().nextDouble();
}

extension IntExt on int {
  String get bytesToBinaryPrefix => _formatBytes(this, binaryPrefixes: true);
  String get bytesToSIUnit => _formatBytes(this, binaryPrefixes: false);

  int get getRandomInt => Random().nextInt(this);

  String _formatBytes(int bytes, {required bool binaryPrefixes}) {
    if (bytes <= 0) return 'Unknown Size';

    final int base = binaryPrefixes ? 1024 : 1000;
    final List<String> suffixes = binaryPrefixes
        ? ['B', 'KiB', 'MiB', 'GiB', 'TiB', 'PiB', 'EiB', 'ZiB', 'YiB']
        : ['B', 'kB', 'MB', 'GB', 'TB', 'PB', 'EB', 'ZB', 'YB'];

    final int i =
        (log(bytes) / log(base)).floor().clamp(0, suffixes.length - 1);
    final double value = bytes / pow(base, i);

    return '${value.toIntIfTrue} ${suffixes[i]}';
  }
}

extension NumExtension on num {
  num get ln => log(this);
  num get log2 => log(this) / ln2;
  num get log10 => log(this) / ln10;
}

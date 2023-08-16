part of '../devsdocs_reusable_tools_base.dart';

extension DoubleExt on double {
  double toPrecision(int fractionDigits) {
    final mod = pow(10, fractionDigits.toDouble()).toDouble();
    return (this * mod).round().toDouble() / mod;
  }

  double get toPrecisionOf1 => toPrecision(1);
  double get toPrecisionOf2 => toPrecision(2);
  double get toPrecisionOf3 => toPrecision(3);

  num get toIntIfTrue => num.parse('$this').toIntIfTrue;
}

extension NumExt on num {
  num get toIntIfTrue => this % 1 == 0 ? toInt() : toDouble().toPrecisionOf2;
}

extension IntExt on int {
  String get byteToBinaryPrefix => formatBytes(this, binaryPrefixes: true);
  String get byteToSIUnit => formatBytes(this, binaryPrefixes: false);

  String formatBytes(int bytes, {required bool binaryPrefixes}) {
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

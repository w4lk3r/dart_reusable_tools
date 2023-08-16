part of '../devsdocs_reusable_tools_base.dart';

extension DoubleExt on double {
  double _getPrecision(int fractionDigits) {
    if (toIntIfTrue is int) return this;
    final mod = pow(10, fractionDigits.toDouble()).toDouble();
    return (this * mod).round().toDouble() / mod;
  }

  double get getPrecisionOf1 => _getPrecision(1);
  double get getPrecisionOf2 => _getPrecision(2);
  double get getPrecisionOf3 => _getPrecision(3);
  double get getPrecisionOf4 => _getPrecision(4);
  double get getPrecisionOf5 => _getPrecision(5);

  num get toIntIfTrue => num.parse('$this').toIntIfTrue;
}

extension NumExt on num {
  num get toIntIfTrue => this % 1 == 0 ? toInt() : toDouble().getPrecisionOf2;
}

extension IntExt on int {
  String get doByteToBinaryPrefix => _formatBytes(this, binaryPrefixes: true);
  String get doByteToSIUnit => _formatBytes(this, binaryPrefixes: false);

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

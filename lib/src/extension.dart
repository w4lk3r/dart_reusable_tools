part of 'devsdocs_reusable_tools_base.dart';

enum SizeUnit {
  bytes,
  kilobytes,
  megabytes,
  gigabytes,
  terabytes,
  petabytes,
  exabytes,
  zetabytes,
  yotabytes,
}

num convertSize(int size, SizeUnit fromUnit, SizeUnit toUnit) {
  const units = SizeUnit.values;
  final fromIndex = units.indexOf(fromUnit);
  final toIndex = units.indexOf(toUnit);

  final difference = fromIndex - toIndex;

  if (difference == 0) {
    return size;
  } else {
    num result;
    if (difference > 0) {
      result = size * pow(1024, difference);
    } else {
      result = size / pow(1024, difference.abs());
    }
    return result.toIntIfTrue;
  }
}

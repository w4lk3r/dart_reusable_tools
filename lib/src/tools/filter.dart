import 'dart:io';

void main() {
  final file = File('words.txt').readAsLinesSync();

  final buff = StringBuffer();
  buff.write('const words = <String>[\n');
  for (final a in file) {
    if (a.length > 3) {
      buff.write("'$a',\n");
    }
  }
  buff.write('\n];\n');

  File('words.dart').writeAsStringSync(buff.toString());
}

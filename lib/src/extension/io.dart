part of '../devsdocs_reusable_tools_base.dart';

extension FileExt on File {
  /// Get unique file ID using [sha256]
  Future<String> get getSha256Async async =>
      '${sha256.convert(await readAsBytes())}';
  Future<String> get getMd5Async async => '${md5.convert(await readAsBytes())}';
  Future<String> get getSha1Async async =>
      '${sha1.convert(await readAsBytes())}';
  Future<String> get getBase64Async async => base64.encode(await readAsBytes());

  String get getSha256 => '${sha256.convert(readAsBytesSync())}';
  String get getMd5 => '${md5.convert(readAsBytesSync())}';
  String get getSha1 => '${sha1.convert(readAsBytesSync())}';
  String get getBase64 => base64.encode(readAsBytesSync());

  String get getFileNameAndExtension => uri.getFileNameAndExtension;
  String get getFileName => uri.getFileName;
  String get getFileExtension => uri.getFileExtension;

  Future<MultipartFile> get toMultipartAsync async =>
      MultipartFile.fromFile(path);
  MultipartFile get toMultipart => MultipartFile.fromFileSync(path);
}

extension DirectoryExt on Directory {
  Future<Directory> get doCheckAsync async =>
      await exists() ? this : await create(recursive: true);
  Directory get doCheck => existsSync() ? this : this
    ..createSync(recursive: true);
}

part of '../devsdocs_reusable_tools_base.dart';

extension FileExt on File {
  /// Get unique file ID using [sha256]
  Future<String> get toSha256 async => '${sha256.convert(await readAsBytes())}';
  Future<String> get toMd5 async => '${md5.convert(await readAsBytes())}';
  Future<String> get toSha1 async => '${sha1.convert(await readAsBytes())}';

  String get fileNameAndExt => uri.fileNameAndExt;
  String get fileName => uri.fileName;
  String get fileExt => uri.fileExt;

  Future<MultipartFile> get toMultipart async => MultipartFile.fromFile(path);
}

extension DirectoryExt on Directory {
  Future<Directory> get check async =>
      await exists() ? this : await create(recursive: true);
}

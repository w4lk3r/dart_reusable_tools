part of 'devsdocs_reusable_tools_base.dart';

StreamController<FileTransferProgress> transferProgress =
    StreamController<FileTransferProgress>.broadcast();

/// If [useBinaryPrefix] then the displayed unit of data masurement in binary prefix format. Example: MiB instead of MB (SI Unit) or KiB instead of KB (SI Unit).
class FileTransferProgress {
  FileTransferProgress(
    this.id, {
    this.name,
    this.current,
    this.total,
    this.isUpload = true,
    this.additionalFilter,
    this.useBinaryPrefix = true,
  });
  final String? id;
  final Object? additionalFilter;
  final String? name;
  final int? current;
  final int? total;
  final bool isUpload;
  final bool useBinaryPrefix;

  FileTransferProgress copyWith({
    String? id,
    Object? additionalFilter,
    String? name,
    int? current,
    int? total,
    bool? isUpload,
    bool? useBinaryPrefix,
  }) =>
      FileTransferProgress(
        id ?? this.id,
        additionalFilter: additionalFilter ?? this.additionalFilter,
        name: name ?? this.name,
        current: current ?? this.current,
        total: total ?? this.total,
        isUpload: isUpload ?? this.isUpload,
        useBinaryPrefix: useBinaryPrefix ?? this.useBinaryPrefix,
      );

  @override
  String toString() =>
      '${isUpload ? 'Uploading' : 'Downloading'} $name => ${useBinaryPrefix ? current!.byteToBinaryPrefix : current!.byteToSIUnit}/${useBinaryPrefix ? total!.byteToBinaryPrefix : total!.byteToSIUnit}';
}

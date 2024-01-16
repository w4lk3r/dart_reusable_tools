// part of '../reusable_tools_base.dart';

// class NetworkTools {
//   factory NetworkTools() => _instance ??= NetworkTools._internal();
//   NetworkTools._internal();
//   static NetworkTools? _instance;

//   static _LogConfig get logConfig => _logConfig ??= _LogConfig();

//   static set logConfig(_LogConfig value) => _logConfig = value;

//   static _LogConfig? _logConfig;

//   static _HttpClient get client => _HttpClient();

//   static void initLog() {
//     if (logConfig.enableLog) {
//       client.interceptors.add(
//         LogInterceptor(
//           requestBody: logConfig.showRequestBody,
//           responseBody: logConfig.showResponseBody,
//           error: logConfig.showError,
//           request: logConfig.showRequest,
//           requestHeader: logConfig.showRequestHeader,
//           responseHeader: logConfig.showResponseHeader,
//         ),
//       );
//     }
//   }
// }

// class _LogConfig {
//   factory _LogConfig({
//     bool enableLog = false,
//     bool request = true,
//     bool requestHeader = true,
//     bool requestBody = true,
//     bool responseHeader = true,
//     bool responseBody = true,
//     bool error = true,
//   }) =>
//       _instance ??= _LogConfig._internal(
//         enableLog: enableLog,
//         showRequest: request,
//         showRequestHeader: requestHeader,
//         showRequestBody: requestBody,
//         showResponseHeader: responseHeader,
//         showResponseBody: responseBody,
//         showError: error,
//       );

//   _LogConfig._internal({
//     required this.enableLog,
//     required this.showRequest,
//     required this.showRequestHeader,
//     required this.showRequestBody,
//     required this.showResponseHeader,
//     required this.showResponseBody,
//     required this.showError,
//   });

//   bool enableLog;
//   bool showRequest;
//   bool showRequestHeader;
//   bool showRequestBody;
//   bool showResponseHeader;
//   bool showResponseBody;
//   bool showError;

//   static _LogConfig? _instance;

//   @override
//   String toString() =>
//       'Log Enabled: ${enableLog.toCapitalizeString}\nShow Request: ${showRequest.toCapitalizeString}\nShow Request Header: ${showRequestHeader.toCapitalizeString}\nShow Request Body: ${showRequestBody.toCapitalizeString}\nShow Response Header: ${showResponseHeader.toCapitalizeString}\nShow Response Body: ${showResponseBody.toCapitalizeString}\nShow Error: ${showError.toCapitalizeString}';
// }

// class _HttpClient {
//   factory _HttpClient() => _instance ??= _HttpClient._internal();

//   _HttpClient._internal();
//   final _dio = Dio();

//   static _HttpClient? _instance;

//   Interceptors get interceptors => _dio.interceptors;

//   BaseOptions get baseOptions => _dio.options;

//   Options get options => Options();

//   Future<dynamic> downloadUri(
//     Uri uri,
//     File destinatonFile, {
//     Options? options,
//     required FileTransferProgress fileTransferProgress,
//     bool useIsolate = false,
//   }) =>
//       download(
//         '$uri',
//         options: options,
//         destinatonFile,
//         fileTransferProgress: fileTransferProgress,
//       );

//   Future<dynamic> download(
//     String path,
//     File destinatonFile, {
//     Options? options,
//     required FileTransferProgress fileTransferProgress,
//     bool useIsolate = false,
//   }) async {
//     dynamic data;
//     ReceivePort? receivePort;

//     try {
//       if (useIsolate) {
//         receivePort = ReceivePort();
//         receivePort.listen((message) {
//           message as Map<int, int>;
//           transferProgress.add(
//             fileTransferProgress.copyWith(
//               current: message.keys.single,
//               total: message.values.single,
//             ),
//           );
//         });

//         await Isolate.spawn(
//           (data) async {
//             await _dio.download(
//               path,
//               destinatonFile.path,
//               options: options,
//               onReceiveProgress: (current, total) =>
//                   data.send({current: total}),
//             );
//           },
//           receivePort.sendPort,
//         );
//       } else {
//         await _dio.download(
//           path,
//           destinatonFile.path,
//           options: options,
//           onReceiveProgress: (current, total) => transferProgress.add(
//             fileTransferProgress.copyWith(
//               current: current,
//               total: total,
//             ),
//           ),
//         );
//       }
//     } on DioException catch (e) {
//       return data = e;
//     } catch (_) {
//       return data;
//     }
//   }

//   Future<dynamic> deleteUri(
//     Uri uri, {
//     required String data,
//     Options? options,
//   }) async =>
//       delete('$uri', data: data, options: options);

//   Future<dynamic> delete(
//     String path, {
//     required String data,
//     Options? options,
//   }) async {
//     dynamic data;
//     try {
//       return data =
//           (await _dio.delete<dynamic>(path, data: data, options: options)).data;
//     } on DioException catch (e) {
//       return data = '$e';
//     } catch (_) {
//       return data;
//     }
//   }

//   Future<dynamic> getUri(
//     Uri uri, {
//     Options? options,
//     bool useIsolate = false,
//   }) async =>
//       get(
//         '$uri',
//         options: options,
//         useIsolate: useIsolate,
//       );

//   Future<dynamic> get(
//     String path, {
//     Options? options,
//     bool useIsolate = false,
//   }) async {
//     dynamic data;

//     try {
//       return data = useIsolate
//           ? await Isolate.run(
//               () async => (await _dio.get<dynamic>(
//                 path,
//                 options: options,
//               ))
//                   .data,
//             )
//           : (await _dio.get<dynamic>(
//               path,
//               options: options,
//             ))
//               .data;
//     } on DioException catch (e) {
//       return data = '$e';
//     } catch (_) {
//       return data;
//     }
//   }

//   Future<dynamic> putUri(
//     Uri uri, {
//     required String data,
//     Options? options,
//   }) async =>
//       put('$uri', data: data, options: options);

//   Future<dynamic> put(
//     String path, {
//     required String data,
//     Options? options,
//   }) async {
//     dynamic data;

//     try {
//       return data =
//           (await _dio.put<dynamic>(path, data: data, options: options)).data;
//     } on DioException catch (e) {
//       return data = '$e';
//     } catch (_) {
//       return data;
//     }
//   }

//   Future<dynamic> postUri(
//     Uri uri, {
//     List<MapEntry<String, String>>? fields,
//     List<MapEntry<String, MultipartFile>>? files,
//     dynamic nonMultipartFormData,
//     FileTransferProgress? fileTransferProgress,
//     Options? options,
//     bool camelCaseContentDisposition = false,
//     bool useIsolate = false,
//   }) async =>
//       post(
//         '$uri',
//         useIsolate: useIsolate,
//         fields: fields,
//         files: files,
//         fileTransferProgress: fileTransferProgress,
//         options: options,
//         camelCaseContentDisposition: camelCaseContentDisposition,
//         nonMultipartFormData: nonMultipartFormData,
//       );

//   Future<dynamic> post(
//     String path, {
//     List<MapEntry<String, String>>? fields,
//     List<MapEntry<String, MultipartFile>>? files,
//     dynamic nonMultipartFormData,
//     FileTransferProgress? fileTransferProgress,
//     Options? options,
//     bool camelCaseContentDisposition = false,
//     bool useIsolate = false,
//   }) async {
//     final formData =
//         FormData(camelCaseContentDisposition: camelCaseContentDisposition)
//           ..fields.addAll(fields ?? [])
//           ..files.addAll(files ?? []);

//     final dataToSend = nonMultipartFormData ?? formData;

//     dynamic data;
//     ReceivePort? transferReceivePort;
//     ReceivePort? responseReceivePort;

//     try {
//       if (useIsolate) {
//         if (fileTransferProgress != null) {
//           final completer = Completer<dynamic>();
//           transferReceivePort = ReceivePort();
//           responseReceivePort = ReceivePort();
//           transferReceivePort.listen((message) {
//             message as Map<int, int>;
//             transferProgress.add(
//               fileTransferProgress.copyWith(
//                 current: message.keys.single,
//                 total: message.values.single,
//               ),
//             );
//           });
//           responseReceivePort.listen((message) {
//             message as String?;
//             completer.complete(message);
//           });

//           await Isolate.spawn(
//             (data) async {
//               final getData = await _dio.post<dynamic>(
//                 path,
//                 data: dataToSend,
//                 options: options,
//                 onSendProgress: (current, total) => data.send({current: total}),
//               );

//               responseReceivePort?.sendPort.send(getData.data);
//             },
//             transferReceivePort.sendPort,
//           );

//           return data = await completer.future;
//         } else {
//           return data = await Isolate.run(
//             () async => (await _dio.post<dynamic>(
//               path,
//               data: dataToSend,
//               options: options,
//             ))
//                 .data,
//           );
//         }
//       } else {
//         return data = (await _dio.post<dynamic>(
//           path,
//           data: dataToSend,
//           options: options,
//           onSendProgress: fileTransferProgress != null
//               ? (current, total) => transferProgress.add(
//                     fileTransferProgress.copyWith(
//                       current: current,
//                       total: total,
//                     ),
//                   )
//               : null,
//         ))
//             .data;
//       }
//     } on DioException catch (e) {
//       return data = '$e';
//     } catch (_) {
//       return data;
//     }
//   }
// }

// StreamController<FileTransferProgress> transferProgress =
//     StreamController<FileTransferProgress>.broadcast();

// /// If [useBinaryPrefix] then the displayed unit of data masurement in binary prefix format. Example: MiB instead of MB (SI Unit) or KiB instead of KB (SI Unit).
// class FileTransferProgress {
//   FileTransferProgress(
//     this.id, {
//     required this.name,
//     this.current,
//     this.total,
//     this.isUpload = true,
//     this.additionalFilter,
//     this.useBinaryPrefix = false,
//   });
//   final String id;
//   final Object? additionalFilter;
//   final String name;
//   final int? current;
//   final int? total;
//   final bool isUpload;
//   final bool useBinaryPrefix;

//   FileTransferProgress copyWith({
//     String? id,
//     Object? additionalFilter,
//     String? name,
//     int? current,
//     int? total,
//     bool? isUpload,
//     bool? useBinaryPrefix,
//   }) =>
//       FileTransferProgress(
//         id ?? this.id,
//         additionalFilter: additionalFilter ?? this.additionalFilter,
//         name: name ?? this.name,
//         current: current ?? this.current,
//         total: total ?? this.total,
//         isUpload: isUpload ?? this.isUpload,
//         useBinaryPrefix: useBinaryPrefix ?? this.useBinaryPrefix,
//       );

//   @override
//   String toString() {
//     final currentDisplay =
//         useBinaryPrefix ? current!.bytesToBinaryPrefix : current!.bytesToSIUnit;
//     final totalDisplay =
//         useBinaryPrefix ? total!.bytesToBinaryPrefix : total!.bytesToSIUnit;

//     return '${isUpload ? 'Uploading' : 'Downloading'} $name => $currentDisplay/$totalDisplay';
//   }
// }

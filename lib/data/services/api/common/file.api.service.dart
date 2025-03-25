part of 'package:googly_app/data/services/api/api_import.dart';

class FileAPI {
  final Dio dio;
  final Dio externalDio;

  FileAPI({required this.dio, required this.externalDio});
  final basePath = '/file';

  /// Get PreSigned Url From Server
  Future<Response<dynamic>> requestPhotoUrl(FileUploadModel uploadModel) async {
    try {
      return dio.post(basePath, data: uploadModel.toJson());
    } catch (e) {
      rethrow;
    }
  }

  /// Compress Image And Upload to Firebase
  Future<Response<dynamic>> uploadPhoto({required File entity, required String url, required String extension}) async {
    try {
      var file = entity;
      var temporaryDirectory = await getTemporaryDirectory();
      // XFile xFile = XFile(file.path);
      print(await file.length());
      var uploadFile = await FlutterImageCompress.compressAndGetFile(
        file.path,
        '${temporaryDirectory.absolute.path}/${DateTime.now().microsecondsSinceEpoch}.webp',
        format: CompressFormat.webp,
        quality: 40,
      );
      print(await uploadFile?.length());

      Options options = Options(
        headers: {
          'Accept': "*/*",
          'Content-Length': (await uploadFile!.length()).toString(),
          'Connection': 'keep-alive',
          'Content-Type': 'image/$extension',
        },
      );

      return await externalDio.put(url,
          data: uploadFile.openRead(), options: options);
    } catch (e) {
      rethrow;
    }
  }
}

part of 'api_import.dart';

class AppInterceptors extends Interceptor {
  //  AppInterceptors({required appService}): _appService= appService;
  //  AppInterceptors({required appService}): _appService= appService;

  final bool isExternal;
  AppInterceptors({this.isExternal = false});

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    printInfo( info: '\nRequest type: ${options.method} API request: ${options.uri}');
    // printInfo(info: "\nAPI headers: ${options.headers}");
    // printInfo(info: "\nAPI data: ${options.data}");

    if (isExternal) return handler.next(options);
    var accessToken = gt.Get.find<DatabaseService>().accessToken;
    bool? skipToken = options.extra['skipToken'];
    if (accessToken != null) {
      if (skipToken ?? true) {
        options.headers['Authorization'] = 'Bearer $accessToken';
      }
    }
    return handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // debugPrint('Api Error: ${err.requestOptions.method} ${err.response?.statusCode} ${err.requestOptions.uri}');
    // debugPrint('Error Message:  ${err.response?.statusMessage}');
    switch (err.type) {
      case DioExceptionType.sendTimeout:
        throw DefaultException(err.requestOptions, err,
            msg: ErrorStrings.timeOut);
      case DioExceptionType.receiveTimeout:
        throw DeadlineExceededException(err.requestOptions);
      case DioExceptionType.badResponse:
        switch (err.response?.statusCode) {
          case 400:
            throw BadRequestException(err.requestOptions, err);
          case 401:
            throw UnauthorizedException(err.requestOptions);
          case 404:
            throw NotFoundException(err.requestOptions);
          case 409:
            throw ConflictException(err.requestOptions);
          case 500:
            throw InternalServerErrorException(err.requestOptions);
          case 504:
            throw DeadlineExceededException(err.requestOptions);
          case 406:
            throw OtpTimeError(err.requestOptions, err);
          case 429:
            throw OtpTimeError(err.requestOptions, err);
        }
        break;
      case DioExceptionType.cancel:
        throw DefaultException(err.requestOptions, err,
            msg: ErrorStrings.cancel);
      case DioExceptionType.connectionTimeout:
        throw DefaultException(err.requestOptions, err,
            msg: ErrorStrings.timeOut);
      case DioExceptionType.badCertificate:
        throw DefaultException(err.requestOptions, err);
      case DioExceptionType.connectionError:
        throw NoInternetConnectionException(err.requestOptions);
      case DioExceptionType.unknown:
        throw DefaultException(err.requestOptions, err);
    }
    return handler.next(err);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // debugPrint('Request type: ${response.requestOptions.method}');
    // debugPrint('Request Success: ${response.statusCode}');
    // debugPrint('Request Success: ${response.statusCode} \ndata: ${response.data}');
    if (response.statusCode.toString().startsWith('2')) {
      response.extra['done'] = true;
    }
    super.onResponse(response, handler);
  }
}

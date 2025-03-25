part of 'api_import.dart';

class ApiService extends GetxService {
  /// Initializing dio object
  Future<ApiService> init() async {
    debugPrint(ErrorStrings.apiService);
    dio = createDio();
    externalDio = createDio(isExternal: true);
    return this;
  }

  /// dio object to make api call to backend server
  late Dio dio;

  /// dio object to make api call to outside api server [upload files to storage]
  late Dio externalDio;

  /// Server url to development server
  var serverUrl = 'http://campus-development.saplynx.com';

  /// SHA fingerprints for certificate pinning
  // List<String> allowedSHAFingerprints = ['20:12:97:49:15:CA:8F:11:F8:01:36:A2:C8:A9:8E:E0:05:DE:D0:61:A2:98:72:10:13:29:51:15:CE:92:7C:27'];
  // List<String> allowedSHAFingerprints = ['43:D0:56:9D:12:9C:27:32:F5:55:30:9B:F3:3A:19:CA:DB:73:83:D9:B2:C4:E8:50:C0:0D:7A:A4:6D:C6:7C:C1'];

  Dio createDio({bool isExternal = false}) {
    var customServerURL = gt.Get.find<DatabaseService>().customServerURL;
    Dio dio;

    if (isExternal) {
      dio = Dio(
          BaseOptions(baseUrl: isExternal ? '' : customServerURL ?? serverUrl));
    } else {
      dio = Dio(
          BaseOptions(baseUrl: isExternal ? '' : customServerURL ?? serverUrl));
      //..interceptors.add(CertificatePinningInterceptor(allowedSHAFingerprints: allowedSHAFingerprints));
    }
    // ..interceptors.add(DioCacheInterceptor(options: options))

    /// dio interceptors to handel the errors and responses
    dio.interceptors.addAll({
      /// intercept for req and res
      AppInterceptors(isExternal: isExternal),

      /// interceptor for log the error and responses
      // PrettyDioLogger(
      //     requestHeader: false,
      //     requestBody: true,
      //     responseBody: true,
      //     responseHeader: false,
      //     error: true,
      //     compact: true,
      //     maxWidth: 90)
    });
    return dio;
  }
}

/* // Global options
  final options = CacheOptions(
    // A default store is required for interceptor.
    store: HiveCacheStore(null),
    // All subsequent fields are optional.
    // Default.
    policy: CachePolicy.request,
    // Returns a cached response on error but for statuses 401 & 403.
    // Also allows to return a cached response on network errors (e.g. offline usage).
    // Defaults to [null].
    hitCacheOnErrorExcept: [401, 403],
    // Overrides any HTTP directive to delete entry past this duration.
    // Useful only when origin server has no cache config or custom behaviour is desired.
    // Defaults to [null].
    maxStale: const Duration(days: 7),
    // Default. Allows 3 cache sets and ease cleanup.
    priority: CachePriority.normal,
    // Default. Body and headers encryption with your own algorithm.
    cipher: null,
    // Default. Key builder to retrieve requests.
    keyBuilder: CacheOptions.defaultCacheKeyBuilder,
    // Default. Allows to cache POST requests.
    // Overriding [keyBuilder] is strongly recommended when [true].
    allowPostMethod: false,
  );

  */

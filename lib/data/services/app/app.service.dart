part of 'app_service_imports.dart';

class AppService extends GetxService {
  Future<AppService> init() async {
    await initiateServices();
    return this;
  }

  Future<void> initiateServices() async {
    await Future.wait([
     Get.putAsync(() => DatabaseService().init()),
     Get.putAsync(() => MessagingService().init())
    ]);

    await Get.putAsync(() => ApiService().init());

    await Future.wait([
      Get.putAsync(() => GeolocationService().init()),
      Get.putAsync(() => DeviceInfoService().init()),

    ]);

     await initializeApiServices(Get.find<ApiService>());
     // await initializeRepositories();


  }

  Future<void> initializeApiServices(ApiService apiService) async{

    /// Initialize and put the FileAPI
     Get.put( FileAPI(dio: apiService.dio, externalDio: apiService.externalDio));



  }
}

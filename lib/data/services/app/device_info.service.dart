part of 'app_service_imports.dart';


class DeviceInfoService extends GetxService{

  late MessagingService ms;
  AndroidDeviceInfo? androidInfo;
  IosDeviceInfo? iosInfo;
  late PackageInfo packageInfo;

  Future<DeviceInfoService> init() async {
    ms = MessagingService();
    packageInfo = await PackageInfo.fromPlatform();
    if (defaultTargetPlatform == TargetPlatform.android) {
      androidInfo = await DeviceInfoPlugin().androidInfo;
    } else if (defaultTargetPlatform == TargetPlatform.iOS) {
      iosInfo = await DeviceInfoPlugin().iosInfo;
    }
    return this;
  }

  Future<DeviceInfoModel> getDeviceInfo() async {
    String firebaseToken, deviceId, deviceModel, deviceOs, appVersion = '';

    firebaseToken = await ms.getFirebaseToken() ?? '';

    String appName = packageInfo.appName;
    String version = packageInfo.version;
    String buildNumber = packageInfo.buildNumber;
    appVersion = '$appName (version $version build $buildNumber)';

    if (defaultTargetPlatform == TargetPlatform.android) {
      deviceId = androidInfo?.id ?? '';
      deviceModel = androidInfo?.brand ?? '';
      deviceOs = androidInfo?.version.release ?? '';
    } else if (defaultTargetPlatform == TargetPlatform.iOS) {
      deviceId = iosInfo?.identifierForVendor ?? '';
      deviceModel = iosInfo?.model ?? '';
      deviceOs = iosInfo?.systemName ?? iosInfo?.systemVersion ?? '';
    } else {
      deviceId = '';
      deviceModel = '';
      deviceOs = '';
    }

    return DeviceInfoModel(
      deviceId: deviceId,
      firebaseToken: firebaseToken,
      deviceModel: deviceModel,
      deviceOs: deviceOs,
      appVersion: appVersion,
    );
  }
}

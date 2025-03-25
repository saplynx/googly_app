part of 'package:googly_app/models/model_imports.dart';

class DeviceInfoModel {
    DeviceInfoModel({
        required this.deviceId,
        required this.firebaseToken,
        required this.deviceModel,
        required this.deviceOs,
        required this.appVersion,
    });

    String deviceId;
    String firebaseToken;
    String deviceModel;
    String deviceOs;
    String appVersion;

    factory DeviceInfoModel.fromRawJson(String str) => DeviceInfoModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory DeviceInfoModel.fromJson(Map<String, dynamic> json) => DeviceInfoModel(
        deviceId: json["deviceId"],
        firebaseToken: json["firebaseToken"],
        deviceModel: json["deviceModel"],
        deviceOs: json["deviceOS"],
        appVersion: json["appVersion"],
    );

    Map<String, dynamic> toJson() => {
        "device_id": deviceId,
        "firebase_token": firebaseToken,
        "device_model": deviceModel,
        "device_os": deviceOs,
        "app_version": appVersion,
    };
}

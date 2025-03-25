import 'dart:async';


import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../../../core/Strings/preference_keys.dart' show PreferenceKeys;
import '../../../models/model_imports.dart' show DeviceInfoModel, FirebaseNotificationModel;
import '../../../modules/common/toast/toast.dart';
import '../api/api_import.dart' show ApiService, FileAPI;


part 'app.service.dart';
part 'database.service.dart';
part 'device_info.service.dart';
part 'location.service.dart';
part 'messaging.service.dart';
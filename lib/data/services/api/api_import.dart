import 'dart:io' show File;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:get/get.dart' as gt;
import 'package:dio/dio.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path_provider/path_provider.dart' show getTemporaryDirectory;


import '../../../core/Strings/error.string.dart';
import '../../../main.dart' show TempContext;
import '../../../models/model_imports.dart' show FileUploadModel;
import '../../../modules/common/toast/toast.dart' show showToast;
import '../app/app_service_imports.dart' show AppService, DatabaseService;

/// api service imports
part 'api.service.dart';
part 'exceptions.dart';
part 'interceptors.dart';
part 'common/file.api.service.dart';
part 'common/notification.service.dart';

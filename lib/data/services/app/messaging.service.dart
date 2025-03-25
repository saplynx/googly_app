part of 'app_service_imports.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.

  debugPrint("Handling a background message: ${message.messageId}");
}

void onDidReceiveLocalNotificationResponse(NotificationResponse response) {
  if(response.payload != null) {
    var firebaseNotification = FirebaseNotificationModel.fromRawJson(response.payload!);

    if (firebaseNotification.path != null) {
      Get.toNamed(firebaseNotification.path!);
    }
  }
}

/// Navigate to route using path of
void onMessageOpenedApp(RemoteMessage message) {
  var firebaseNotification = FirebaseNotificationModel.fromJson(message.data);

  if (firebaseNotification.path != null) {
    Get.toNamed(firebaseNotification.path!);
  }
}
void msg() {
  // For handling notification when the app is in the foreground
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {

    showToast(message: 'received Foreground Notification');

  });
}
/// Service Class
class MessagingService  extends GetxService{

  /// Initialise Firebase instance
  Future<MessagingService> init() async {

   try{

      requestPermission();

      await initializeLocalNotifications();

      manageNotificationChannel();

      FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

      await FirebaseMessaging.instance.getToken();

      msg();

      FirebaseMessaging.onMessageOpenedApp.listen(onMessageOpenedApp);

      await flutterLocalNotificationsPlugin.initialize(
        const InitializationSettings(android: AndroidInitializationSettings('notification_icon')),
        onDidReceiveNotificationResponse: onDidReceiveLocalNotificationResponse,
        onDidReceiveBackgroundNotificationResponse: onDidReceiveLocalNotificationResponse,
      );
   // ignore: empty_catches
   }catch(e){}
    return this;
  }

  /// Firebase instance
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  /// Get Firebase Token
  Future<String?> getFirebaseToken() async => await messaging.getToken();

  /// Get Initial message of push notification when notification is taped
  Future<RemoteMessage?> getInitialMessage() async => await messaging.getInitialMessage();

  /// Get Permission
  void requestPermission() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    debugPrint('User granted permission: ${settings.authorizationStatus}');
  }

  /// Local Notification
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  /// local Notification
  void _onForegroundMessage(RemoteMessage message) {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;

    // If `onMessage` is triggered with a notification, construct our own
    // local notification to show to users using the created channel.
    if (notification != null && android != null) {
      flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'foreground_notifications',
            'App Foreground Notification',
            icon: 'assets/png/logos_black.png',
            // color: Color(0xff4F545C)
          ),
        ),
        payload: FirebaseNotificationModel.fromJson(message.data).toRawJson()
      );
    }
  }

  /// Local Notification
  Future<void> initializeLocalNotifications() async {
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
    const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('ic_launcher');
    const DarwinInitializationSettings initializationSettingsDarwin =  DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false
    );
    const InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
    );
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: onDidReceiveLocalNotificationResponse
    );
  }

  /// Local Notification
  void manageNotificationChannel() async {

      // Channel to show notification when app is in foreground
      const AndroidNotificationChannel foregroundNotificationChannel = AndroidNotificationChannel(
        'foreground_notifications',
        'App Foreground Notification',
        description: 'Show notifications when app is in foreground',
        importance: Importance.max,
      );

      await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(foregroundNotificationChannel);
    }

}
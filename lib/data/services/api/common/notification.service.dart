part of 'package:googly_app/data/services/api/api_import.dart';


class NotificationAPI {
  final Dio dio;

  NotificationAPI(this.dio);

  /// Get the notification
  Future<dynamic> getNotifications({required int page}) async {
    return dio.get('/notification', queryParameters: {
      'page': page,
      'limit': 12,
    });
  }

  /// update to read notification
  Future<dynamic> readNotification({required String id}) async {
    return dio.patch(
      '/notification/$id/markread',
    );
  }

  /// update to unread notification
  Future<dynamic> unReadNotification({required String id}) async {
    return dio.patch(
      '/notification/$id/markunread',
    );
  }

  /// Delete notification
  Future<dynamic> deleteNotification({required String id}) async {
    return dio.delete(
      '/notification/$id',
    );
  }
}

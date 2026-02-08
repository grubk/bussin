import 'package:flutter_local_notifications/flutter_local_notifications.dart';

/// Configures and fires local push notifications for bus arrival alerts.
///
/// Notifications work while the app is in the foreground or background,
/// but not when the app process is killed. Uses flutter_local_notifications
/// with platform-specific channels for Android 8+ compliance.
class NotificationService {
  /// Singleton instance of the Flutter Local Notifications plugin.
  static final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  /// Whether the notification system has been initialized.
  static bool _initialized = false;

  /// Initializes the notification plugin with platform-specific settings.
  ///
  /// Must be called once during app startup (in main.dart).
  /// Creates the "Bus Alerts" notification channel on Android 8+.
  static Future<void> init() async {
    if (_initialized) return;

    // Android initialization settings with default app icon
    const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');

    // iOS initialization settings requesting alert, badge, and sound permissions
    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const initSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _plugin.initialize(settings: initSettings);

    // Create the Android notification channel for bus alerts
    const androidChannel = AndroidNotificationChannel(
      'bus_alerts',
      'Bus Alerts',
      description: 'Notifications for bus arrival alerts',
      importance: Importance.high,
      playSound: true,
      enableVibration: true,
    );

    await _plugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(androidChannel);

    _initialized = true;
  }

  /// Fires a notification alerting the user that a bus is approaching.
  ///
  /// [routeShortName] is the route display number (e.g., "49").
  /// [stopName] is the destination stop name.
  /// [minutesAway] is the predicted minutes until arrival.
  Future<void> showBusApproachingNotification({
    required String routeShortName,
    required String stopName,
    required int minutesAway,
  }) async {
    // Generate a deterministic notification ID from route+stop to avoid duplicates
    final notificationId = '$routeShortName-$stopName'.hashCode;

    const androidDetails = AndroidNotificationDetails(
      'bus_alerts',
      'Bus Alerts',
      channelDescription: 'Notifications for bus arrival alerts',
      importance: Importance.high,
      priority: Priority.high,
      playSound: true,
      enableVibration: true,
    );

    const iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    const details = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await _plugin.show(
      id: notificationId,
      title: 'Bus $routeShortName arriving',
      body: '$minutesAway min to $stopName',
      notificationDetails: details,
    );
  }

  /// Cancels a specific notification by its ID.
  Future<void> cancelNotification(int id) async {
    await _plugin.cancel(id: id);
  }

  /// Cancels all active notifications from this app.
  Future<void> cancelAllNotifications() async {
    await _plugin.cancelAll();
  }
}

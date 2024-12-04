import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:elysia_sensor/rotas.dart';
import 'package:flutter/services.dart';

class CustomNotification {
  final int id;
  final String title;
  final String body;
  final String? payload;
  //final RemoteMessage? remoteMessage;

  CustomNotification({
    required this.id,
    required this.title,
    required this.body,
    this.payload,
    //this.remoteMessage,
  });
}


class NotificationService {
  late FlutterLocalNotificationsPlugin localNotificationsPlugin;
  late AndroidNotificationDetails androidDetails;
  Timer? _timer;
  static const MethodChannel _channel = MethodChannel('br.com.casabotanica/elysia');


  NotificationService() {
    localNotificationsPlugin = FlutterLocalNotificationsPlugin();
    // Fazer: macOs, iOS, Linux...
    _setupAndroidDetails();
    _setupNotifications();

  }

  _setupAndroidDetails() {
    androidDetails = const AndroidNotificationDetails(
      'lembretes_notifications_details',
      'Lembretes',
      channelDescription: 'Este canal é para lembretes!',
      priority: Priority.max,
      enableVibration: true,

    );
  }

  _setupNotifications() async {
    await _initializeNotifications();
  }

  _initializeNotifications() async {
    const AndroidInitializationSettings android = AndroidInitializationSettings(
        '@mipmap/ic_launcher');
    final InitializationSettings initializationSettings = InitializationSettings(
        android: android);
    // Fazer: macOs, iOS, Linux...
    await localNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: _onSelectNotification,
    );
  }

  _onSelectNotification(NotificationResponse not) {
    if (not != null) {
      Navigator.of(Routes.navigatorKey!.currentContext!).pushNamed(
          '/hist');
      _timer?.cancel();
    }
  }

  static Future<void> showNotification(String title, String message) async{
    try {
      await _channel.invokeMethod('showNotification', {
      'title': title,
      'message': message,
      });
        /*localNotificationsPlugin.show(
        notification.id,
        notification.title,
        notification.body,
        NotificationDetails(
        android: androidDetails,
        ),
        payload: notification.payload,
        )
      });*/

    } on PlatformException catch (e) {
      print('Erro ao exibir notificação: $e');
    }

  }
  showLocalNotification(CustomNotification notification) {
    print("entrou no show");
    localNotificationsPlugin.show(
      notification.id,
      notification.title,
      notification.body,
      NotificationDetails(
        android: androidDetails,
      ),
      payload: notification.payload,
    );
  }

  checkForNotifications() async {
    final details = await localNotificationsPlugin
        .getNotificationAppLaunchDetails();

    if (details != null && details.didNotificationLaunchApp) {
      print("ok");
      _onSelectNotification;
    }
  }
}

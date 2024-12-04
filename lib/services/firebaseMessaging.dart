import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import  'package:elysia_sensor/rotas.dart';
import  'notificationService.dart';


class FirebaseMessagingService {

  final NotificationService _notificationService;
  FirebaseMessagingService(this._notificationService);

  get http => null;

  Future<void> initialize() async {
    await FirebaseMessaging.instance.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      provisional: false,
    );

    getDeviceFirebaseToken();
    _onMessage();
    _onMessageOpenedApp();
  }

  getDeviceFirebaseToken() async {
    final token = await FirebaseMessaging.instance.getToken();

    debugPrint('=======================================');
    debugPrint('TOKEN: $token');
    debugPrint('=======================================');

  }

  _onMessage() {
    FirebaseMessaging.onMessage.listen((message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;

      if (notification != null && android != null) {
        NotificationService.showNotification('Atenção', 'Hora de regar');
        _notificationService.showLocalNotification(
          CustomNotification(
            id: android.hashCode,
            title: notification.title!,
            body: notification.body!,
            payload: message.data['route'] ?? '',
          ),
        );
      }

    });

  }

  _onMessageOpenedApp() {
    FirebaseMessaging.onMessageOpenedApp.listen(_goToPageAfterMessage);
  }

  _goToPageAfterMessage(message) {
    final String route = message.data['route'] ?? '';
    if (route.isNotEmpty) {
      Routes.navigatorKey?.currentState?.pushNamed(route);
    }
  }


}

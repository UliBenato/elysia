
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:elysia_sensor/services/firebaseMessaging.dart';
import 'package:elysia_sensor/services/notificationService.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'app.dart';
import 'model/dbFirestore.dart';
import 'model/repository.dart';

@pragma('vm:entry-point')
Future<dynamic> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  NotificationService.showNotification('Atenção', 'Hora de regar');
  print('Mensagem em background: ${message.messageId}');
}

void leEventos() async {
  late FirebaseFirestore db;
  db = DBFirestore.get();
  String dispositivo = "Jiboia";

  try {
    final docSnapshot = await db.collection("usuario").doc("SRrW2QlgDWcL2112Wjnj").collection("favoritas").doc(dispositivo).get();
    if (docSnapshot.exists) {
      final data = docSnapshot.data() as Map<String, dynamic>;
      final umidade = data["Umidade"].toString();
      final valor = double.parse(umidade);
      if (valor < 50) {
        NotificationService().showLocalNotification(CustomNotification(
          id: 1,
          title: 'Umidade',
          body: 'Hora de regar, umidade: $umidade %',
        ));
        NotificationService.showNotification('Atenção', 'Hora de regar');
      }
    }
  } catch (e) {
    print('Erro ao ler dados do Firestore: $e');
  }
}


void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.instance.subscribeToTopic("Umidade");

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  leEventos();

  runApp(
    MultiProvider(
      providers: [
        Provider<NotificationService>(
          create: (context) => NotificationService(),
        ),
        Provider<FirebaseMessagingService>(
          create: (context) => FirebaseMessagingService(context.read<NotificationService>()),
        ),
        ChangeNotifierProvider(create: (_) => Repository()),
      ],
      child: App(),
    ),

  );

}
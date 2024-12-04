
import 'package:elysia_sensor/services/firebaseMessaging.dart';
import 'package:elysia_sensor/services/notificationService.dart';
import 'package:elysia_sensor/theme/palette.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'model/repository.dart';
import 'rotas.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    super.initState();
    initializeFirebaseMessaging();
    checkNotifications();

  }

  initializeFirebaseMessaging() async {
    await Provider.of<FirebaseMessagingService>(context, listen: false).initialize();
  }

  checkNotifications() async {
    await Provider.of<NotificationService>(context, listen: false).checkForNotifications();
  }


  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => Repository(),
        child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'elyzia',
        theme: ThemeData(
          primarySwatch: Palette.myColor,
          scaffoldBackgroundColor: Palette.myColor.shade50,
          appBarTheme: AppBarTheme(
            backgroundColor: Palette.myColor.shade500, // Cor da AppBar
            foregroundColor: Colors.black, // Cor do texto na AppBar
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: Palette.myColor.shade100, // Botão principal
              foregroundColor: Palette.myColor.shade900, // Texto no botão
            ),
          ),
          textTheme: const TextTheme(
            bodyLarge: TextStyle(fontSize: 16, color: Colors.black), // Texto padrão
          ),
            floatingActionButtonTheme: FloatingActionButtonThemeData(
                backgroundColor: Palette.myColor.shade100, // Botão principal
                foregroundColor: Palette.myColor.shade900, // Texto no botão
            ),
        ),
        routes: Routes.list,
        initialRoute: Routes.initial,
        navigatorKey: Routes.navigatorKey,
    ),
    );

  }
}


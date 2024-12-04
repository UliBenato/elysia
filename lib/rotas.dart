import 'package:elysia_sensor/screens/historicoPlanta.dart';
import 'package:elysia_sensor/screens/listaPlantas.dart';
import 'package:flutter/material.dart';
import 'package:elysia_sensor/screens/cadastroPlantas.dart';

class Routes {
  static Map<String, Widget Function(BuildContext)> list = <String, WidgetBuilder>{
    '/hist': (_) => HistoricoPlanta(),
    '/home': (_) => const ListaPlantas(),
    '/new': (_) => const Cadastroplantas(),

  };

  static String initial = '/home';

  static GlobalKey<NavigatorState>? navigatorKey = GlobalKey<NavigatorState>();
}
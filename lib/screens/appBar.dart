
import 'package:flutter/material.dart';
import 'package:elysia_sensor/model/repository.dart';
import 'package:provider/provider.dart';

import '../theme/palette.dart';

class MyAppBar extends StatelessWidget {
  const MyAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final repository = Provider.of<Repository>(context);
    return appBarDinamica(repository);
  }

  appBarDinamica(repository) {

    return AppBar(
        toolbarHeight: 70, // Set this height
        title: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  'assets/icon/elysia.png',
                  width: 30.0,
                  height: 30.0,
                ),
              ),
              Text('elysia')
            ]),
        actions: [
          PopupMenuButton<String>(
            itemBuilder: (BuildContext context)
                {
                  return [
                    const PopupMenuItem<String>(
                      value: 'logout',
                      child: Text('Logout'),
                    ),
                    const PopupMenuItem<String>(
                      value: 'iluminacao',
                      child: Text('Iluiminação'),
                    ),
                    const PopupMenuItem<String>(
                      value: 'adubacao',
                      child: Text('Adubação'),
                    ),
                  ];
                },
        onSelected: (String item) {
                // Ação a ser executada quando um item do menu for selecionado
                switch (item) {
                  case 'logout':
                    print('Logout');
                    break;
                  case 'iluminacao':

                    break;
                  case 'adubacao':

                    break;
                }
              },
              /*return repository.dispositivos.map((String item) {
                return PopupMenuItem<String>(
                  value: item,
                  child: Text(item),
                );
              }).toList();
            },
            onSelected: (String v) {
              setState(() {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MinhasPlantas(planta: v)),
                );
              });*/
          )
        ]

    );

  }}

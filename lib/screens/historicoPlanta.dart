import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/repository.dart';
import 'appBar.dart';

class HistoricoPlanta extends StatelessWidget {
  const HistoricoPlanta({super.key});

  @override
  Widget build(BuildContext context) {
    final int index = ModalRoute.of(context)!.settings.arguments as int;
    final repository = Provider.of<Repository>(context);

    return Scaffold(
        appBar: const PreferredSize(
            preferredSize: Size.fromHeight(70),
            child: MyAppBar(),
        ),
        body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
          Consumer<Repository>(
            builder: (context, repository, child) {
            final planta = repository.dispositivos[index];
              return Text(
              '$planta',
              style: TextStyle(fontSize: 20),
              );
            }
          ),
          ]
        )
      )
    );
  }
}

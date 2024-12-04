import 'package:elysia_sensor/theme/palette.dart';
import 'package:flutter/cupertino.dart';
import 'package:elysia_sensor/model/repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'appBar.dart';

class ListaPlantas extends StatelessWidget {
  const ListaPlantas({super.key});

  @override
  Widget build(BuildContext context) {
    print('ListaPlantas Rebuild');
    final repository = Provider.of<Repository>(context);

          return Scaffold(
              appBar: const PreferredSize(
                preferredSize: Size.fromHeight(70),
                child: MyAppBar(),
              ),
              body:ListView.separated(
                  itemCount: repository.dispositivos.length,

                  itemBuilder: (context, index) {
                    return ListTile(
                      key: ValueKey(repository.dispositivos[index]),
                      trailing: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            try {
                            repository.deletaDados(
                                repository.dispositivos[index]
                            ).then((success) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: const Text(
                                        'Dados excluídos com sucesso!'),
                                    duration: const Duration(
                                        milliseconds: 1500),
                                    width: 280.0,
                                    behavior: SnackBarBehavior.floating,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                  ));
                            }); }catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: const Text(
                                        'Erro ao excluir dados:' ),
                                    duration: const Duration(
                                        milliseconds: 1500),
                                    width: 280.0,
                                    behavior: SnackBarBehavior.floating,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                  )
                              );
                            }
                          }
                      ),
                      title: Text(repository.dispositivos[index]),
                      onTap: () {
                        Navigator.pushNamed(
                            context, '/hist',
                            arguments: index
                        );
                      },
                    );
                  },

                  separatorBuilder: (context, index) {
                    return Divider();
                  },
                ),

              floatingActionButton: FloatingActionButton(
                child: Icon(Icons.add),
                onPressed: () {
                  Navigator.pushNamed(context, '/new');
                },
              ),
          );



  }
}
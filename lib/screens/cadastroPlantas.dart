import 'package:elysia_sensor/screens/appBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:elysia_sensor/model/repository.dart';
import 'package:provider/provider.dart';

List<String> plantas = ['Jiboia njoy','Renda francesa','Samambaia americana', 'Aglaonema', 'Samambaia azul'];
List<String> vasos = ['C21 (Ø21cm x h11cm)','C18 (Ø18cm x h9cm)','P17 (Ø17cm x h20cm)'];
List<String> folhas = ['Até 2 folhas', 'Até 6 folhas', 'Até 15 folhas', 'Mais de 15 folhas'];
String selectedItemFolhas = 'Até 2 folhas';
String selectedItemPlantas = 'Jiboia njoy';
String selectedItemVasos = 'C21 (Ø21cm x h11cm)';

class Cadastroplantas extends StatefulWidget {
  const Cadastroplantas({super.key});

  @override
  State<Cadastroplantas> createState() => _CadastroplantasState();
}

class _CadastroplantasState extends State<Cadastroplantas> {


  @override
  Widget build(BuildContext context) {
    final repository = Provider.of<Repository>(context);
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: MyAppBar(),
      ),
      body: Padding(
      padding: const EdgeInsets.all(16.0), // Aumenta o padding externo
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch, // Estica os Dropdowns
        children: [
          const Text(
            "Cadastre sua Planta",
            style: TextStyle(fontSize: 20),
          ),
          const SizedBox(height: 16.0), // Espaçamento após o título

          DropdownButton<String>(
            isExpanded: true,
            value: selectedItemPlantas,
            items: plantas.map((String dropDownStringItem) {

              return DropdownMenuItem(
                value: dropDownStringItem,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0), // Padding interno nos itens
                  child: Text(dropDownStringItem),
                ),
              );
            }).toList(),
            onChanged: (item) =>setState(() {selectedItemPlantas = item!;})
          ),

          const SizedBox(height: 16.0), // Espaçamento entre os Dropdowns
          DropdownButton<String>(
            isExpanded: true,
            value: selectedItemVasos,
            items: vasos.map((String dropDownStringItem) {
              return DropdownMenuItem(
                value: dropDownStringItem,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0), // Padding interno nos itens
                  child: Text(dropDownStringItem),
                ),
              );
            }).toList(),
            onChanged: (item)  =>setState((){selectedItemVasos = item!;})
  ),

          const SizedBox(height: 16.0), // Espaçamento entre os Dropdowns
          DropdownButton<String>(
            isExpanded: true,
            value: selectedItemFolhas,
            items: folhas.map((String dropDownStringItem) {
              return DropdownMenuItem(
                value: dropDownStringItem,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0), // Padding interno nos itens
                  child: Text(dropDownStringItem),
                ),
              );
            }).toList(),
            onChanged: (item) =>setState((){
              selectedItemFolhas = item!;})),

          const SizedBox(height: 24.0), // Espaçamento antes do botão
          ElevatedButton(
            child: const Text('Cadastrar'),
            onPressed: () {
              Map<String, String> map = {"Vaso": selectedItemVasos, "Folhas": selectedItemFolhas};
              try{
              repository.salvaDados(selectedItemPlantas, map).then((success) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: const Text('Dados salvos com sucesso!'),
                  duration: const Duration(milliseconds: 1500),
                  width: 280.0,
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ));
              });
              }catch (e){
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: const Text('Erro ao salvar dados!'),
                  duration: const Duration(milliseconds: 1500),
                  width: 280.0,
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ));
              }
              Navigator.pop(context);
            },
          ),

        ],
      ),
      ),

  );
  }
}
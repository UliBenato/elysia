import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elysia_sensor/model/dbFirestore.dart';
import 'package:flutter/foundation.dart';


class Repository extends ChangeNotifier{
  List<String> _dispositivos = []; //final é uma variável que não muda
  List<String> get dispositivos => _dispositivos;

  Repository() {
    _recebeDados(); // Chama _carregarPlantas() no construtor
  }

  final ValueNotifier<String> umidadeNotifier = ValueNotifier<String>("");
  late FirebaseFirestore db = DBFirestore.get();

  Future<String> dados(String plantaSelecionada) async{
    final planta =  await db.collection("usuario").doc("SRrW2QlgDWcL2112Wjnj").collection("favoritas").doc(plantaSelecionada).get();

    final umidade = await planta.data()!['Umidade'].toString();
    print(umidade);
    umidadeNotifier.value = umidade;
    return umidade;
  }

  Future<void> _recebeDados() async{
    final docRef = db.collection("usuario").doc("SRrW2QlgDWcL2112Wjnj").collection("favoritas");
    QuerySnapshot favoritasSnapshot = await docRef.get();

    docRef.snapshots().listen((snapshot) {
      _dispositivos = snapshot.docs.map((doc) => doc.id).toList();
      notifyListeners(); // Atualiza automaticamente quando algo muda no Firestore
    });
  }

  Future<void> salvaDados(String planta, Map<String, dynamic> data) async{
    try {
      final docRef = db
          .collection("usuario")
          .doc("SRrW2QlgDWcL2112Wjnj")
          .collection("favoritas")
          .doc(planta);

      await docRef.set(data);
      print("Dados salvos com sucesso!");
      notifyListeners();
    } catch (e) {
      print("Erro ao salvar dados: $e");
    }

  }

  Future<void> deletaDados(String planta) async{
    try{
      final docRef = db
          .collection("usuario")
          .doc("SRrW2QlgDWcL2112Wjnj")
          .collection("favoritas")
          .doc(planta);

      await docRef.delete();
      print("Registro excluído com sucesso!");
      notifyListeners();
    }catch(e) {
      print("Erro ao excluir dados: $e");
    }

  }
}
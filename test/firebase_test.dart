import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elysia_sensor/model/dbFirestore.dart';
import 'package:elysia_sensor/model/repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'firebase_test.mocks.dart';



@GenerateMocks([ FirebaseFirestore,
                  CollectionReference,
                  DocumentReference,
                  DBFirestore,
                  Repository])
void main() {
  late MockRepository repository;
  late MockFirebaseFirestore instance;


  setUp(() {
    repository = MockRepository();
    instance = MockFirebaseFirestore();
  });

  test('salvaDados salva os dados no Firestore', () async {
    // Configuração do mock
    final mockCollection = MockCollectionReference();
    final mockDocument = MockDocumentReference();

    when(instance.collection('usuario')).thenReturn(mockCollection);
    when(mockCollection.doc("SRrW2QlgDWcL2112Wjnj")).thenReturn(mockDocument);
    when(mockDocument.collection("favoritas")).thenReturn(mockCollection);
    when(mockCollection.doc('planta1')).thenReturn(mockDocument);
    when(mockDocument.set({'umidade': 20})).thenAnswer((_) async => null);

    // Chamada do método
    await repository.salvaDados('planta1', {'umidade': 20});

    // Asserção
    verify(mockDocument.set({'umidade': 20})).called(1); // Verifica se o método set foi chamado uma vez
  });


  test('dados retorna umidade correta quando chamado com planta', () async {
    // Configuração do mock
    when(repository.dados('planta')).thenAnswer((_) async => '10');

    // Chamada do método
    final result = await repository.dados('planta');

    // Asserção
    expect(result, 10); // Verifica se o valor retornado é o esperado
  });

}
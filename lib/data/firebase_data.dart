import 'dart:async';

import 'package:firebase_database/firebase_database.dart';

class FirebaseDataTasks {
  final _reference = FirebaseDatabase.instance
      .ref()
      .child("users")
      .child("SBpBboAAQyNq5ubZoj5pJSPJHqX2")
      .child("notas");

  final _referenceButon = FirebaseDatabase.instance
      .ref()
      .child("users")
      .child("SBpBboAAQyNq5ubZoj5pJSPJHqX2")
      .child("buttons");

  final _referenceLastButon = FirebaseDatabase.instance
      .ref()
      .child("users")
      .child("SBpBboAAQyNq5ubZoj5pJSPJHqX2");

  Stream<Map> getAllTesk({required idTask}) {
    var controller = StreamController<Map>();
    late Map<dynamic, dynamic> listMap;
    _reference.child(idTask).onValue.listen((event) {
      if (event.snapshot.value == null) {
        controller.add({});
      } else {
        final maps = (event.snapshot.value) as Map;
        listMap = maps;
        controller.add(listMap);
      }
    }).onError((e) {
      controller.add({});
    });

    return controller.stream;
  }

  updateNota({required String idNota, required String name}) {
    _reference.child(idNota).update({"name": name});
    _reference.child(idNota).update({"name": name});
  }

  deleteNota({required String idNota}) {
    _reference.child(idNota).remove();
    _referenceButon.child(idNota).remove();
  }

  createNota({required String name}) {
    String idNota = DateTime.now().millisecondsSinceEpoch.toString();
    _reference.child(idNota).set({'name': name});
    _referenceButon.child(idNota).set({'name': name});
  }

  Stream<List<Map>> getButton() {
    var controller = StreamController<List<Map>>();
    late List<Map<dynamic, dynamic>> listMap = [];
    _referenceButon.onValue.listen((event) {
      final maps = (event.snapshot.value) as Map;
      listMap = maps.entries.map((e) => {e.key: e.value}).toList();
      controller.add(listMap);
    });

    return controller.stream;
  }

  Stream<String> selectedButon() {
    var controller = StreamController<String>();

    final _referenceButon = FirebaseDatabase.instance
        .ref()
        .child("users")
        .child("SBpBboAAQyNq5ubZoj5pJSPJHqX2")
        .child('button')
        .onValue
        .listen((event) {
      controller.add(event.snapshot.value.toString());
    }).onError((e) {
      return controller.add("");
    });

    return controller.stream;
  }

  updateIdLastButton({required String idButton}) {
    _referenceLastButon.update({"button": idButton});
  }
}

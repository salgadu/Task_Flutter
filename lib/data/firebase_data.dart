import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task/blocs/login_bloc.dart';
import 'package:task/models/profile_model.dart';

class FirebaseDataTasks {
  Future<DatabaseReference> getFirebaseREference() async {
    final prefs = await SharedPreferences.getInstance();

    String? id = prefs.getString('idUser');
    return FirebaseDatabase.instance.ref().child("users").child(id!);
  }

  Future<Stream<Map>> getAllTesk({required idTask}) async {
    var controller = StreamController<Map>();
    late Map<dynamic, dynamic> listMap;
    final _reference = await getFirebaseREference();
    _reference.child("notas").child(idTask).onValue.listen((event) {
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

  updateNota({required String idNota, required String name}) async {
    final _reference = await getFirebaseREference();
    _reference.child("notas").child(idNota).update({"name": name});
    _reference.child("notas").child(idNota).update({"name": name});
  }

  deleteNota({required String idNota}) async {
    final _reference = await getFirebaseREference();
    _reference.child("notas").child(idNota).remove();
    _reference.child("buttons").child(idNota).remove();
  }

  createNota({required String name}) async {
    String idNota = DateTime.now().millisecondsSinceEpoch.toString();
    final _reference = await getFirebaseREference();
    _reference.child("notas").child(idNota).set({'name': name});
    _reference.child("buttons").child(idNota).set({'name': name});
  }

  Future<Stream<List<Map>>> getButton() async {
    var controller = StreamController<List<Map>>();
    final _reference = await getFirebaseREference();
    _reference.child("buttons").onValue.listen((event) {
      late List<Map<dynamic, dynamic>> listMap = [];
      if (event.snapshot.value == null) {
        controller.add(listMap);
      } else {
        final maps = (event.snapshot.value) as Map;
        listMap = maps.entries.map((e) => {e.key: e.value}).toList();
        controller.add(listMap);
      }
    });

    return controller.stream;
  }

  Future<Stream<String>> selectedButon() async {
    var controller = StreamController<String>();
    final _reference = await getFirebaseREference();
    _reference.child("button").onValue.listen((event) {
      if (event.snapshot.value.toString() == null) {
        controller.add('');
      } else {
        controller.add(event.snapshot.value.toString());
      }
    }).onError((e) {
      //CASO DE ERRO
    });

    return controller.stream;
  }

  updateIdLastButton({required String idButton}) async {
    final _reference = await getFirebaseREference();
    _reference.update({"button": idButton});
  }

  deleteLastButton() async {
    final _reference = await getFirebaseREference();
    _reference.child("button").remove();
  }

  Future<Map<String, dynamic>> getUser() async {
    late Map<String, dynamic> user;
    final _reference = await getFirebaseREference();
    await _reference.child("profile").get().then((value) {
      Map userAux = value.value as Map;
      user = {
        "name": userAux['name'],
        'urlImage': userAux['imagePath'],
      };
    });

    return user;
  }
}

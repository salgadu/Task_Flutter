import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirebaseDataSubItem {
  Future<DatabaseReference> getFirebaseREference() async {
    final prefs = await SharedPreferences.getInstance();
    String? id = prefs.getString('idUser');
    return FirebaseDatabase.instance
        .ref()
        .child("users")
        .child(id!)
        .child("notas");
  }

  updateSubItem(
      {required String idNota,
      required String idItem,
      required String idSubItem,
      required Map<String, dynamic> upSubItens}) async {
    final _reference = await getFirebaseREference();
    _reference
        .child(idNota)
        .child("item")
        .child(idItem)
        .child("subItem")
        .child(idSubItem)
        .update(upSubItens);
  }

  deleteSubItem({
    required String idNota,
    required String idItem,
    required String idSubItem,
  }) async {
    final _reference = await getFirebaseREference();
    _reference
        .child(idNota)
        .child("item")
        .child(idItem)
        .child("subItem")
        .child(idSubItem)
        .remove();
  }

  createSubItem({
    required String idNota,
    required String idItem,
    required String textSubItem,
  }) async {
    final _reference = await getFirebaseREference();
    _reference
        .child(idNota)
        .child("item")
        .child(idItem)
        .child("subItem")
        .push()
        .set({
      "text": textSubItem,
      "check": false,
    });
  }
}

import 'dart:async';

import 'package:firebase_database/firebase_database.dart';

class FirebaseDataSubItem {
  final _reference = FirebaseDatabase.instance
      .ref()
      .child("users")
      .child("SBpBboAAQyNq5ubZoj5pJSPJHqX2")
      .child("notas");

  updateSubItem(
      {required String idNota,
      required String idItem,
      required String idSubItem,
      required Map<String, dynamic> upSubItens}) {
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
  }) {
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
  }) {
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

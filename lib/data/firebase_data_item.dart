import 'package:firebase_database/firebase_database.dart';

class FirebaseDataItem {
  final _reference = FirebaseDatabase.instance
      .ref()
      .child("users")
      .child("SBpBboAAQyNq5ubZoj5pJSPJHqX2")
      .child("notas");

  updateItem(
      {required String idNota,
      required String idItem,
      required Map<String, dynamic> upItens}) {
    _reference.child(idNota).child("item").child(idItem).update(upItens);
  }

  deleteItem({
    required String idNota,
    required String idItem,
  }) {
    _reference.child(idNota).child("item").child(idItem).remove();
  }

  createItem({
    required String idNota,
    required String nomeItem,
  }) {
    _reference
        .child(idNota)
        .child("item")
        .push()
        .set({"name": nomeItem, "check": false});
  }
}

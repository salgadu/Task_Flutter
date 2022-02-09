import 'package:firebase_database/firebase_database.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirebaseDataItem {
  Future<DatabaseReference> getFirebaseREference() async {
    final prefs = await SharedPreferences.getInstance();
    String? id = prefs.getString('idUser');
    return FirebaseDatabase.instance
        .ref()
        .child("users")
        .child(id!)
        .child("notas");
  }

  updateItem(
      {required String idNota,
      required String idItem,
      required Map<String, dynamic> upItens}) async {
    final _reference = await getFirebaseREference();
    _reference.child(idNota).child("item").child(idItem).update(upItens);
  }

  deleteItem({
    required String idNota,
    required String idItem,
  }) async {
    final _reference = await getFirebaseREference();
    _reference.child(idNota).child("item").child(idItem).remove();
  }

  createItem({
    required String? idNota,
    required String nomeItem,
  }) async {
    final _reference = await getFirebaseREference();
    _reference
        .child(idNota!)
        .child("item")
        .push()
        .set({"name": nomeItem, "check": false});
  }
}

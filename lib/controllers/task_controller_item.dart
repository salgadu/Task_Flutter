import 'package:firebase_core/firebase_core.dart';
import 'package:task/components/custom_item.dart';
import 'package:task/data/firebase_data_item.dart';
import 'package:task/models/task_model.dart';

class TaskControllerItem {
  final firebaseitem = FirebaseDataItem();
  updateItem({required ItemModel item}) {
    firebaseitem.updateItem(
        idNota: item.idNota, idItem: item.idItem, upItens: item.toMap());
  }

  deleteItem({required ItemModel item}) {
    firebaseitem.deleteItem(idNota: item.idNota, idItem: item.idItem);
  }

  createItem({required String idNota, required String text}) {
    firebaseitem.createItem(idNota: idNota, nomeItem: text);
  }
}

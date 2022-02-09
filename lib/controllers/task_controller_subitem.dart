import 'package:task/blocs/login_bloc.dart';
import 'package:task/data/firebase_data_subitem.dart';
import 'package:task/models/task_model.dart';

class TaskControllerSubItem {
  late final FirebaseDataSubItem firebaseData;

  TaskControllerSubItem() {
    firebaseData = FirebaseDataSubItem();
  }

  void updateSubItem({required TaskSubItemModel subItem}) {
    firebaseData.updateSubItem(
        idNota: subItem.idNota,
        idItem: subItem.idItem,
        idSubItem: subItem.idSubItem,
        upSubItens: subItem.toMap());
  }

  void deleteSubItem({required TaskSubItemModel subItem}) {
    firebaseData.deleteSubItem(
        idNota: subItem.idNota,
        idItem: subItem.idItem,
        idSubItem: subItem.idSubItem);
  }

  void createSubItem({required ItemModel item, required String textSubItem}) {
    firebaseData.createSubItem(
        idNota: item.idNota, idItem: item.idItem, textSubItem: textSubItem);
  }
}

import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:task/blocs/login_bloc.dart';
import 'package:task/data/firebase_data.dart';
import 'package:task/data/firebase_data_subitem.dart';
import 'package:task/models/buttom_model.dart';
import 'package:task/models/profile_model.dart';
import 'package:task/models/task_model.dart';

class TaskController {
  final firebaseData = FirebaseDataTasks();
  Stream<TaskModel> getTasks() {
    var controller = StreamController<TaskModel>();
    TaskModel task = TaskModel();
    firebaseData.selectedButon().then((value) => value.listen((idButton) {
          if (idButton == 'null') {
            controller.add(task);
            return;
          } else {
            final listMap = firebaseData.getAllTesk(idTask: idButton);
            listMap.then((value) => value.listen((event) {
                  task = TaskModel.fromJson(event, idButton);
                  controller.add(task);
                }));
          }
        }));

    return controller.stream;
  }

  createNota({required String name}) {
    firebaseData.createNota(name: name);
  }

  updateNota({required String name, required String id}) {
    firebaseData.updateNota(idNota: id, name: name);
  }

  deleteItem({required String id}) {
    firebaseData.deleteNota(idNota: id);
  }

  Stream<List<ButtonModel>> getButttom() {
    var controller = StreamController<List<ButtonModel>>();
    late List<ButtonModel> listButton = [];
    final listMap = firebaseData.getButton();
    listMap.then((value) => value.listen((event) {
          listButton = event.map((e) => ButtonModel.fromJson(e)).toList();
          controller.add(listButton);
        }));

    return controller.stream;
  }

  updateLastButton({required String idLastButton}) {
    firebaseData.updateIdLastButton(idButton: idLastButton);
  }

  deleteLastButton() {
    firebaseData.deleteLastButton();
  }

  Stream<bool> getLastButton() {
    var controller = StreamController<bool>();
    firebaseData.selectedButon().then((value) => value.listen((event) {
          if (event == 'null') {
            controller.add(true);
          } else {
            controller.add(false);
          }
        }));
    return controller.stream;
  }

  Future<ProfileModel> getUserController() async {
    final user = await firebaseData.getUser();
    return ProfileModel.fromJson(user);
  }
}

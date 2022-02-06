import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:rxdart/subjects.dart';
import 'package:task/models/task_model.dart';

class ModifyNotaBloc extends BlocBase {
  String _idTask = '1644176032697';
  String get getIdTask => _idTask;

  final _idTaskStream = StreamController<String>();
  Stream<String> get streamIdTask => _idTaskStream.stream;

  addIdTask(String id) {
    _idTask = id;
    _idTaskStream.sink.add(getIdTask);
  }
}

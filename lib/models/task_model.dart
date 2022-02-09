import 'dart:convert';

class TaskModel {
  late String _idNota;
  late String _nameNota;
  bool _isEmpty = false;
  late final List<ItemModel> _item = [];

  TaskModel() {
    _isEmpty = true;
  }

  TaskModel.fromJson(Map mapNota, String key) {
    _isEmpty = false;
    _idNota = key;
    _nameNota = mapNota['name'];
    if (mapNota['item'] != null) {
      Map<dynamic, dynamic> itens = mapNota['item'];
      for (var key in itens.keys) {
        _item.add(ItemModel.fromJson(mapNota['item'][key], key, _idNota));
      }
    }
  }

  Map<String, dynamic> toMap() => {"name": _nameNota};

  String get idNota => _idNota;
  String get nameNota => _nameNota;
  bool get isEmpty => _isEmpty;
  List<ItemModel> get itens => _item;

  set setName(String name) => _nameNota = name;
}

class ItemModel {
  late String _idItem;
  late String _nameItem;
  late String _idNota;
  late bool _check;
  late final List<TaskSubItemModel> _subItem = [];

  ItemModel.fromJson(Map<dynamic, dynamic> mapItem, String key, String idNota) {
    _idItem = key;
    _idNota = idNota;
    _nameItem = mapItem['name'];
    _check = mapItem['check'];

    if (mapItem['subItem'] != null) {
      Map<dynamic, dynamic> subs = mapItem['subItem'];
      subs.keys.forEach((key) {
        Map<dynamic, dynamic> subItensnew = mapItem['subItem'][key];
        _subItem
            .add(TaskSubItemModel.fromJson(subItensnew, key, _idNota, _idItem));
      });
    }
  }

  Map<String, dynamic> toMap() => {"name": _nameItem, "check": _check};

  String get idItem => _idItem;
  String get idNota => _idNota;
  String get nameItem => _nameItem;
  bool get check => _check;
  List<TaskSubItemModel> get itens => _subItem;

  set setCheck(bool check) => _check = check;
  set setName(String name) => _nameItem = name;
}

class TaskSubItemModel {
  late String _idTaskSubItem;
  late String _name;
  late bool _check;
  late String _idItem;
  late String _idNota;

  TaskSubItemModel.fromJson(Map<dynamic, dynamic> mapSubItem, String key,
      String idNota, String idItem) {
    _idTaskSubItem = key;
    _idNota = idNota;
    _idItem = idItem;
    _name = mapSubItem["text"];
    _check = mapSubItem["check"];
  }

  Map<String, dynamic> toMap() => {"text": _name, "check": _check};

  String get idSubItem => _idTaskSubItem;
  String get idNota => _idNota;
  String get idItem => _idItem;
  String get nameSubItem => _name;
  bool get check => _check;

  set setCheck(bool check) => _check = check;
  set setName(String name) => _name = name;
}

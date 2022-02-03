class TaskModel {
  late String _idNota;
  late String _nameNota;
  late final List<ItemModel> _item = [];

  TaskModel.fromJson(Map<String, dynamic> mapNota) {
    mapNota.forEach((key, value) {
      _idNota = key;
      mapNota = value;
    });
    _nameNota = mapNota['name'];
    Map<String, dynamic> itens = mapNota['item'];
    for (var key in itens.keys) {
      _item.add(ItemModel.fromJson(mapNota['item'][key], key));
    }
  }

  String get idNota => _idNota;
  String get nameNota => _nameNota;
  List<ItemModel> get itens => _item;
}

class ItemModel {
  late String _idItem;
  late String _nameItem;
  late bool _check;
  late final List<TaskSubItemModel> _subItem = [];

  ItemModel.fromJson(Map<String, dynamic> mapItem, String key) {
    _idItem = key;
    _nameItem = mapItem['name'];
    _check = mapItem['check'];

    Map<String, dynamic> subs = mapItem['subItem'];
    subs.keys.forEach((key) {
      print(key);
      Map<String, dynamic> subItensnew = mapItem['subItem'][key];
      _subItem.add(TaskSubItemModel.fromJson(subItensnew, key));
    });
  }
  String get idItem => _idItem;
  String get nameItem => _nameItem;
  bool get check => _check;
  List<TaskSubItemModel> get itens => _subItem;
}

class TaskSubItemModel {
  late String _idTaskSubItem;
  late String _name;
  late bool _check;

  TaskSubItemModel.fromJson(Map<String, dynamic> mapSubItem, String key) {
    _idTaskSubItem = key;
    _name = mapSubItem["text"];
    _check = mapSubItem["check"];
  }
  String get idSubItem => _idTaskSubItem;
  String get nameSubItem => _name;
  bool get check => _check;
}

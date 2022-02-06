class ButtonModel {
  late String _idButton;
  late String _nameButton;

  ButtonModel.fromJson(Map<dynamic, dynamic> map) {
    map.forEach((key, value) {
      _idButton = key.toString();
      _nameButton = value['name'];
    });
  }

  String get getIdButton => _idButton;
  String get getnameButton => _nameButton;
}

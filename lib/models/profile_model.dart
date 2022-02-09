class ProfileModel {
  late String _name;
  late String _urlImage;

  ProfileModel() {
    _name = "Carlos Silveira";
    _urlImage = "data:image/jpeg;base64";
  }

  ProfileModel.fromJson(Map<String, dynamic> map) {
    _name = map['name'];
    _urlImage = map['urlImage'];
    print(_urlImage);
  }
  Map<String, dynamic> toMap() => {"name": name, "urlImage": urlImage};

  String get name => _name;
  String get urlImage => _urlImage;
}

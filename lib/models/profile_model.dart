class ProfileModel {
  late String _name;
  late String _urlImage;
  late String _uid;

  ProfileModel.fromJson(Map<String, dynamic> map) {
    _name = map[name];
    _urlImage = map[urlImage];
    _uid = map[uid];
  }
  Map<String, dynamic> toMap() => {
        "name": name,
        "urlImage": urlImage,
        "uid": uid,
      };

  String get name => name;
  String get urlImage => urlImage;
  String get uid => uid;
}

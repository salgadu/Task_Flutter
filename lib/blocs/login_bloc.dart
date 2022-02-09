import 'dart:io';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:rxdart/subjects.dart';
import 'package:task/data/firebase_data.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task/global/constants.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class LoginBloc extends BlocBase {
  final _stateController = BehaviorSubject<LoginState>();
  late String _uidController = '';
  final _email = BehaviorSubject<String>();
  final _password = BehaviorSubject<String>();

  Stream<LoginState> get outState => _stateController.stream;
  String get outUid => _uidController;

  Function(String) get email => _email.sink.add;
  Function(String) get password => _password.sink.add;

  String getId() {
    late String id = "";
    FirebaseAuth.instance.authStateChanges().listen((user) {
      id = user!.uid;
    });

    return id;
  }

  LoginBloc() {
    FirebaseAuth.instance.authStateChanges().listen((user) async {
      final prefs = await SharedPreferences.getInstance();
      if (user != null) {
        _uidController = user.uid;
        await prefs.setString('idUser', user.uid);

        _stateController.add(LoginState.SUCCESS);
      } else {
        _stateController.add(LoginState.IDLE);
      }
    });
  }

  Submit() {
    final email = _email.value;
    final password = _password.value;

    _stateController.add(LoginState.LOADING);
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .catchError((e) {
      _stateController.add(LoginState.FAIL);
    });
  }

  Future<void> singIn(
      {required String name,
      required File? fileImage,
      required String email,
      required String password}) async {
    late String uid;
    late String imagePath = "";
    final userCredencial = FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    //Aguardando o id do usuário
    await userCredencial.then((value) {
      uid = value.user!.uid;
    });

    await firebase_storage.FirebaseStorage.instance
        .ref()
        .child(uid)
        .child("images/profile.jpeg")
        .putFile(fileImage!)
        .then((snapshot) {
      snapshot.ref.getDownloadURL().then((value) {
        imagePath = value;
        print(value);

        FirebaseDatabase.instance
            .ref()
            .child('users')
            .child(uid)
            .child("profile")
            .set({"name": name, "imagePath": imagePath});
      });
    });

    _uidController = uid;
  }

  logout() {
    FirebaseAuth.instance
        .signOut()
        .then((value) => _stateController.add(LoginState.IDLE));
  }
}

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/subjects.dart';
import 'package:task/global/constants.dart';

class LoginBloc extends BlocBase {
  final _stateController = BehaviorSubject<LoginState>();
  final _email = BehaviorSubject<String>();
  final _password = BehaviorSubject<String>();

  Stream<LoginState> get outState => _stateController.stream;
  Function(String) get email => _email.sink.add;
  Function(String) get password => _password.sink.add;

  LoginBloc() {
    FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user != null) {
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

  logout() {
    FirebaseAuth.instance
        .signOut()
        .then((value) => _stateController.add(LoginState.IDLE));
  }
}

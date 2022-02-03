import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:task/blocs/login_bloc.dart';
import 'package:task/global/constants.dart';
import 'package:task/screens/home_screen.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _loginBloc = LoginBloc();
  @override
  void initState() {
    _loginBloc.outState.listen((state) {
      switch (state) {
        case LoginState.SUCCESS:
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => HomeScreen()));
          break;
        case LoginState.FAIL:
          showDialog(
              context: context,
              builder: (context) => const AlertDialog(
                    title: Text("ERROR"),
                    content: Text("Login Invalido"),
                  ));
          break;

        default:
          break;
      }
    });
  }

  @override
  void dispose() {
    _loginBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<LoginState>(
      stream: _loginBloc.outState,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Container(
            child: Center(
              child: Column(
                children: const [
                  CircularProgressIndicator(),
                  Text("Carregando")
                ],
              ),
            ),
          );
        }
        return Column(
          children: [
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Email',
              ),
              onChanged: _loginBloc.email,
            ),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Senha',
              ),
              onChanged: _loginBloc.password,
              obscureText: true,
            ),
            ElevatedButton(
              onPressed: () {
                _loginBloc.Submit();
              },
              child: Text("LOGIN"),
            )
          ],
        );
      },
    ));
  }
}

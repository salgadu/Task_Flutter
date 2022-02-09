import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:task/blocs/login_bloc.dart';
import 'package:task/global/constants.dart';
import 'package:task/screens/home_screen.dart';
import 'package:task/screens/register_screen.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _loginBloc = LoginBloc();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formkey = GlobalKey<FormState>();

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
        body: Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('images/back.png'), fit: BoxFit.cover)),
      child: StreamBuilder<LoginState>(
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
          return Container(
            alignment: Alignment.center,
            margin: EdgeInsets.all(10),
            child: Form(
                key: _formkey,
                child: ListView(
                  children: [
                    Text(
                      "T",
                      style: GoogleFonts.getFont(
                        'Rock Salt',
                        fontSize: 120,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(),
                        hintText: 'Email',
                      ),
                      validator: (text) {
                        if (text!.isEmpty) {
                          return "Email não pode esta vazio";
                        } else if (false) {
                          return "Email no formato invalido";
                        }
                      },
                      controller: _emailController,
                      onChanged: _loginBloc.email,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(),
                        hintText: 'Senha',
                      ),
                      validator: (text) {
                        if (text!.isEmpty) {
                          return "Senha não pode esta vazio";
                        } else if (text.length < 6) {
                          return "A senha deve conter mais de 6 caracteres";
                        }
                      },
                      controller: _passwordController,
                      onChanged: _loginBloc.password,
                      obscureText: true,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 55,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formkey.currentState!.validate()) {
                            _loginBloc.Submit();
                          }
                        },
                        child: Text("LOGIN"),
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        const Text(
                          'NÃO POSSUI UMA CONTA?',
                          style: TextStyle(color: Colors.white),
                        ),
                        TextButton(
                          child: const Text(
                            'CADASTRA-SE',
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const RegisterScreen()),
                            );
                          },
                        )
                      ],
                      mainAxisAlignment: MainAxisAlignment.center,
                    ),
                  ],
                )),
          );
        },
      ),
    ));
  }
}

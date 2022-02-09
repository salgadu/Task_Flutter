import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:task/blocs/login_bloc.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  File? image;
  final _formCrontroler = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  bool validateImage = false;
  final _loginBloc = LoginBloc();

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      if (image == null) return;

      //final imageTemporary = File(image.path);

      final imagePermanent = await saveImagePermanently(image.path);
      setState(() => this.image = imagePermanent);
    } on PlatformException catch (e) {
      print("Falha ao obter imagem: $e");
    }
  }

  Future<File> saveImagePermanently(String imagePath) async {
    final diretorio = await getApplicationDocumentsDirectory();
    final nome = basename(imagePath);
    final image = File('${diretorio.path}/$nome');
    return File(imagePath).copy(image.path);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro'),
      ),
      body: Container(
        margin: EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Form(
            key: _formCrontroler,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                    onTap: () async {
                      pickImage();
                    },
                    child: image != null
                        ? CircleAvatar(
                            radius: 70,
                            child: ClipOval(
                              child: Image.file(
                                image!,
                                width: 140,
                                height: 140,
                                fit: BoxFit.cover,
                              ),
                            ),
                          )
                        : CircleAvatar(
                            radius: 70,
                            child: Icon(Icons.camera_alt),
                          )),
                if (validateImage)
                  const Text(
                    "\nInsira uma imegem para continuar",
                    style: TextStyle(color: Colors.red),
                  ),
                SizedBox(height: 20),
                TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Nome',
                    ),
                    validator: (text) {
                      if (text!.isEmpty) {
                        return "Nome não pode esta vazio";
                      }
                    }),
                SizedBox(height: 10),
                TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email',
                    ),
                    validator: (text) {
                      if (text!.isEmpty) {
                        return "Email não pode esta vazio";
                      }
                    }),
                SizedBox(height: 10),
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Senha',
                  ),
                  validator: (text) {
                    if (text!.isEmpty) {
                      return "Senha não pode esta vazio";
                    } else if (text.length < 6) {
                      return "A senha deve conter mais de 6 caracteres";
                    }
                  },
                  obscureText: true,
                ),
                SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        side: BorderSide(
                          width: 2.0,
                          color: Colors.blue.shade400,
                        )),
                    onPressed: () {
                      setState(() {
                        validateImage = image == null;
                      });
                      if (_formCrontroler.currentState!.validate() &&
                          !validateImage) {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return Center(
                                child: Container(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: const [
                                      CircularProgressIndicator(),
                                    ],
                                  ),
                                ),
                              );
                            });
                        _loginBloc.singIn(
                            name: _nameController.text,
                            fileImage: image,
                            email: _emailController.text,
                            password: _passwordController.text);
                      }
                    },
                    child: Text(
                      "CADASTRO",
                      style: TextStyle(color: Colors.blue.shade400),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Future<String?> getImageProfile() async {
  //   final ImagePicker _picker = ImagePicker();
  //   final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
  //   return photo!.path;
  // }

}

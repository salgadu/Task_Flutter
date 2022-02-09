import 'package:flutter/material.dart';
import 'package:task/blocs/login_bloc.dart';
import 'package:task/blocs/modify_notas_bloc.dart';
import 'package:task/components/custom_buttom_nota.dart';
import 'package:task/controllers/task_controller.dart';
import 'package:task/data/firebase_data.dart';
import 'package:task/models/buttom_model.dart';
import 'package:task/models/profile_model.dart';
import 'package:task/models/task_model.dart';
import 'package:task/screens/login_screen.dart';

class CustomDrawer extends StatefulWidget {
  CustomDrawer({Key? key}) : super(key: key);

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  final colortext = const Color.fromRGBO(92, 157, 254, 1);

  final taskContoller = TaskController();

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: FutureBuilder<ProfileModel>(
            future: taskContoller.getUserController(),
            builder: (context, profile) {
              if (!profile.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 10, right: 10, top: 25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.cloud_done_outlined,
                              color: Color.fromRGBO(92, 157, 254, 1),
                            )),
                        IconButton(
                            iconSize: 32,
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (_) => AlertDialog(
                                        title: Text('Alerta!'),
                                        content: Text(
                                            'O modo escuro será implementado em breve'),
                                      ));
                            },
                            icon: const Icon(
                              Icons.dark_mode,
                              color: Color.fromRGBO(92, 157, 254, 1),
                            )),
                      ],
                    ),
                  ),
                  CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(profile.data!.urlImage)),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    profile.data!.name,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: colortext,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.checklist_rounded,
                        color: Color.fromRGBO(92, 157, 254, 1),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "NOTAS",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color.fromRGBO(92, 157, 254, 1),
                        ),
                      ),
                    ],
                  ),
                  const Divider(),
                  Expanded(
                      child: StreamBuilder<List<ButtonModel>>(
                          stream: taskContoller.getButttom(),
                          builder: (context, listtask) {
                            if (!listtask.hasData) {
                              return Container();
                            }
                            return ListView(
                              padding: EdgeInsets.symmetric(
                                  vertical: 0.0, horizontal: 0.0),
                              children: listtask.data!
                                  .map((e) => CustomButtomNota(
                                        idButtom: e.getIdButton,
                                        nomeButtom: e.getnameButton,
                                        listButton: listtask.data,
                                      ))
                                  .toList(),
                            );
                          })),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue[50],
                      textStyle: TextStyle(),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                    ),
                    onPressed: () async {
                      String? name = await showModal(context, null, "Criar");
                      if (name != null && name != "") {
                        taskContoller.createNota(name: name);
                      }
                    },
                    child: Icon(
                      Icons.add,
                      color: colortext,
                      size: 24.0,
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Container(
                    child: InkWell(
                      onTap: () {
                        LoginBloc _blocController = LoginBloc();
                        _blocController.logout();
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => LoginScreen()));
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: const [
                          SizedBox(
                            width: 10,
                          ),
                          Icon(
                            Icons.logout,
                            color: Color.fromRGBO(92, 157, 254, 1),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "SAIR",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color.fromRGBO(92, 157, 254, 1),
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                ],
              );
            }));
  }
}

Future<String?> showModal(
    BuildContext context, String? name, String modalName) async {
  final _editController = TextEditingController(text: name != null ? name : "");
  late String retorno;
  await showDialog<String>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title: Text(modalName),
      actions: <Widget>[
        TextField(
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Editar',
          ),
          controller: _editController,
        ),
        Row(
          children: [
            TextButton(
              onPressed: () => Navigator.pop(context, 'Cancelar'),
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                print(_editController.text);
                Navigator.pop(context, 'OK');
              },
              child: const Text('OK'),
            ),
          ],
        )
      ],
    ),
  );
  return _editController.text;
}

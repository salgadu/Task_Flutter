import 'package:flutter/material.dart';
import 'package:task/blocs/login_bloc.dart';
import 'package:task/blocs/modify_notas_bloc.dart';
import 'package:task/components/custom_buttom_nota.dart';
import 'package:task/controllers/task_controller.dart';
import 'package:task/models/buttom_model.dart';
import 'package:task/models/task_model.dart';
import 'package:task/screens/login_screen.dart';

class CustomDrawer extends StatefulWidget {
  CustomDrawer({Key? key}) : super(key: key);

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  final colortext = const Color.fromRGBO(92, 157, 254, 1);

  final _blocController = LoginBloc();

  final taskContoller = TaskController();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
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
                    onPressed: () {},
                    icon: const Icon(
                      Icons.dark_mode,
                      color: Color.fromRGBO(92, 157, 254, 1),
                    )),
              ],
            ),
          ),
          CircleAvatar(
            radius: 50,
            backgroundImage: NetworkImage(
                "https://media.istockphoto.com/photos/millennial-male-team-leader-organize-virtual-workshop-with-employees-picture-id1300972574?b=1&k=20&m=1300972574&s=170667a&w=0&h=2nBGC7tr0kWIU8zRQ3dMg-C5JLo9H2sNUuDjQ5mlYfo="),
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            "Carlos Silveira",
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
                "AGENDA",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(92, 157, 254, 1),
                ),
              ),
            ],
          ),
          Expanded(
              child: StreamBuilder<List<ButtonModel>>(
                  stream: taskContoller.getButttom(),
                  builder: (context, listtask) {
                    if (!listtask.hasData) {
                      return CircularProgressIndicator();
                    }
                    return ListView(
                      children: listtask.data!
                          .map((e) => CustomButtomNota(
                                idButtom: e.getIdButton,
                                nomeButtom: e.getnameButton,
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
          Container(
            height: 70,
            child: InkWell(
              onTap: () {
                _blocController.logout();
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => LoginScreen()));
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
          )
        ],
      ),
    );
  }

  Future<String?> showModal(
      BuildContext context, String? name, String modalName) async {
    final _editController =
        TextEditingController(text: name != null ? name : "");
    late String retorno;
    await showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(modalName),
        content: const Text('Você esta editando!'),
        actions: <Widget>[
          TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Digite o texto',
            ),
            controller: _editController,
          ),
          Row(
            children: [
              TextButton(
                onPressed: () => Navigator.pop(context, 'Cancel'),
                child: const Text('Cancel'),
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
}

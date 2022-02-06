import 'package:flutter/material.dart';
import 'package:task/blocs/modify_notas_bloc.dart';
import 'package:task/components/custom_drawer.dart';
import 'package:task/components/custom_item.dart';
import 'package:task/components/custom_subitem.dart';
import 'package:task/controllers/task_controller.dart';
import 'package:task/controllers/task_controller_item.dart';
import 'package:task/models/task_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final itemController = TaskControllerItem();
  final tasksController = TaskController();
  late TaskModel initDataTesk;
  late bool butons = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    tasksController.getButttom().listen((event) {
      butons = event.isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<TaskModel>(
        stream: tasksController.getTasks(),
        builder: (context, snapshot) {
          if (butons) {
            return Container();
          } else if (snapshot.hasError) {
            return Container();
          } else if (!snapshot.hasData) {
            return const CircularProgressIndicator();
          }

          return Scaffold(
            floatingActionButton: FloatingActionButton(
              onPressed: () async {
                String? name = await showModal(null, "Criar");
                if (name != null && name != "") {
                  itemController.createItem(
                      idNota: snapshot.data!.idNota, text: name);
                }
              },
              child: const Icon(Icons.add),
            ),
            drawer: CustomDrawer(),
            appBar: AppBar(
              title: Text(snapshot.data!.nameNota),
            ),
            body: Container(
              child: ListView(
                children: snapshot.data!.itens
                    .map((e) => Dismissible(
                          direction: DismissDirection.endToStart,
                          background: Container(
                            color: Colors.red,
                            child: const Align(
                              alignment: Alignment(0.9, 0),
                              child: Icon(Icons.delete, color: Colors.white),
                            ),
                          ),
                          key: ValueKey<String>(e.idItem),
                          onDismissed: (DismissDirection direction) {
                            itemController.deleteItem(item: e);
                          },
                          child: Item(
                            itemModel: e,
                          ),
                        ))
                    .toList(),
              ),
            ),
          );
        });
  }

  Future<String?> showModal(String? name, String modalName) async {
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

import 'package:flutter/material.dart';
import 'package:task/components/custom_drawer.dart';
import 'package:task/components/custom_item.dart';
import 'package:task/controllers/task_controller.dart';
import 'package:task/controllers/task_controller_item.dart';
import 'package:task/models/buttom_model.dart';
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
  late String? idButtonGlobal = null;

  @override
  void initState() {
    super.initState();
    tasksController.getTasks().listen((event) {
      if (event.isEmpty) {
        setState(() {
          idButtonGlobal = null;
        });
      } else {
        setState(() {
          idButtonGlobal = event.idNota;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
        stream: tasksController.getLastButton(),
        builder: (context, boolSnapshot) {
          return StreamBuilder<List<ButtonModel>>(
              stream: tasksController.getButttom(),
              builder: (context, snapshot) {
                return Scaffold(
                    floatingActionButton: boolSnapshot.data == true
                        ? null
                        : snapshot.data == []
                            ? null
                            : idButtonGlobal == null
                                ? null
                                : FloatingActionButton(
                                    onPressed: floatActionbutton,
                                    child: const Icon(Icons.add),
                                  ),
                    drawer: CustomDrawer(),
                    appBar: AppBar(
                      title: const Text('TASK'),
                      centerTitle: true,
                    ),
                    body: StreamBuilder<TaskModel>(
                        stream: tasksController.getTasks(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return Center(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                CircularProgressIndicator(),
                                Text("Carregando...")
                              ],
                            ));
                          } else if (snapshot.hasError) {
                            setState(() {});
                            return Container();
                          }
                          return Container(
                            child: ListView(
                              children: snapshot.data!.itens
                                  .map((e) => Dismissible(
                                        direction: DismissDirection.endToStart,
                                        background: Container(
                                          color: Colors.red,
                                          child: const Align(
                                            alignment: Alignment(0.9, 0),
                                            child: Icon(Icons.delete,
                                                color: Colors.white),
                                          ),
                                        ),
                                        key: ValueKey<String>(e.idItem),
                                        onDismissed:
                                            (DismissDirection direction) {
                                          itemController.deleteItem(item: e);
                                        },
                                        child: Item(
                                          itemModel: e,
                                        ),
                                      ))
                                  .toList(),
                            ),
                          );
                        }));
              });
        });
  }

  Future floatActionbutton() async {
    String? name = await showModal(null, "Nova Nota");
    if (name != null && name != "") {
      itemController.createItem(idNota: idButtonGlobal, text: name);
    }
  }

  Future<String?> showModal(String? name, String modalName) async {
    final _editController =
        TextEditingController(text: name != null ? name : "");
    late String retorno;
    await showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(modalName),
        actions: <Widget>[
          TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Nome da nota',
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
}

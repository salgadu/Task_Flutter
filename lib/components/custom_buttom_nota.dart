import 'dart:math';

import 'package:flutter/material.dart';
import 'package:task/blocs/modify_notas_bloc.dart';
import 'package:task/controllers/task_controller.dart';
import 'package:task/models/buttom_model.dart';
import 'package:task/models/task_model.dart';

class CustomButtomNota extends StatefulWidget {
  final String idButtom;
  final String nomeButtom;
  final List<ButtonModel>? listButton;

  CustomButtomNota(
      {Key? key,
      required this.idButtom,
      required this.nomeButtom,
      this.listButton})
      : super(key: key);

  @override
  State<CustomButtomNota> createState() => _CustomButtomNotaState();
}

class _CustomButtomNotaState extends State<CustomButtomNota> {
  final blocNotas = ModifyNotaBloc();
  final taskController = TaskController();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        taskController.updateLastButton(idLastButton: widget.idButtom);
      },
      onLongPress: () {
        showModal(context, widget.nomeButtom, "Editar ou Excluir Nota");
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 7, left: 10, right: 10),
        decoration: BoxDecoration(
          color: Colors.blue.shade50,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
            color: Color.fromRGBO(92, 157, 254, 1),
            style: BorderStyle.solid,
            width: 1.0,
          ),
        ),
        height: 50,
        alignment: Alignment.center,
        child: Text(
          widget.nomeButtom,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color.fromRGBO(92, 157, 254, 1),
            fontSize: 18,
          ),
        ),
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
                onPressed: () {
                  taskController.deleteLastButton();
                  taskController.deleteItem(id: widget.idButtom);
                  Navigator.pop(context, 'Excluir');
                },
                child: const Text(
                  'Excluir',
                  style: TextStyle(color: Colors.red),
                ),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, 'Cancelar'),
                child: const Text('Cancelar'),
              ),
              TextButton(
                onPressed: () {
                  taskController.updateNota(
                      name: widget.nomeButtom, id: widget.idButtom);
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

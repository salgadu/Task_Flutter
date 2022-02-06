import 'package:flutter/material.dart';
import 'package:task/blocs/modify_notas_bloc.dart';
import 'package:task/controllers/task_controller.dart';
import 'package:task/models/task_model.dart';

class CustomButtomNota extends StatefulWidget {
  final String idButtom;
  final String nomeButtom;

  CustomButtomNota({
    Key? key,
    required this.idButtom,
    required this.nomeButtom,
  }) : super(key: key);

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
        alignment: Alignment.centerLeft,
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
}

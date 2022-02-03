import 'package:flutter/material.dart';
import 'package:task/controllers/task_controller.dart';
import 'package:task/models/task_model.dart';

class CustomButtomNota extends StatelessWidget {
  CustomButtomNota({Key? key}) : super(key: key);
  final taskcontroller = TaskController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        print("jcbicwhcqi");
        final abcd = await taskcontroller.getTask();
        print(abcd.itens.first.nameItem);
        //final abcde = abcd.itens.first;
        // print(abcde.nameItem.toString());
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 5),
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
          "Nota",
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

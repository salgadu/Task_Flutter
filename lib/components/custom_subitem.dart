import 'package:flutter/material.dart';
import 'package:task/controllers/task_controller.dart';
import 'package:task/controllers/task_controller_subitem.dart';
import 'package:task/models/task_model.dart';

class SubItem extends StatefulWidget {
  final TaskSubItemModel subItemModel;
  SubItem({Key? key, required this.subItemModel}) : super(key: key);

  @override
  State<SubItem> createState() => _SubItemState();
}

class _SubItemState extends State<SubItem> {
  final taskControler = TaskControllerSubItem();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 40),
      child: GestureDetector(
        onLongPress: () async {
          //Todo para editar

          String? retorno = await showModal(widget.subItemModel.nameSubItem);
          if (retorno != null && retorno != "") {
            widget.subItemModel.setName = retorno;
            taskControler.updateSubItem(subItem: widget.subItemModel);
          }
        },
        child: Row(
          children: [
            Checkbox(
              value: widget.subItemModel.check,
              onChanged: (value) {
                widget.subItemModel.setCheck = value!;
                taskControler.updateSubItem(subItem: widget.subItemModel);
              },
            ),
            Text(
              widget.subItemModel.nameSubItem,
              style: TextStyle(
                decoration: widget.subItemModel.check
                    ? TextDecoration.lineThrough
                    : TextDecoration.none,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<String?> showModal(String name) async {
    final _editController = TextEditingController(text: name);
    late String retorno;
    await showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Editar'),
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

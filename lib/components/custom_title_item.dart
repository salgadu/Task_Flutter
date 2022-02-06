import 'package:flutter/material.dart';
import 'package:task/components/custom_subitem.dart';
import 'package:task/controllers/task_controller.dart';
import 'package:task/controllers/task_controller_item.dart';
import 'package:task/controllers/task_controller_subitem.dart';
import 'package:task/models/task_model.dart';

class CustomTitleItem extends StatefulWidget {
  final ItemModel item;

  CustomTitleItem({Key? key, required this.item}) : super(key: key);

  @override
  State<CustomTitleItem> createState() => _CustomTitleItemState();
}

class _CustomTitleItemState extends State<CustomTitleItem> {
  final taskController = TaskControllerSubItem();
  final itemController = TaskControllerItem();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
        onLongPress: () async {
          String? name = await showModal(widget.item.nameItem, "Editar");
          if (name != null && name != "") {
            widget.item.setName = name;
            itemController.updateItem(item: widget.item);
          }
        },
        child: Row(
          children: [
            Checkbox(
              value: widget.item.check,
              onChanged: (value) {
                widget.item.setCheck = value!;
                itemController.updateItem(item: widget.item);
              },
            ),
            Text(
              widget.item.nameItem,
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              width: 150,
            ),
            IconButton(
              onPressed: () async {
                String? name = await showModal(null, "Criar");
                if (name != null && name != "") {
                  taskController.createSubItem(
                      item: widget.item, textSubItem: name);
                }
              },
              icon: const Icon(Icons.add),
            )
          ],
        ),
      ),
    );
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

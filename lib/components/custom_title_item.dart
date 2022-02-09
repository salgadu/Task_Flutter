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
                for (int i = 0; i < widget.item.itens.length; i++) {
                  widget.item.itens[i].setCheck = value;
                  taskController.updateSubItem(subItem: widget.item.itens[i]);
                }
              },
            ),
            SizedBox(
              width: 10,
            ),
            Container(
              width: 180,
              child: Text(
                widget.item.nameItem,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 18.0,
                  decoration: widget.item.check
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                ),
              ),
            ),
            IconButton(
              onPressed: () async {
                String? name = await showModal(null, "Criar Subitem");
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
        actions: <Widget>[
          TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Nome item',
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

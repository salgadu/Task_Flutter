import 'package:flutter/material.dart';
import 'package:task/components/custom_subitem.dart';
import 'package:task/components/custom_title_item.dart';
import 'package:task/controllers/task_controller.dart';
import 'package:task/controllers/task_controller_subitem.dart';
import 'package:task/models/task_model.dart';

class Item extends StatefulWidget {
  final ItemModel itemModel;
  Item({
    Key? key,
    required this.itemModel,
  }) : super(key: key);

  @override
  _ItemState createState() => _ItemState();
}

class _ItemState extends State<Item> {
  final _takController = TaskControllerSubItem();
  List<bool> _isExpanded = List.generate(10, (_) => false);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          ExpansionTile(
              title: CustomTitleItem(
                item: widget.itemModel,
              ),
              children: widget.itemModel.itens
                  .map((e) => Dismissible(
                        background: Container(
                          color: Colors.red,
                          child: const Align(
                            alignment: Alignment(0.9, 0),
                            child: Icon(Icons.delete, color: Colors.white),
                          ),
                        ),
                        key: ValueKey<String>(e.idSubItem),
                        direction: DismissDirection.endToStart,
                        onDismissed: (DismissDirection direction) {
                          _takController.deleteSubItem(subItem: e);
                        },
                        child: SubItem(
                          subItemModel: e,
                        ),
                      ))
                  .toList()),
        ],
      ),
    );
  }
}

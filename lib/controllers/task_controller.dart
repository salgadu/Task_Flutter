import 'package:task/models/profile_model.dart';
import 'package:task/models/task_model.dart';

class TaskController {
  Future<TaskModel> getTask() async {
    Map<String, dynamic> teste = {
      "Nota1": {
        "item": {
          "item1": {
            "check": false,
            "name": "TesteName",
            "subItem": {
              "subItem1": {"check": false, "text": "raios"}
            }
          },
          "item2": {
            "check": false,
            "name": "TesteName",
            "subItem": {
              "subItem1": {"check": false, "text": "raios"}
            }
          }
        },
        "name": "Nota 1"
      }
    };
    return TaskModel.fromJson(teste);
  }
}

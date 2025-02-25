import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_b9/models/task.dart';

class TaskServices {
  ///Create Task
  Future createTask(TaskModel model) async {
    return await FirebaseFirestore.instance
        .collection('taskCollection')
        .add(model.toJson());
  }

  ///Delete Task
  Future deleteTask(String taskID) async {
    return await FirebaseFirestore.instance
        .collection('taskCollection')
        .doc(taskID)
        .delete();
  }

  ///Update Task
  Future updateTask(TaskModel model) async {
    return await FirebaseFirestore.instance
        .collection('taskCollection')
        .doc(model.taskId)
        .update({
      "title": model.title,
      "description": model.description,
    });
  }

  ///Get ALl Tasks
  ///Get Completed Tasks
  ///Get InCompleted Tasks
  ///Mark Task as Complete
  Future markTaskAsComplete(String taskID) async {
    return await FirebaseFirestore.instance
        .collection('taskCollection')
        .doc(taskID)
        .update({"isCompleted": true});
  }
}

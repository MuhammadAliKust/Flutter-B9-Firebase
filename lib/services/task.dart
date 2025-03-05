import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_b9/models/task.dart';

class TaskServices {
  ///Create Task
  Future createTask(TaskModel model) async {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection('taskCollection').doc();
    return await FirebaseFirestore.instance
        .collection('taskCollection')
        .doc(documentReference.id)
        .set(model.toJson(documentReference.id));
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
  Stream<List<TaskModel>> getAllTasks() {
    return FirebaseFirestore.instance
        .collection('taskCollection')
        .snapshots()
        .map((taskList) => taskList.docs
            .map((taskModel) => TaskModel.fromJson(taskModel.data()))
            .toList());
  }

  ///Get Completed Tasks
  Stream<List<TaskModel>> getCompletedTasks() {
    return FirebaseFirestore.instance
        .collection('taskCollection')
        .where('isCompleted', isEqualTo: true)
        .snapshots()
        .map((taskList) => taskList.docs
            .map((taskModel) => TaskModel.fromJson(taskModel.data()))
            .toList());
  }

  ///Get InCompleted Tasks
  Stream<List<TaskModel>> getInCompletedTasks() {
    return FirebaseFirestore.instance
        .collection('taskCollection')
        .where('isCompleted', isEqualTo: false)
        .snapshots()
        .map((taskList) => taskList.docs
            .map((taskModel) => TaskModel.fromJson(taskModel.data()))
            .toList());
  }

  ///Mark Task as Complete
  Future markTaskAsComplete(String taskID) async {
    return await FirebaseFirestore.instance
        .collection('taskCollection')
        .doc(taskID)
        .update({"isCompleted": true});
  }
}

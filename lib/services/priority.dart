import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_b9/models/priority.dart';

class PriorityServices{
  Future<List<PriorityModel>> getAllPriority() {
    return FirebaseFirestore.instance
        .collection('priorityCollection')
        .get()
        .then((taskList) => taskList.docs
        .map((taskModel) => PriorityModel.fromJson(taskModel.data()))
        .toList());
  }
}
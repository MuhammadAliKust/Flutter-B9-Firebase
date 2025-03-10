// To parse this JSON data, do
//
//     final taskModel = taskModelFromJson(jsonString);

import 'dart:convert';

class TaskModel {
  final String? taskId;
  final String? title;
  final String? description;
  final String? priorityID;
  final String? priorityName;
  final String? image;
  final bool? isCompleted;
  final int? createdAt;

  TaskModel({
    this.taskId,
    this.title,
    this.description,
    this.priorityID,
    this.priorityName,
    this.image,
    this.isCompleted,
    this.createdAt,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) => TaskModel(
        taskId: json["taskID"],
        title: json["title"],
        description: json["description"],
        image: json["image"],
        isCompleted: json["isCompleted"],
        createdAt: json["createdAt"],
        priorityID: json["priorityID"],
        priorityName: json["priorityName"],
      );

  Map<String, dynamic> toJson(String docID) => {
        "taskID": docID,
        "title": title,
        "description": description,
        "image": image,
        "isCompleted": isCompleted,
        "priorityName": priorityName,
        "priorityID": priorityID,
        "createdAt": createdAt,
      };
}

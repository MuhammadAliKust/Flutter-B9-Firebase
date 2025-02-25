// To parse this JSON data, do
//
//     final taskModel = taskModelFromJson(jsonString);

import 'dart:convert';

TaskModel taskModelFromJson(String str) => TaskModel.fromJson(json.decode(str));

String taskModelToJson(TaskModel data) => json.encode(data.toJson());

class TaskModel {
  final String? taskId;
  final String? title;
  final String? description;
  final String? image;
  final bool? isCompleted;
  final int? createdAt;

  TaskModel({
    this.taskId,
    this.title,
    this.description,
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
      );

  Map<String, dynamic> toJson() => {
        "taskID": taskId,
        "title": title,
        "description": description,
        "image": image,
        "isCompleted": isCompleted,
        "createdAt": createdAt,
      };
}

import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_b9/models/priority.dart';
import 'package:flutter_b9/models/task.dart';
import 'package:flutter_b9/services/priority.dart';
import 'package:flutter_b9/services/task.dart';

class CreateTaskView extends StatefulWidget {
  CreateTaskView({super.key});

  @override
  State<CreateTaskView> createState() => _CreateTaskViewState();
}

class _CreateTaskViewState extends State<CreateTaskView> {
  TextEditingController titleController = TextEditingController();

  TextEditingController descriptionController = TextEditingController();
  List<PriorityModel> priorityList = [];
  bool isLoading = false;
  PriorityModel? selectedPriority;

  @override
  void initState() {
    PriorityServices().getAllPriority().then((val) {
      priorityList = val;
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    log(priorityList.length.toString());
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Task"),
      ),
      body: Column(
        children: [
          TextField(
            controller: titleController,
          ),
          TextField(
            controller: descriptionController,
          ),
          SizedBox(
            height: 10,
          ),
          DropdownButton(
              items: priorityList
                  .map((e) => DropdownMenuItem(
                        child: Text(e.name.toString()),
                        value: e,
                      ))
                  .toList(),
              isExpanded: true,
              hint: Text("Select Priority"),
              value: selectedPriority,
              onChanged: (val) {
                selectedPriority = val;
                setState(() {});
              }),
          SizedBox(
            height: 30,
          ),
          isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : ElevatedButton(
                  onPressed: () async {
                    if (titleController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Title canot be empty")));
                      return;
                    }
                    if (descriptionController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("Description canot be empty")));
                      return;
                    }

                    try {
                      isLoading = true;
                      setState(() {});
                      await TaskServices()
                          .createTask(TaskModel(
                              title: titleController.text,
                              description: descriptionController.text,
                              isCompleted: false,
                              userID: FirebaseAuth.instance.currentUser!.uid.toString(),
                              image: "",
                              priorityID: selectedPriority!.docId.toString(),
                              priorityName: selectedPriority!.name.toString(),
                              createdAt: DateTime.now().millisecondsSinceEpoch))
                          .then((val) {
                        isLoading = false;
                        setState(() {});
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text("Message"),
                                content:
                                    Text("Task has been created succesfully"),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                        Navigator.pop(context);
                                      },
                                      child: Text("Okay"))
                                ],
                              );
                            });
                      });
                    } catch (e) {
                      isLoading = false;
                      setState(() {});
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text(e.toString())));
                    }
                  },
                  child: Text("Create Task"))
        ],
      ),
    );
  }
}

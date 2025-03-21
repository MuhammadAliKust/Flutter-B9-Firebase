import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_b9/models/task.dart';
import 'package:flutter_b9/services/task.dart';
import 'package:flutter_b9/views/create_task.dart';
import 'package:flutter_b9/views/profile.dart';
import 'package:flutter_b9/views/update_task.dart';
import 'package:provider/provider.dart';

class GetAllTaskView extends StatelessWidget {
  const GetAllTaskView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Get All Task"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ProfileView()));
              },
              icon: Icon(Icons.person))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => CreateTaskView()));
        },
        child: Icon(Icons.add),
      ),
      body: StreamProvider.value(
        value: TaskServices().getAllTasks(FirebaseAuth.instance.currentUser!.uid.toString()),
        initialData: [TaskModel()],
        builder: (context, child) {
          List<TaskModel> taskList = context.watch<List<TaskModel>>();
          return ListView.builder(
              itemCount: taskList.length,
              itemBuilder: (context, i) {
                return ListTile(
                  leading: Icon(Icons.task),
                  title: Text(taskList[i].title.toString()),
                  subtitle: Text(taskList[i].description.toString()),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.flag,
                        color: taskList[i].priorityName == "High"
                            ? Colors.red
                            : Colors.green,
                      ),
                      // IconButton(
                      //     onPressed: () async {
                      //       try {
                      //         await TaskServices()
                      //             .deleteTask(taskList[i].taskId.toString());
                      //       } catch (e) {
                      //         ScaffoldMessenger.of(context).showSnackBar(
                      //             SnackBar(content: Text(e.toString())));
                      //       }
                      //     },
                      //     icon: Icon(
                      //       Icons.delete,
                      //       color: Colors.red,
                      //     )),
                      Checkbox(
                          value: taskList[i].isCompleted,
                          onChanged: (val) async {
                            try {
                              await TaskServices().markTaskAsComplete(
                                  taskList[i].taskId.toString());
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(e.toString())));
                            }
                          }),
                      IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => UpdateTaskView(
                                          model: taskList[i],
                                        )));
                          },
                          icon: Icon(Icons.edit))
                    ],
                  ),
                );
              });
        },
      ),
    );
  }
}

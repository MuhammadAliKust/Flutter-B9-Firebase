import 'package:flutter/material.dart';
import 'package:flutter_b9/models/task.dart';
import 'package:flutter_b9/models/user.dart';
import 'package:flutter_b9/services/task.dart';
import 'package:flutter_b9/services/user.dart';
import 'package:flutter_b9/views/get_all_task.dart';

class UpdateProfileView extends StatefulWidget {
  final UserModel model;

  UpdateProfileView({super.key, required this.model});

  @override
  State<UpdateProfileView> createState() => _UpdateProfileViewState();
}

class _UpdateProfileViewState extends State<UpdateProfileView> {
  TextEditingController nameController = TextEditingController();

  TextEditingController phoneController = TextEditingController();

  bool isLoading = false;

  @override
  void initState() {
    nameController = TextEditingController(text: widget.model.name.toString());
    phoneController =
        TextEditingController(text: widget.model.phone.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Update Profile"),
      ),
      body: Column(
        children: [
          TextField(
            controller: nameController,
          ),
          TextField(
            controller: phoneController,
          ),
          SizedBox(
            height: 30,
          ),
          isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : ElevatedButton(
                  onPressed: () async {
                    if (nameController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Name canot be empty")));
                      return;
                    }
                    if (phoneController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Phone canot be empty")));
                      return;
                    }

                    try {
                      isLoading = true;
                      setState(() {});
                      await UserServices()
                          .updateTask(UserModel(
                              name: nameController.text,
                              phone: phoneController.text,
                              docId: widget.model.docId.toString()))
                          .then((val) {
                        isLoading = false;
                        setState(() {});
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text("Message"),
                                content:
                                    Text("Profile has been updated succesfully"),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                         Navigator.push(context, MaterialPageRoute(builder: (context)=>GetAllTaskView()));
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
                  child: Text("Update Task"))
        ],
      ),
    );
  }
}

import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_b9/models/user.dart';
import 'package:flutter_b9/services/user.dart';
import 'package:flutter_b9/views/update_profile.dart';
import 'package:provider/provider.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    log(FirebaseAuth.instance.currentUser!.uid.toString());
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
      ),
      body: FutureProvider.value(
        value:
            UserServices().getUserByID(FirebaseAuth.instance.currentUser!.uid),
        initialData: UserModel(),
        builder: (context, child) {
          UserModel userModel = context.watch<UserModel>();
          return Column(
            children: [
              Text(
                "Name: ${userModel.name.toString()}",
                style: TextStyle(fontSize: 20),
              ),
              Text(
                "Phone: ${userModel.phone.toString()}",
                style: TextStyle(fontSize: 20),
              ),
              Text(
                "Email: ${userModel.email.toString()}",
                style: TextStyle(fontSize: 20),
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                UpdateProfileView(model: userModel)));
                  },
                  child: Text("Update Profile"))
            ],
          );
        },
      ),
    );
  }
}

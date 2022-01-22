import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:simple_chat_app/controllers/auth_controller.dart';
import 'package:simple_chat_app/controllers/controllers.dart';
import 'package:simple_chat_app/models/user_model.dart';
import 'package:simple_chat_app/views/main_screen.dart';

class ChatNameUpdate extends StatefulWidget {
  ChatNameUpdate({Key? key}) : super(key: key);

  @override
  _ChatNameUpdateState createState() => _ChatNameUpdateState();
}

class _ChatNameUpdateState extends State<ChatNameUpdate> {
  final AuthController authController = AuthController.getAuth;
  final TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: size.height * 0.15,
                ),
                Center(
                  child: Image(
                    image: AssetImage('images/chat_name_enter.png'),
                    height: size.height * 0.25,
                  ),
                ),
                SizedBox(
                  height: size.height * 0.03,
                ),
                Center(
                  child: Text(
                    'Enter your nickname and profile pic\n to help your friends recognize\n you',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.05,
                ),
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.blueGrey,
                      child: Icon(
                        Icons.person,
                      ),
                      radius: size.width * 0.1,
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    Expanded(
                      child: TextField(
                        controller: nameController,
                        decoration: InputDecoration(
                          hintText: 'Enter nickname',
                          labelText: 'enter nickname',
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: size.height * 0.05,
                ),
                ElevatedButton(
                  onPressed: () async {
                    UserModel updateUser = UserModel(
                      uid: authController.firestoreUser.value!.uid,
                      nickname: nameController.value.text,
                      profileImg: '',
                      phoneNo: authController.firestoreUser.value!.phoneNo,
                    );
                    authController.updateUserFirestoreData(updateUser);
                    //connectCubeController.cubeUserUpdate();
                    nameController.clear();
                  },
                  child: Text(
                    'Done',
                    style: TextStyle(fontSize: 20),
                  ),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.all(20),
                    primary: Colors.blueGrey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// import 'package:connectycube_sdk/connectycube_meetings.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get/get_state_manager/get_state_manager.dart';
// import 'package:simple_chat_app/controllers/controllers.dart';
// import 'dart:async';
// import 'package:simple_chat_app/utils/connecty_cube_configs.dart' as config;

// class ConnectCubeController extends GetxController {
//   static ConnectCubeController connectCube = Get.find();

//   String projectId = 'chata-e393f';
//   Rxn<CubeUser> user = Rxn<CubeUser>();

//   @override
//   void onInit() {
//     init(config.appId, config.authKey, config.authSecret);

//     getToken();
//     super.onInit();
//   }

//   void getToken() async {
//     authController.auth.idTokenChanges().listen((user) async {
//       if (user != null) {
//         String token = await user.getIdToken(true);
//         if (!isEmpty(token)) {
//           signInUsingFirebase(projectId, token).then((cubeUser) {
//             createSessionUsingFirebase(projectId, token);
//           }).catchError((onError) {});
//         }
//       }
//     });
//     update();
//   }

//   void cubeUserUpdate() {
//     CubeUser updateUserData =
//         CubeUser(fullName: authController.firestoreUser.value?.nickname)
//           ..id = user.value?.id;
//     updateUser(updateUserData);
//   }
// }

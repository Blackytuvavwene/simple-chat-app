import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:simple_chat_app/controllers/connect_tube_controller.dart';
import 'package:simple_chat_app/controllers/controllers.dart';
import 'package:simple_chat_app/models/user_model.dart';
import 'package:simple_chat_app/views/chat_name_update.dart';
import 'package:simple_chat_app/views/home_screen.dart';
import 'package:simple_chat_app/views/main_screen.dart';
import 'package:simple_chat_app/views/otp_dialog.dart';
import 'package:simple_chat_app/views/registration_screen.dart';
import 'dart:async';

class AuthController extends GetxController {
  static AuthController getAuth = Get.find();

  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore _dataBase = FirebaseFirestore.instance;
  Rxn<User> firebaseUser = Rxn<User>();
  Rxn<UserModel> firestoreUser = Rxn<UserModel>();
  final TextEditingController inputNumber = TextEditingController();
  final TextEditingController otpController = TextEditingController();

  String? verificationId;
  var isLoading = false.obs;

  //dispose controllers
  @override
  void onClose() {
    inputNumber.dispose();
    otpController.dispose();

    super.onClose();
  }

  //handle user changes everytime user state changes
  @override
  void onReady() {
    ever(firebaseUser, userStateChanges);
    firebaseUser.bindStream(_user);
  }

//function to check user state
  userStateChanges(User? _firebaseUser) {
    if (_firebaseUser != null && firestoreUser.value?.nickname == null) {
      firestoreUser.bindStream(_firestoreUserStream());
      Get.offAll(() => ChatNameUpdate());
    }
    if (_firebaseUser == null) {
      Get.offAll(() => RegistrationScreen());
    } else {
      Get.offAll(() => MainScreen());
    }
  }

  //get current user
  Future<User> get getUser async => auth.currentUser!;

  //get user changes realtime
  Stream<User?> get _user => auth.userChanges();

  //stream user info from firestore
  Stream<UserModel> _firestoreUserStream() {
    return _dataBase
        .collection('users')
        .doc(firebaseUser.value!.uid)
        .snapshots()
        .map(
          (snapshots) => UserModel.fromMap(
            snapshots.data()!,
          ),
        );
  }

  //get user info from firestore
  Future<UserModel> getUserFromFirestore() async {
    return _dataBase.doc('users/${firebaseUser.value!.uid}').get().then(
          (docSnapshot) => UserModel.fromMap(
            docSnapshot.data()!,
          ),
        );
  }

  //handle phone sign up
  Future<void> handlePhoneSign(BuildContext context) async {
    final PhoneCodeSent smsOtp = (String verId, [int? forceCodeResend]) {
      this.verificationId = verId;
      customOtpDialog(context).then((value) {
        print('sign in');
      });
    };
    try {
      await auth.verifyPhoneNumber(
        phoneNumber: inputNumber.text.trim(),
        verificationCompleted: (PhoneAuthCredential credential) async {
          // ANDROID ONLY!

          // Sign the user in (or link) with the auto-generated credential
          await auth.signInWithCredential(credential);
        },
        verificationFailed: (FirebaseAuthException e) {
          if (e.code == 'invalid-phone-number') {
            print('The provided phone number is not valid.');
          }

          // Handle other errors
        },
        codeSent: smsOtp,
        timeout: const Duration(seconds: 60),
        codeAutoRetrievalTimeout: (String verificationId) {
          // Auto-resolution timed out...
        },
      );
      inputNumber.clear();
    } catch (e) {
      print(e.toString());
    }
  }

  otpCodeSignIn(BuildContext context) async {
    isLoading(true);
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificationId ?? '', smsCode: otpController.text);
      await auth.signInWithCredential(credential).then((result) async {
        //create new user
        UserModel _newUser = UserModel(
          uid: result.user?.uid,
          phoneNo: result.user?.phoneNumber,
        );
        _createUser(_newUser, result.user!);
        //connectCubeController.getToken();
        update();
      });
    } catch (e) {}
    isLoading(false);
    Get.to(() => ChatNameUpdate());
  }

  //create the firestore user in users collection
  void _createUser(UserModel user, User _firebaseUser) {
    _dataBase.doc('/users/${_firebaseUser.uid}').set(user.toJson());
    update();
  }

  //updates the firestore user in users collection
  void updateUserFirestoreData(UserModel user) {
    _dataBase
        .collection('users')
        .doc(firebaseUser.value?.uid)
        .update(user.toJson());
    update();
    Get.to(() => MainScreen());
  }
}

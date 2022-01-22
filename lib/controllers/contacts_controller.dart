import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:simple_chat_app/controllers/controllers.dart';
import 'package:simple_chat_app/views/contacts_screen.dart';

class ContactsController extends GetxController {
  static ContactsController contactsController = Get.find();
  RxList<Contact> contactsList = RxList<Contact>([]);
  final FirebaseFirestore contactDb = FirebaseFirestore.instance;
  //List<Contact>? get contacts => contactsList;

  @override
  void onInit() {
    getContacts();
    super.onInit();
  }

  Future<void> getContacts() async {
    var contacts = (await ContactsService.getContacts(
      withThumbnails: false,
      iOSLocalizedLabels: false,
    ))
        .toList();
    contactsList.addAll(contacts);
  }

  uploadContact() {
    contactDb
        .collection('users')
        .doc(authController.firebaseUser.value?.uid)
        .collection('contacts')
        .add({'name': contactsList.toString()});
  }

  getContactsFromFirestore() {
    contactDb
        .collection('users')
        .where('phoneNo',
            isEqualTo: authController.firestoreUser.value?.phoneNo)
        .get();
  }
}

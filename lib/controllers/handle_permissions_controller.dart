import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:simple_chat_app/views/contacts_screen.dart';

class HandlePermissionsController extends GetxController {
  static HandlePermissionsController permissionsController = Get.find();

  @override
  void onInit() {
    askPermissions();

    super.onInit();
  }

  Future<void> askPermissions() async {
    PermissionStatus permissionStatus = await getContactPermission();
    if (permissionStatus == PermissionStatus.granted) {
      Get.offAll(() => ContactsScreen());
    } else {
      _handleInvalidPermissions(permissionStatus);
    }
  }

  Future<PermissionStatus> getContactPermission() async {
    PermissionStatus permission = await Permission.contacts.status;
    if (permission != PermissionStatus.granted &&
        permission != PermissionStatus.permanentlyDenied) {
      PermissionStatus permissionStatus = await Permission.contacts.request();
      return permissionStatus;
    } else {
      return permission;
    }
  }

  void _handleInvalidPermissions(PermissionStatus permissionStatus) {
    if (permissionStatus == PermissionStatus.denied) {
      Get.snackbar('Permission error', 'Permission is not granted');
    } else if (permissionStatus == PermissionStatus.permanentlyDenied) {
      SnackBar(content: Text('Contact data not available on device'));
    }
  }
}

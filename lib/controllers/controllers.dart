import 'package:simple_chat_app/controllers/auth_controller.dart';
import 'package:simple_chat_app/controllers/chat_msgs_controller.dart';
import 'package:simple_chat_app/controllers/connect_tube_controller.dart';
import 'package:simple_chat_app/controllers/contacts_controller.dart';
import 'package:simple_chat_app/controllers/handle_permissions_controller.dart';

//ConnectCubeController connectCubeController = ConnectCubeController.connectCube;
AuthController authController = AuthController.getAuth;
ChatMsgsController chatMsgsController = ChatMsgsController.chatMsgsController;
ContactsController contactsController = ContactsController.contactsController;
HandlePermissionsController permissionsController =
    HandlePermissionsController.permissionsController;

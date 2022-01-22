import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:simple_chat_app/controllers/controllers.dart';
import 'package:simple_chat_app/models/my_chats_model.dart';
import 'package:simple_chat_app/models/user_model.dart';
import 'package:simple_chat_app/views/home_screen.dart';

class ChatMsgsController extends GetxController {
  static ChatMsgsController chatMsgsController = Get.find();
  final FirebaseFirestore chaDb = FirebaseFirestore.instance;
  final RxList<ChatModel> chatList = RxList<ChatModel>([]);

  @override
  void onReady() {
    chatList.bindStream(myChatList());
  }

  showList() {
    if (chatList.value.isEmpty) {
      return NoChats();
    } else {
      return MyChats();
    }
  }

  createChat(ChatModel chatModel) {
    chaDb
        .collection('users')
        .doc(authController.firebaseUser.value?.uid)
        .collection('chats')
        .add(chatModel.toJson());
  }

  Stream<List<ChatModel>> myChatList() {
    return chaDb
        .collection('users')
        .doc(authController.firebaseUser.value?.uid)
        .collection('chats')
        .snapshots()
        .map(
          (snapshots) => snapshots.docs
              .map((chats) => ChatModel.fromMap(chats.data()))
              .toList(),
        );
  }
}

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/route_manager.dart';
import 'package:simple_chat_app/controllers/chat_msgs_controller.dart';
import 'package:simple_chat_app/controllers/contacts_controller.dart';
import 'package:simple_chat_app/controllers/controllers.dart';
import 'package:simple_chat_app/views/chat_screen.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ChatMsgsController chatMsgsController = ChatMsgsController();
  final ContactsController contactsController = Get.put(ContactsController());
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      extendBody: true,
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: CircleAvatar(
            radius: 100,
          ),
        ),
        title: Text(
          '${contactsController.getContactsFromFirestore()}',
          style: TextStyle(
            color: Colors.black,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: GestureDetector(
                onTap: () {
                  Drawer(
                    child: Container(
                      height: 100,
                      width: 100,
                      color: Colors.black,
                    ),
                  );
                  DrawerHeader(child: Container());
                },
                child: FaIcon(
                  FontAwesomeIcons.ellipsisV,
                  color: Colors.black,
                ),
              ),
            ),
          )
        ],
        backgroundColor: Colors.white,
        shadowColor: Colors.transparent,
        toolbarHeight: size.height * 0.080,
      ),
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.blueGrey.shade100,
                    hintText: 'Search',
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                chatMsgsController.showList()
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MyChats extends StatelessWidget {
  const MyChats({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      //scrollDirection: Axis.vertical,
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: 20,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(
            left: 10,
            top: 4,
            bottom: 4,
            right: 10,
          ),
          child: SizedBox(
            height: 150,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              elevation: 10,
              shadowColor: Colors.blueGrey,
              child: Center(
                child: ListTile(
                  onTap: () {
                    Get.to(() => ChatScreen());
                  },
                  //contentPadding: EdgeInsets.all(10),
                  title: Text('John'),
                  subtitle:
                      Text("let me see tomorrow an what what can you not do"),
                  leading: CircleAvatar(),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class NoChats extends StatelessWidget {
  const NoChats({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: size.height * 0.2,
        ),
        Image(
          image: AssetImage('images/chat_screen.png'),
          height: size.height * 0.255,
        ),
        SizedBox(
          height: size.height * 0.015,
        ),
        Text(
          'No chats yet add friends\n to start chatting',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

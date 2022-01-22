import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_chat_app/controllers/auth_controller.dart';
import 'package:simple_chat_app/controllers/chat_msgs_controller.dart';
import 'package:simple_chat_app/controllers/connect_tube_controller.dart';
import 'package:simple_chat_app/controllers/contacts_controller.dart';
import 'package:simple_chat_app/views/start_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  Get.put<AuthController>(AuthController());
  //Get.put<ConnectCubeController>(ConnectCubeController());
  Get.put<ChatMsgsController>(ChatMsgsController());
  //Get.put<ContactsController>(ContactsController());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: StartPage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: null,
    );
  }
}

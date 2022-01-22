import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/route_manager.dart';
import 'package:simple_chat_app/controllers/contacts_controller.dart';
import 'package:simple_chat_app/controllers/controllers.dart';
import 'package:simple_chat_app/controllers/handle_permissions_controller.dart';
import 'package:simple_chat_app/views/call_screen.dart';
import 'package:simple_chat_app/views/contacts_screen.dart';
import 'package:simple_chat_app/views/home_screen.dart';
import 'package:simple_chat_app/views/stories_screen.dart';

class MainScreen extends StatefulWidget {
  MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  List<Widget> _pages() => [
        HomeScreen(),
        StoriesScreen(),
        CallScreen(),
      ];

  @override
  Widget build(BuildContext context) {
    final HandlePermissionsController permissionsController =
        HandlePermissionsController();
    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.white,
      body: SafeArea(
        bottom: false,
        child: IndexedStack(
          index: _selectedIndex,
          children: _pages(),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(15),
        child: Container(
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(color: Colors.blueGrey, blurRadius: 10),
          ], borderRadius: BorderRadius.circular(30)),
          height: 70,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: BottomNavigationBar(
              type: BottomNavigationBarType.shifting,
              items: [
                BottomNavigationBarItem(
                    icon: FaIcon(
                      FontAwesomeIcons.comments,
                    ),
                    label: 'Chat'),
                BottomNavigationBarItem(
                    icon: FaIcon(
                      FontAwesomeIcons.newspaper,
                    ),
                    label: 'Stories'),
                BottomNavigationBarItem(
                    icon: FaIcon(
                      FontAwesomeIcons.phone,
                    ),
                    label: 'Call'),
              ],
              currentIndex: _selectedIndex,
              selectedItemColor: Colors.blueAccent,
              unselectedItemColor: Colors.blueGrey,
              onTap: _onItemTapped,
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        foregroundColor: Colors.black,
        backgroundColor: Colors.blueGrey,
        elevation: 10,
        onPressed: () {
          permissionsController.askPermissions();
        },
        child: FaIcon(
          FontAwesomeIcons.comment,
          color: Colors.white,
          size: 30,
        ),
      ),
    );
  }
}

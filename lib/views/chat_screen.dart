import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ChatScreen extends StatefulWidget {
  ChatScreen({Key? key}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: CircleAvatar(
            radius: 100,
          ),
        ),
        title: Text(
          'John',
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
              child: FaIcon(
                FontAwesomeIcons.video,
                color: Colors.black,
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: FaIcon(
                FontAwesomeIcons.phone,
                color: Colors.black,
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: FaIcon(
                FontAwesomeIcons.ellipsisV,
                color: Colors.black,
              ),
            ),
          )
        ],
        backgroundColor: Colors.white,
        shadowColor: Colors.transparent,
        toolbarHeight: size.height * 0.080,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Container(
            child: Stack(
              children: [
                Text('data'),
                Container(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.blueGrey.shade100,
                            hintText: 'Type a message',
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          maxLines: 5,
                          minLines: 1,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child:
                            FaIcon(FontAwesomeIcons.solidPaperPlane, size: 30),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

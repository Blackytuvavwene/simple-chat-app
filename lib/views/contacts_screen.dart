import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';

import 'package:simple_chat_app/controllers/contacts_controller.dart';
import 'package:simple_chat_app/views/main_screen.dart';

class ContactsScreen extends StatefulWidget {
  const ContactsScreen({Key? key}) : super(key: key);

  @override
  _ContactsScreenState createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen> {
  List<Contact>? _contacts;

  @override
  void initState() {
    super.initState();
    refreshContacts();
  }

  Future<void> refreshContacts() async {
    // Load without thumbnails initially.
    var contacts = (await ContactsService.getContacts(
      withThumbnails: false,
    ))
        .toList();
//      var contacts = (await ContactsService.getContactsForPhone("8554964652"))
//          .toList();
    setState(() {
      _contacts = contacts;
    });
  }

  @override
  Widget build(BuildContext context) {
    final ContactsController contactsController = Get.put(ContactsController());
    final size = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          contactsController.uploadContact();
        },
      ),
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: Center(
          child: GestureDetector(
            onTap: () {
              Get.to(() => MainScreen());
            },
            child: FaIcon(
              FontAwesomeIcons.arrowAltCircleLeft,
              color: Colors.black,
            ),
          ),
        ),
        backgroundColor: Colors.white,
        title: Text(
          'My contacts',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: contactsController.contactsList != null
          ? SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: contactsController.contactsList.length,
                  itemBuilder: (context, item) {
                    Contact? c =
                        contactsController.contactsList.elementAt(item);

                    return ListTile(
                      title: Text(
                        c.displayName ?? '',
                        style: TextStyle(color: Colors.black),
                      ),
                      subtitle: Text(
                          '${c.phones?.map((e) => e.value ?? ' ').toList()}'),
                    );
                  }),
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}

class PhoneNo extends StatelessWidget {
  PhoneNo({
    this.items,
  });
  final Iterable<Item>? items;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: items!
          .map((e) => ListTile(
              title: Text(e.label ?? ''), trailing: Text(e.value ?? '')))
          .toList(),
    );
  }
}

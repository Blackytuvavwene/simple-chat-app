import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:simple_chat_app/controllers/auth_controller.dart';
import 'package:simple_chat_app/views/otp_dialog.dart';

class RegistrationScreen extends StatelessWidget {
  RegistrationScreen({Key? key}) : super(key: key);

  final AuthController authController = AuthController.getAuth;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: size.height * 0.15,
                ),
                Center(
                  child: Image(
                    image: AssetImage('images/phone_no_reg_screen.png'),
                    height: size.height * 0.2,
                  ),
                ),
                SizedBox(
                  height: size.height * 0.18,
                ),
                Center(
                  child: Text(
                    'Use your phone number to register and\n start chatting',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.05,
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: TextField(
                    controller: authController.inputNumber,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(20),
                      hintText: 'Enter your phone number',
                      hintStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                      labelText: 'Enter your phone number',
                      border: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 20,
                            style: BorderStyle.solid,
                          ),
                          gapPadding: 10,
                          borderRadius: BorderRadius.circular(30)),
                    ),
                    onChanged: (value) => null,
                    onSubmitted: (value) =>
                        authController.inputNumber.text = value,
                  ),
                ),
                SizedBox(
                  height: size.height * 0.03,
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: ElevatedButton(
                    onPressed: () async {
                      authController.handlePhoneSign(context);
                    },
                    child: Text(
                      'Get code',
                      style: TextStyle(fontSize: 20),
                    ),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.all(20),
                      primary: Colors.blueGrey,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:simple_chat_app/controllers/auth_controller.dart';
import 'package:simple_chat_app/views/chat_name_update.dart';

Future customOtpDialog(BuildContext context) {
  final AuthController authController = AuthController.getAuth;
  final size = MediaQuery.of(context).size;
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          insetAnimationDuration: Duration(milliseconds: 1000),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40),
          ),
          child: SizedBox(
            height: size.height * 0.6,
            width: size.height * 0.6,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image(
                      image: AssetImage('images/sms_code.png'),
                      height: size.height * 0.2,
                    ),
                    SizedBox(
                      height: size.height * 0.1,
                    ),
                    Center(
                      child: Text(
                        'Enter received code to confirm\n phone number',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.025,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 40, right: 40),
                      child: TextField(
                        controller: authController.otpController,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(20),
                          hintText: 'Enter otp',
                          hintStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                          labelText: 'Enter otp',
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
                            authController.otpController.text = value,
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.025,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 40,
                        right: 40,
                      ),
                      child: ElevatedButton(
                        onPressed: () {
                          authController.otpCodeSignIn(context);
                        },
                        child: Text(
                          'Confirm code',
                          style: TextStyle(
                            fontSize: size.height * 0.0155,
                          ),
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
      });
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:otpapps/home_page.dart';
import 'package:otpapps/phone_page.dart';

import 'package:pinput/pinput.dart';


class OtpApp extends StatefulWidget {
  const OtpApp({super.key});

  @override
  State<OtpApp> createState() => _OtpAppState();
}

class _OtpAppState extends State<OtpApp> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: TextStyle(
          fontSize: 20,
          color: Color.fromRGBO(30, 60, 87, 1),
          fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: Color.fromRGBO(234, 239, 243, 1)),
        borderRadius: BorderRadius.circular(20),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: Color.fromRGBO(114, 178, 238, 1)),
      borderRadius: BorderRadius.circular(8),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: Color.fromRGBO(234, 239, 243, 1),
      ),
    );
    var code = "";
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          leading: const BackButton(
            color: Colors.black,
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Container(
          margin: const EdgeInsets.only(right: 25, left: 25),
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 100,
                width: 100,
                child: Image.asset(
                  "assets/images/img1.png",
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Phone Verification",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "We need to register your phone before getting started! ",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Pinput(
                length: 6,
                showCursor: true,
                onChanged: (value) {
                  code = value;
                },
              ),
              SizedBox(
                height: 30,
              ),
              SizedBox(
                height: 45,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    try {
                      PhoneAuthCredential credential =
                          PhoneAuthProvider.credential(
                              verificationId: PhonePage.verify, smsCode: code);

                      // Sign the user in (or link) with the credential
                      await auth.signInWithCredential(credential);
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => HomePage()));
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                         SnackBar(content: Text("Enter correct pincode"),
                         backgroundColor: Colors.green.shade600,
                         ),
                         
                      );
                    }
                  },
                  child: Text("Verify phone number"),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green.shade600,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20))),
                ),
              ),

              
              Row(
                children: [
                  TextButton(
                      onPressed: () {
                           Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) =>  PhonePage()));
                      },
                      child: const Text(
                        'Edit Phone Number ?',
                        style: TextStyle(color: Colors.black),
                      )),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

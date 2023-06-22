import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otpapps/home_page.dart';
import 'package:otpapps/opt_app.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PhonePage extends StatefulWidget {
  PhonePage({super.key});

  static String verify = "";

  @override
  State<PhonePage> createState() => _PhonePageState();
}

class _PhonePageState extends State<PhonePage> {
  @override
  TextEditingController country = TextEditingController();
  var phone = "";

  @override
  void initState() {
    country.text = "+92";
    super.initState();
  }

  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
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
              Container(
                height: 55,
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.grey),
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                      width: 40,
                      child: TextField(
                        controller: country,
                        decoration:
                            const InputDecoration(border: InputBorder.none),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Text(
                      "|",
                      style: TextStyle(fontSize: 33, color: Colors.grey),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      child: TextField(
                        keyboardType: TextInputType.phone,
                        onChanged: (value) {
                          phone = value;
                        },
                        decoration: const InputDecoration(
                            border: InputBorder.none, hintText: "phone"),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 45,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    await FirebaseAuth.instance.verifyPhoneNumber(
                      phoneNumber: '${country.text + phone}',
                      timeout: const Duration(seconds: 60),
                      verificationCompleted:
                          (PhoneAuthCredential credential) {},
                      verificationFailed: (FirebaseAuthException e) {},
                      codeSent:
                          (String verificationId, int? resendToken) async {
                        PhonePage.verify = verificationId;

                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        prefs
                            .setString('number', country.text)
                            .then((value) => Get.offAll(OtpApp()));

                        //    Navigator.pushReplacement(context,
                        // MaterialPageRoute(builder: (context) => const OtpApp()));
                      },
                      codeAutoRetrievalTimeout: (String verificationId) {},
                    );
                  },
                  child: Text("Send the code"),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green.shade600,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20))),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

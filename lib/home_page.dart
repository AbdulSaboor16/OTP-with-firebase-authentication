import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:otpapps/opt_app.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeController extends GetxController {
  RxBool isLoading = false.obs;

  Future<void> clearSharedPreferences() async {
    isLoading.value = true;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    isLoading.value = false;

    Get.offAll(const OtpApp());
  }
}

class HomePage extends StatelessWidget {
  final HomeController controller = Get.put(HomeController());
  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text("welcome to home page"),
      // ),
   
      body: Center(
        child: ElevatedButton(
              onPressed: () {
                if (!controller.isLoading.value) {
                  controller.clearSharedPreferences();
                }
              },
              child: Obx(() => controller.isLoading.value
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text("Logout Page")),
            ),
      ),
    );
  }
}

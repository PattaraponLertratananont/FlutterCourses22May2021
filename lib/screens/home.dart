import 'package:example_flutter1/const/color.dart';
import 'package:example_flutter1/widgets/logo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  final String fname;
  final String lname;
  HomeScreen({
    Key? key,
    required this.fname,
    required this.lname,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.red,
      body: Container(
        width: Get.width,
        padding: EdgeInsets.only(
          top: Get.mediaQuery.padding.top,
          bottom: Get.mediaQuery.padding.bottom,
        ),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(
                top: Get.height * 0.1,
              ),
              // column logo
              child: Logo(),
            ),
            Container(
              margin: EdgeInsets.only(
                top: Get.height * 0.1,
              ),
              child: Text(
                "สวัสดีคุณ$fname $lname",
                style: TextStyle(
                  color: Colors.yellow.shade700,
                  fontSize: 24,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

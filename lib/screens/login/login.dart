import 'package:example_flutter1/const/color.dart';
import 'package:example_flutter1/models/user_model.dart';
import 'package:example_flutter1/models/user_model2.dart';
import 'package:example_flutter1/screens/home.dart';
import 'package:example_flutter1/screens/login/login_controller.dart';
import 'package:example_flutter1/services/user_service.dart';
import 'package:example_flutter1/widgets/logo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum Language {
  th,
  en,
}

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  Language languageSelected = Language.th;

  @override
  Widget build(BuildContext pucontext) {
    var controller = Get.find<LoginController>();
    var controlle2 = Get.find<LoginController>();

    Get.putAsync(() async {
      var userService = UserService();
      await userService.getUser2();
      return userService;
    });

    print("controller 1 " + controller.hashCode.toString());
    print("controller 2 " + controlle2.hashCode.toString());

    return Scaffold(
      backgroundColor: AppColors.red,
      body: Container(
        padding: EdgeInsets.only(
          top: Get.mediaQuery.padding.top,
          bottom: Get.mediaQuery.padding.bottom,
        ),
        width: Get.width,
        // column screen
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // top widget
            Column(
              children: [
                Container(
                  child: GetBuilder<LoginController>(builder: (_) {
                    print("GetBuilder build title 1");
                    return Text(controller.title1);
                  }),
                ),
                Container(
                  child: GetBuilder<LoginController>(builder: (_) {
                    print("GetBuilder build title 2");
                    return Text(controller.title2);
                  }),
                ),
                Container(
                  child: GetX<LoginController>(builder: (_) {
                    print("GetX build title 3");
                    return Text(controller.title3.value);
                  }),
                ),
                Container(
                  child: Obx(() {
                    print("Obx build title 4");
                    return Text(controlle2.title4.value);
                  }),
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: Get.height * 0.1,
                  ),
                  // column logo
                  child: Logo(),
                ),
                Container(
                  width: Get.width * 0.8,
                  height: 44,
                  margin: EdgeInsets.only(
                    top: Get.height * 0.1,
                  ),
                  child: loginButton(),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 32),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // left widget - need help
                  needHelp(),
                  GestureDetector(
                    onTap: () {
                      Get.defaultDialog(
                        title: "เลือกภาษา",
                        content: Column(
                          children: [
                            languageMenu(
                              language: Language.th,
                              label: "ภาษาไทย",
                              languageSelected: languageSelected,
                            ),
                            languageMenu(
                              language: Language.en,
                              label: "ภาษาอังกฤษ",
                              languageSelected: languageSelected,
                            ),
                          ],
                        ),
                      );
                    },
                    child: Image.asset(
                      imagePathLanguage(languageSelected),
                      width: 24,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String imagePathLanguage(Language language) {
    return language == Language.th
        ? "assets/thai-flag.png"
        : "assets/eng-flag.png";
  }

  Widget languageMenu({
    required Language language,
    required String label,
    required Language languageSelected,
  }) {
    return ListTile(
      leading: Image.asset(
        imagePathLanguage(language),
        width: 24,
      ),
      title: Text(label),
      trailing: language == languageSelected
          ? Icon(Icons.check, color: AppColors.red)
          : null,
      onTap: () {
        setState(() {
          this.languageSelected = language;
        });
        Get.back();
      },
    );
  }

  Widget needHelp() {
    return Row(
      children: [
        Text(
          "ต้องการความช่วยเหลือ ",
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
        Text(
          "คลิก",
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  ElevatedButton loginButton() {
    return ElevatedButton(
      child: Text(
        "เข้าใช้งาน",
        style: TextStyle(
          color: AppColors.primary,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      style: ButtonStyle(
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
        ),
        backgroundColor: MaterialStateProperty.all(Colors.yellow.shade700),
      ),
      onPressed: () async {
        try {
          UserModel user = await UserService().getUser(); // call service
          UserModel2 user2 = await UserService().getUser2(); // call service

          Get.toNamed('/home', arguments: {
            "fname": user.fname,
            "lname": user.lname!,
            "email": user2.email,
          });
        } catch (error) {
          print("getUser: $error");
          // handle exception
        }
      },
    );
  }
}

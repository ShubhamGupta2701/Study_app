import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:study_app/configs/themes/app_colors.dart';
import 'package:study_app/controllers/question_paper_controller.dart';
import 'package:study_app/screens/home/home_screen.dart';
import 'package:study_app/services/firebase_storage_service.dart';
import 'package:study_app/widgets/app_circle_button.dart';
import 'package:get/get.dart';

class AppIntroductionScreen extends StatelessWidget {
  const AppIntroductionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: BoxDecoration(gradient: mainGradient()),
          alignment: Alignment.center,
          child: Padding(
              padding: EdgeInsets.symmetric(horizontal: Get.width * 0.2),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.star,
                    size: 65,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'This is a study app. You can use it for learning purpose. This app is made by Saurabh Mishra, this is my final year project of MCA from Thapar Institute of Engineering and Technology',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 18,
                        color: onSurfaceTextColor,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  AppCircleButton(
                      onTap: () => Get.offAndToNamed("/home"),
                      child: Icon(Icons.arrow_forward, size: 35))
                ],
              ))),
    );
  }
}

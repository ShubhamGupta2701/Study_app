import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:study_app/configs/themes/app_colors.dart';
import 'package:study_app/configs/themes/ui_parameters.dart';
import 'package:study_app/controllers/auth_controller.dart';
import 'package:study_app/controllers/zoom_drawer_controller.dart';
import 'package:study_app/main.dart';
import 'package:get/get.dart';
import 'package:study_app/services/theme_services.dart';

class MyMenuScreen extends GetView<MyZoomDrawerController> {
  const MyMenuScreen({Key? key}) : super(key: key);

  // get zoomDrawerController => Get.find<MyZoomDrawerController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: UIParameters.mobileScreenPadding,
      width: double.maxFinite,
      decoration: BoxDecoration(gradient: mainGradient()),
      child: Theme(
        data: ThemeData(
            textButtonTheme: TextButtonThemeData(
                style:
                    TextButton.styleFrom(foregroundColor: onSurfaceTextColor))),
        child: SafeArea(
            child: Stack(
          children: [
            Positioned(
                top: 0,
                right: 0,
                child: BackButton(
                  color: Colors.white,
                  // onPressed: () => zoomDrawerController.toogleDrawer(),
                  onPressed: () => controller.toogleDrawer(),
                )),
            Padding(
              padding: EdgeInsets.only(
                  right: MediaQuery.of(context).size.width * 0.2),
              child: Column(
                children: [
                  Obx(() => controller.user.value == null
                      ? SizedBox()
                      : Text(
                          controller.user.value!.displayName ?? '',
                          style: const TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 24,
                              color: onSurfaceTextColor),
                        )),
                  const Spacer(
                    flex: 2,
                  ),
                  _DrawerButton(
                    icon: Icons.ac_unit,
                    label: "Change Theme",
                    onPressed: () {
                      ThemeService().switchTheme();
                      Get.offAndToNamed("/introduction");
                    },
                  ),
                  _DrawerButton(
                    icon: Icons.book,
                    label: "Physics",
                    onPressed: () => controller.physics(),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: _DrawerButton(
                      icon: Icons.co2_outlined,
                      label: "Chemistry",
                      onPressed: () => controller.chemistry(),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: _DrawerButton(
                      icon: Icons.calculate,
                      label: "Math",
                      onPressed: () => controller.maths(),
                    ),
                  ),
                  _DrawerButton(
                    icon: Icons.book,
                    label: "Biology",
                    onPressed: () => controller.biology(),
                  ),
                  _DrawerButton(
                    icon: Icons.book,
                    label: "Python",
                    onPressed: () => controller.python(),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: _DrawerButton(
                      icon: Icons.code_sharp,
                      label: "C++",
                      onPressed: () => controller.cpp(),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: _DrawerButton(
                      icon: Icons.code,
                      label: "DSA",
                      onPressed: () => controller.dsa(),
                    ),
                  ),
                  _DrawerButton(
                    icon: Icons.book,
                    label: "Flutter",
                    onPressed: () => controller.flutter(),
                  ),
                  _DrawerButton(
                    icon: Icons.code,
                    label: "Code Practice",
                    onPressed: () => controller.code_practice(),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: _DrawerButton(
                      icon: Icons.email,
                      label: "Contact Us",
                      onPressed: () => controller.email(),
                    ),
                  ),
                  const Spacer(
                    flex: 4,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 100),
                    child: _DrawerButton(
                      icon: Get.find<AuthController>().isLoggedIn()
                          ? Icons.logout
                          : Icons.login,
                      label: Get.find<AuthController>().isLoggedIn()
                          ? "Log Out"
                          : "Log In",
                      onPressed: () => Get.find<AuthController>().isLoggedIn()
                          ? controller.signOut()
                          : Get.find<AuthController>().NavigateToLoginPage(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        )),
      ),
    );
  }
}

class _DrawerButton extends StatelessWidget {
  const _DrawerButton(
      {Key? key, required this.icon, required this.label, this.onPressed})
      : super(key: key);

  final IconData icon;
  final String label;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: 15),
      label: Text(label),
    );
  }
}

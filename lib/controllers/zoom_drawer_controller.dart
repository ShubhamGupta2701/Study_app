import 'package:flutter_zoom_drawer/config.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:study_app/controllers/auth_controller.dart';
// import 'package:study_app/controllers/theme_controller.dart';
import 'package:study_app/screens/login/login_screen.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MyZoomDrawerController extends GetxController {
  final zoomDrawerController = ZoomDrawerController();
  
  Rxn<User?> user = Rxn();
  @override
  void onReady() {
    user.value = Get.find<AuthController>().getUser();
    super.onReady();
  }

  void toogleDrawer() {
    zoomDrawerController.toggle?.call();
    update();
  }

  void signOut() {
    Get.find<AuthController>().signOut();
  }

  void singIn() {
    // Get.find(tag: "login");
  }

  void physics() {
    _launch(
        "https://www.geeksforgeeks.org/what-is-physics-definition-history-importance-scope/");
  }

  void chemistry() {
    _launch(
        "https://www.javatpoint.com/chemistry");
  }

  void maths() {
    _launch("https://www.geeksforgeeks.org/probability-in-maths/?ref=gcse");
  }

  void biology() {
    _launch(
        "https://www.geeksforgeeks.org/difference-between-biology-and-microbiology/?ref=gcse");
  }

  void python() {
    _launch(
        "https://www.geeksforgeeks.org/python-programming-language/?ref=shm");
  }

  void cpp() {
    _launch("https://www.geeksforgeeks.org/c-plus-plus/");
  }

  void dsa() {
    _launch(
        "https://www.geeksforgeeks.org/learn-data-structures-and-algorithms-dsa-tutorial/?ref=shm");
  }

  void flutter() {
    _launch("https://www.tutorialspoint.com/flutter/index.htm");
  }

  void code_practice() {
    _launch("https://www.tutorialspoint.com/codingground.htm");
  }

  void email() {
    final Uri emailLaunchUri =
        Uri(scheme: 'mailto', path: 'rriya_mca22@thapar.edu');
    _launch(emailLaunchUri.toString());
  }

  Future<void> _launch(String url) async {
    if (!await launch(url)) {
      throw 'could not launch $url';
    }
  }
}

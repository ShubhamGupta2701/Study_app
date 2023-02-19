import 'package:flutter_zoom_drawer/config.dart';
import 'package:study_app/controllers/auth_controller.dart';
import 'package:study_app/controllers/theme_controller.dart';
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

  void singIn() {}

  void website() {
    _launch("https://www.github.com");
  }

  void facebook() {
    _launch("https://www.facebook.com");
  }

  void email() {
    final Uri emailLaunchUri =
        Uri(scheme: 'mailto', path: 'sgupta_mca21@thapar.edu');
    _launch(emailLaunchUri.toString());
  }

  Future<void> _launch(String url) async {
    if (!await launch(url)) {
      throw 'could not launch $url';
    }
  }
}

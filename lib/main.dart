import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:study_app/bindings/initial_bindings.dart';
import 'package:study_app/controllers/theme_controller.dart';
import 'package:get/get.dart';
import 'package:study_app/firebase_options.dart';
import 'package:study_app/routes/app_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  InitialBindings().dependencies();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Get.find<ThemeController>().lightTheme,
      getPages: AppRoutes.routes(),
    );
  }
}

/*Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
  ;
  runApp(GetMaterialApp(home: DataUploaderScreen()));
}*/

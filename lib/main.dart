import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:study_app/bindings/initial_bindings.dart';
import 'package:study_app/configs/themes/theme.dart';
import 'package:get/get.dart';
import 'package:study_app/firebase_options.dart';
import 'package:study_app/routes/app_routes.dart';
import 'package:study_app/services/theme_services.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  InitialBindings().dependencies();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);// initialize firebase to our application on current platform 
  await GetStorage.init();
  runApp(RiyaApp());
}

class RiyaApp extends StatelessWidget {
  const RiyaApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Themes.light,
      darkTheme: Themes.dark,
      themeMode: ThemeService().theme,
      getPages: AppRoutes.routes(),
    ); 
  }
}

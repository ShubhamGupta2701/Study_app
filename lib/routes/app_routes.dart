import 'package:study_app/controllers/question_paper_controller.dart';
import 'package:study_app/controllers/quiz_question/question_controller.dart';
import 'package:study_app/controllers/zoom_drawer_controller.dart';
import 'package:study_app/screens/home/home_screen.dart';
import 'package:study_app/screens/introduction/introduction.dart';
import 'package:study_app/screens/login/login_screen.dart';
import 'package:study_app/screens/question/answer_check_screen.dart';
import 'package:study_app/screens/question/question_screen.dart';
import 'package:study_app/screens/question/result_screen.dart';
import 'package:study_app/screens/question/test_overview_screen.dart';
import 'package:study_app/screens/splash/splash_screen.dart';
import 'package:get/get.dart';

class AppRoutes {
  static List<GetPage> routes() => [
        GetPage(name: "/", page: () => const SplashScreen()),
        GetPage(
            name: "/introduction", page: () => const AppIntroductionScreen()),
        GetPage(
            name: "/home",
            page: () => const HomeScreen(),
            binding: BindingsBuilder(() {
              Get.put(QuestionPaperController());
              Get.put(MyZoomDrawerController());
            })),
        GetPage(name: LoginScreen.routeName, page: () => LoginScreen()),
        GetPage(
            name: QuestionScreen.routeName,
            page: () => const QuestionScreen(),
            binding: BindingsBuilder(() {
              Get.put<QuestionController>(QuestionController());
            })),
        GetPage(
          name: TestOverviewScreen.routeName,
          page: () => const TestOverviewScreen(),
        ),
        GetPage(
          name: ResultScreen.routeName,
          page: () => const ResultScreen(),
        ),
        GetPage(
          name: AnswerCheckScreen.routeName,
          page: () => const AnswerCheckScreen(),
        )
      ];
}

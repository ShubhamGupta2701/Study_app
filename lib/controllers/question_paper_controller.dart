import 'package:get/get.dart';
import 'package:study_app/controllers/AppLogger.dart';
import 'package:study_app/controllers/auth_controller.dart';
import 'package:study_app/firebase_ref/references.dart';
import 'package:study_app/model/question_paper_model.dart';
import 'package:study_app/screens/question/learn_topic.dart';
import 'package:study_app/screens/question/question_screen.dart';
import 'package:study_app/services/firebase_storage_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class QuestionPaperController extends GetxController {
  final allPaperImages = <String>[].obs;
  final allPapers = <QuestionPaperModel>[].obs;

  @override
  void onReady() {
    getAllPapers();
    super.onReady();
  }

  Future<void> getAllPapers() async {
    List<String> imgName = ["flutter"];
    try {
      QuerySnapshot<Map<String, dynamic>> data = await questionPaperRF.get();
      final paperList = data.docs
          .map((paper) => QuestionPaperModel.fromSnapshot(paper))
          .toList();
      allPapers.assignAll(paperList);

      for (var paper in paperList) {
        final imgUrl =
            await Get.find<FirebaseStorageService>().getImage(paper.title);
        paper.imageUrl = imgUrl!;
        allPaperImages.add(imgUrl);
      }
      allPapers.assignAll(paperList);
    } catch (e) {
      AppLogger.e(e);
    }
  }

  void navigateToQuestions(
      {required QuestionPaperModel paper, bool tryAgain = false}) {
    AuthController _authController = Get.find();
    if (_authController.isLoggedIn()) {
      if (tryAgain) {
        Get.back();
        Get.toNamed(QuestionScreen.routeName,
            arguments: paper, preventDuplicates: false);
        // Get.offNamed();
      } else {
        // print("Already Logged In......!");
        Get.toNamed(QuestionScreen.routeName, arguments: paper);
      }
    } else {
      // print('The title is : ${paper.title}');
      _authController.showLoginAlertDialogue();
    }
  }
}

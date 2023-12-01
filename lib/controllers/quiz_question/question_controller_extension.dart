import 'package:study_app/controllers/auth_controller.dart';
import 'package:study_app/controllers/quiz_question/question_controller.dart';
import 'package:study_app/firebase_ref/references.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

extension QuestionControllerExtension on QuestionController {
  int get correctQuestionCount => allQuestions
      .where((element) => element.selectedAnswer == element.correctAnswer)
      .toList()
      .length;

  String get correctAnsweredQuestion {
    return '$correctQuestionCount out of ${allQuestions.length} are correct';
  }

  String get points {
    var points = (correctQuestionCount / allQuestions.length) *
        100 *
        (questionPaperModel.timeSeconds - remainingSeconds) /
        questionPaperModel.timeSeconds *
        100;
    return points.toStringAsFixed(2);
  }

  // Future<void> saveTestResults() async {
  //   var batch = fireStore.batch();
  //   User? _user = Get.find<AuthController>().getUser();
  //   if (_user == null) {
  //     return;
  //   }
  //   batch.set(
  //       userRF
  //           .doc(_user.email)
  //           .collection('myrecent_tests')
  //           .doc(questionPaperModel.id),
  //       {
  //         "Data-Time": DateTime.now(),
  //         "points": points,
  //         "correct_answer": '$correctQuestionCount/${allQuestions.length}',
  //         "question_id": questionPaperModel.id,
  //         "time": questionPaperModel.timeSeconds - remainingSeconds,
  //       });
  //   batch.commit();
  //   navigateToHomePage();
  // }

  Future<void> saveTestResults() async {
    var batch = fireStore.batch();
    User? _user = Get.find<AuthController>().getUser();
    if (_user == null) {
      return;
    }

    // Create a new document in the "myrecent_tests" subcollection for this test result
    var testResultDocRef = userRF
        .doc(_user.email)
        .collection('myrecent_tests')
        .doc(questionPaperModel.id)
        .collection('results')
        .doc();
        
        
    // Set the data for this test result
    batch.set(testResultDocRef, {
      "data-time": DateTime.now(),
      "points": points,
      "correct_answer": '$correctQuestionCount/${allQuestions.length}',
      "question_id": questionPaperModel.id,
      "time": questionPaperModel.timeSeconds - remainingSeconds,
    });

    // Commit the batch write to save the test result
    await batch.commit();

    navigateToHomePage();
  }
}

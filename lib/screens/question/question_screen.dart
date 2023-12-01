import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:study_app/configs/themes/app_colors.dart';
import 'package:study_app/configs/themes/custom_text_styles.dart';
import 'package:study_app/configs/themes/ui_parameters.dart';
import 'package:study_app/controllers/quiz_question/question_controller.dart';
import 'package:study_app/firebase_ref/loading_status.dart';
import 'package:study_app/screens/question/test_overview_screen.dart';
import 'package:study_app/widgets/common/background_decoration.dart';
import 'package:get/get.dart';
import 'package:study_app/widgets/common/custom_appbar.dart';
import 'package:study_app/widgets/common/main_button.dart';
import 'package:study_app/widgets/common/question_screen_holder.dart';
import 'package:study_app/widgets/content_area.dart';
import 'package:study_app/widgets/questions/answer_card.dart';
import 'package:study_app/widgets/questions/countdown_timer.dart';

class QuestionScreen extends GetView<QuestionController> {
  const QuestionScreen({Key? key}) : super(key: key);
  static const String routeName = "/questionscreen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: CustomAppBar(
            leading: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: const ShapeDecoration(
                  shape: StadiumBorder(
                      side: BorderSide(color: onSurfaceTextColor, width: 2))),
              child: Obx(() => CountDownTimer(
                    time: controller.time.value,
                    color: onSurfaceTextColor,
                  )),
            ),
            showActionIcon: true,
            titleWidget: Obx(
              () => Text(
                'Q. ${(controller.questionIndex.value + 1).toString().padLeft(2, '0')}',
                style: appBarTS,
              ),
            )),
        body: BackGroundDecoration(
          child: Obx(() => Column(
                children: [
                  if (controller.loadingStatus.value == LoadingStatus.loading)
                    const Expanded(
                        child: ContentArea(child: QuestionScreenHolder())),
                  if (controller.loadingStatus.value == LoadingStatus.completed)
                    Expanded(
                        child: ContentArea(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.only(top: 25),
                        child: Column(
                          children: [
                            Text(
                              controller.currentQuestion.value!.question,
                              style: questionTS,
                            ),
                            GetBuilder<QuestionController>(
                                id: 'answers_list',
                                builder: (context) {
                                  return ListView.separated(
                                    shrinkWrap: true,
                                    padding: const EdgeInsets.only(top: 25),
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      final answer = controller.currentQuestion
                                          .value!.answers[index];
                                      return AnswerCard(
                                        answer:
                                            '${answer.identifier}.${answer.answer}',
                                        onTap: () {
                                          controller.selectedAnswer(
                                              answer.identifier);
                                        },
                                        isSelected: answer.identifier ==
                                            controller.currentQuestion.value!
                                                .selectedAnswer,
                                      );
                                    },
                                    separatorBuilder:
                                        (BuildContext context, int index) =>
                                            const SizedBox(
                                      height: 10,
                                    ),
                                    itemCount: controller
                                        .currentQuestion.value!.answers.length,
                                  );
                                }),
                          ],
                        ),
                      ),
                    )),
                  ColoredBox(
                    color: Colors.transparent,
                    child: Padding(
                      padding: UIParameters.mobileScreenPadding,
                      child: Row(
                        children: [
                          Visibility(
                            visible: controller.isFirstQuestion,
                            child: SizedBox(
                              width: 55,
                              height: 55,
                              child: MainButton(
                                onTap: () {
                                  controller.prevQuestion();
                                },
                                child: Icon(
                                  Icons.arrow_back_ios_new,
                                  color: Get.isDarkMode
                                      ? onSurfaceTextColor
                                      : Theme.of(context)
                                          .primaryColor
                                          .withOpacity(1),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Visibility(
                                visible: controller.loadingStatus.value ==
                                    LoadingStatus.completed,
                                child: MainButton(
                                  onTap: () {
                                    controller.islastQuestion
                                        ? Get.toNamed(
                                            TestOverviewScreen.routeName)
                                        : controller.nextQuestion();
                                  },
                                  title: controller.islastQuestion
                                      ? 'Submit'
                                      : 'Next',
                                )),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )),
        ));
  }
}

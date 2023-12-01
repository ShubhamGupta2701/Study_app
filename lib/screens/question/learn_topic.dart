import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:study_app/configs/themes/custom_text_styles.dart';
import 'package:study_app/configs/themes/ui_parameters.dart';
import 'package:study_app/controllers/question_paper_controller.dart';
import 'package:study_app/controllers/quiz_question/question_controller.dart';
import 'package:study_app/firebase_ref/loading_status.dart';
import 'package:study_app/widgets/common/background_decoration.dart';
import 'package:study_app/widgets/common/custom_appbar.dart';
import 'package:study_app/widgets/content_area.dart';

import '../../widgets/common/question_screen_holder.dart';

class LearnTopic extends GetView<QuestionPaperController> {
  const LearnTopic({Key? key}) : super(key: key);
  static const String routeName = "/learntopic";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(
        titleWidget: Obx(
          () => Text(
            'Learn Here',
            style: appBarTS,
          ),
        ),
      ),
      body: BackGroundDecoration(
          child: Column(
        children: [
          ColoredBox(
            color: Theme.of(context).scaffoldBackgroundColor,
            child: Padding(
              padding: UIParameters.mobileScreenPadding,
              child: Row(
                children: [],
              ),
            ),
          ),
        ],
      )),
    );
  }
}

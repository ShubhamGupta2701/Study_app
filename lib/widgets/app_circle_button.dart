import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:study_app/controllers/question_paper_controller.dart';
import 'package:study_app/screens/home/home_screen.dart';

class AppCircleButton extends StatelessWidget {
  final Widget child;
  final Color? color;
  final double width;
  final VoidCallback? onTap;
  const AppCircleButton(
      {Key? key, required this.child, this.color, this.onTap, this.width = 60})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
        type: MaterialType.transparency,
        clipBehavior: Clip.hardEdge,
        // shape: const CircleBorder(),
        child: InkWell(onTap: onTap, child: child));
  }
}

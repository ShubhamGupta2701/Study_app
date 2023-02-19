import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:study_app/configs/themes/app_colors.dart';
import 'package:study_app/configs/themes/ui_parameters.dart';

class ContentArea extends StatelessWidget {
  final bool addpadding;
  final Widget child;
  const ContentArea({Key? key, required this.child, this.addpadding = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      clipBehavior: Clip.hardEdge,
      type: MaterialType.transparency,
      child: Ink(
        decoration: BoxDecoration(color: customScaffoldColor(context)),
        padding: addpadding
            ? EdgeInsets.only(
                top: mobileScreenPadding,
                left: mobileScreenPadding,
                right: mobileScreenPadding)
            : EdgeInsets.zero,
        child: child,
      ),
    );
  }
}

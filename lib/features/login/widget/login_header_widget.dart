import 'package:enjaz/app_config/image_name.dart';
import 'package:enjaz/components/custom_app_bar_widget.dart';
import 'package:enjaz/components/my_text.dart';
import 'package:enjaz/helpers/styles.dart';
import 'package:enjaz/helpers/translation/localization_methods.dart';
import 'package:flutter/material.dart';

class LoginHeaderWidget extends StatelessWidget {
  const LoginHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const CustomAppBarWidget(imageSvg: ImageName.loginSvg, canPop: false),
        const SizedBox(height: 10),
        MyText(
          title: tr("login"),
          size: 19,
          color: Styles.whiteColor,
        ),
        const SizedBox(height: 10),
        MyText(
          title: tr("loginDes"),
          size: 18,
          color: Styles.whiteColor.withOpacity(0.6),
        ),
      ],
    );
  }
}

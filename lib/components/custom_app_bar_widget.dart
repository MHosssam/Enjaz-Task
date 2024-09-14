import 'package:enjaz/helpers/styles.dart';
import 'package:enjaz/navigation/custom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomAppBarWidget extends StatelessWidget {
  final bool? canPop;
  final String imageSvg;
  const CustomAppBarWidget({super.key, this.canPop = true, required this.imageSvg});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (canPop == true)
          Padding(
            padding: const EdgeInsetsDirectional.only(start: 15),
            child: GestureDetector(
              onTap: () => CustomNavigator.pop(),
              child: const Icon(Icons.arrow_back_ios, color: Styles.whiteColor, size: 25),
            ),
          ),
        Expanded(child: Center(child: SvgPicture.asset(imageSvg))),
        if (canPop == true) const SizedBox(width: 40),
      ],
    );
  }
}

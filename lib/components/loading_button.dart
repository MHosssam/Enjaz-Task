import 'package:enjaz/helpers/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'custom_button_animated.dart';

class LoadingButton extends StatelessWidget {
  final GlobalKey<CustomButtonState> btnKey;
  final String title;
  final Function() onTap;
  final Color? textColor;
  final Color? loadingColor;
  final Color? color;
  final Color? borderColor;
  final double? borderRadius;
  final EdgeInsets? margin;
  final double? width;
  final double? height;
  final double? fontSize;
  final String? fontFamily;
  final FontWeight? fontWeight;

  const LoadingButton({
    super.key,
    required this.title,
    required this.onTap,
    this.color,
    this.textColor,
    this.loadingColor,
    this.borderRadius,
    this.margin,
    this.borderColor,
    this.fontFamily,
    this.fontSize,
    this.width,
    this.height,
    this.fontWeight,
    required this.btnKey,
  });

  @override
  Widget build(BuildContext context) {
    Color border = color ?? Styles.greenColor;
    return Container(
      margin: margin ?? EdgeInsets.zero,
      child: CustomButtonAnimation(
        key: btnKey,
        onTap: onTap,
        width: width ?? MediaQuery.of(context).size.width,
        minWidth: 60,
        height: height ?? 45,
        color: color ?? Styles.greenColor,
        borderRadius: borderRadius ?? 50,
        borderSide: BorderSide(color: borderColor ?? border, width: 1),
        loader: Container(
          padding: const EdgeInsets.all(10),
          child: SpinKitFoldingCube(color: loadingColor ?? Styles.whiteColor, size: 20),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: textColor ?? Colors.white,
            fontSize: fontSize ?? 16,
            fontWeight: fontWeight ?? FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

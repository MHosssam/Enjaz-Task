import 'package:enjaz/components/my_text.dart';
import 'package:enjaz/helpers/styles.dart';
import 'package:flutter/material.dart';

class DefaultButton extends StatelessWidget {
  final String title;
  final Function()? onTap;
  final Color? textColor;
  final Color? color;
  final Color? borderColor;
  final BorderRadius? borderRadius;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final double? width;
  final double? fontSize;
  final double? height;
  final double? elevation;
  final bool? disabled;
  final String? fontFamily;
  final FontWeight? fontWeight;

  const DefaultButton({
    super.key,
    required this.title,
    this.onTap,
    this.color,
    this.disabled,
    this.textColor,
    this.borderRadius,
    this.margin,
    this.padding,
    this.borderColor,
    this.fontFamily,
    this.fontSize,
    this.width,
    this.height,
    this.fontWeight,
    this.elevation,
  });

  @override
  Widget build(BuildContext context) {
    Color border = color ?? Styles.greenColor;
    return IgnorePointer(
      ignoring: disabled ?? false,
      child: Container(
        width: width ?? MediaQuery.of(context).size.width,
        height: height ?? 45,
        margin: margin ?? EdgeInsets.zero,
        decoration: BoxDecoration(
          color: color ?? Styles.greenColor,
          borderRadius: borderRadius ?? BorderRadius.circular(50),
        ),
        child: ElevatedButton(
          onPressed: onTap,
          style: ElevatedButton.styleFrom(
            backgroundColor: color ?? Styles.greenColor,
            padding: padding ?? EdgeInsets.zero,
            shape: RoundedRectangleBorder(
              borderRadius: borderRadius ?? BorderRadius.circular(50),
              side: BorderSide(color: borderColor ?? border, width: 1),
            ),
            elevation: elevation ?? 0,
          ),
          child: MyText(
            title: title,
            color: textColor ?? Styles.whiteColor,
            size: fontSize ?? 14,
            fontFamily: fontFamily,
            fontWeight: fontWeight ?? FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

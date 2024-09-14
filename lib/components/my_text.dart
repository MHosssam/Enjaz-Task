import 'package:enjaz/helpers/styles.dart';
import 'package:flutter/material.dart';

class MyText extends StatelessWidget {
  final String title;
  final Color? color;
  final double? size;
  final double? letterSpace;
  final double? wordSpace;
  final String? fontFamily;
  final TextAlign? alien;
  final TextDecoration? decoration;
  final TextOverflow? overflow;
  final FontWeight? fontWeight;
  final int? maxLines;
  final double? textScaleFactor;
  final TextDirection? textDirection;

  const MyText(
      {super.key,
      required this.title,
      this.color,
      this.size,
      this.alien,
      this.fontFamily,
      this.decoration,
      this.letterSpace,
      this.wordSpace,
      this.overflow,
      this.maxLines,
      this.fontWeight,
      this.textDirection,
      this.textScaleFactor});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textAlign: alien ?? TextAlign.justify,
      textScaler: TextScaler.linear(textScaleFactor ?? 1),
      textDirection: textDirection,
      style: TextStyle(
        color: color ?? Styles.blackColor,
        fontSize: size ?? 16,
        letterSpacing: letterSpace,
        wordSpacing: wordSpace,
        decoration: decoration ?? TextDecoration.none,
        decorationColor: color ?? Styles.blackColor,
        fontWeight: fontWeight ?? FontWeight.normal,
        fontFamily: fontFamily ?? "IBMPlexSansArabic",
      ),
      overflow: overflow,
      maxLines: maxLines,
      textWidthBasis: TextWidthBasis.longestLine,
    );
  }
}

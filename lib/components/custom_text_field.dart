import 'package:enjaz/components/my_text.dart';
import 'package:enjaz/helpers/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String? label;
  final String? hint;
  final bool autoFocus;
  final int? max;
  final EdgeInsets? margin;
  final EdgeInsets? contentPadding;
  final TextInputType type;
  final TextInputAction action;
  final BorderRadius? radius;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Widget? prefixWidget;
  final Widget? suffixWidget;
  final GestureTapCallback? onTap;
  final Color? borderColor;
  final Color? focusColor;
  final Color? fillColor;
  final Color? hintColor;
  final Color? textColor;
  final int? maxLength;
  final Function(String? value) validate;
  final FieldTypes fieldTypes;
  final Function()? onSubmit;
  final Function(String)? onChange;
  final List<TextInputFormatter>? inputFormatters;
  final AutovalidateMode? autoValidateMode;
  final String? fontFamily;
  final TextDirection? textDirection;
  final String title;
  final String iconPath;

  const CustomTextField({
    super.key,
    this.label,
    this.hint,
    required this.fieldTypes,
    this.controller,
    this.focusNode,
    this.margin,
    this.autoFocus = false,
    this.contentPadding,
    this.inputFormatters,
    required this.type,
    this.onTap,
    this.radius,
    this.max,
    this.maxLength,
    this.suffixWidget,
    this.prefixWidget,
    this.textColor,
    this.fillColor,
    this.hintColor,
    this.prefixIcon,
    this.suffixIcon,
    this.onChange,
    this.textDirection,
    this.fontFamily,
    this.autoValidateMode,
    this.onSubmit,
    required this.action,
    this.borderColor,
    this.focusColor,
    required this.validate,
    required this.iconPath,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? const EdgeInsets.all(1),
      child: Visibility(
        visible: fieldTypes == FieldTypes.clickable,
        replacement: buildFormFiled(context),
        child: buildClickableView(context),
      ),
    );
  }

  Widget buildClickableView(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AbsorbPointer(
        absorbing: true,
        child: buildFormFiled(context),
      ),
    );
  }

  Widget buildFormFiled(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MyText(title: title, color: Styles.blackColor, fontWeight: FontWeight.bold),
        const SizedBox(height: 5),
        Row(
          children: [
            Container(
              height: 50,
              width: 50,
              alignment: Alignment.center,
              clipBehavior: Clip.antiAlias,
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Styles.whiteColor,
                border: Border.all(color: Styles.greyColor.withOpacity(0.5), width: 1),
              ),
              child: SvgPicture.asset(
                iconPath,
                colorFilter: const ColorFilter.mode(Styles.greyColor, BlendMode.srcIn),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: TextFormField(
                onTapOutside: (v) => FocusScope.of(context).requestFocus(FocusNode()),
                controller: controller,
                keyboardType: type,
                textInputAction: action,
                enableSuggestions: false,
                autocorrect: false,
                autofocus: autoFocus,
                focusNode: focusNode,
                textDirection: textDirection,
                autovalidateMode: autoValidateMode ?? AutovalidateMode.onUserInteraction,
                inputFormatters: inputFormatters ??
                    [
                      if (maxLength != null) LengthLimitingTextInputFormatter(maxLength),
                    ],
                enabled: fieldTypes != FieldTypes.disable,
                autofillHints: getAutoFillHints(type),
                maxLines: fieldTypes == FieldTypes.chat
                    ? null
                    : (fieldTypes == FieldTypes.rich ||
                            fieldTypes == FieldTypes.disable ||
                            fieldTypes == FieldTypes.readonly)
                        ? max
                        : 1,
                obscureText: fieldTypes == FieldTypes.password,
                readOnly: fieldTypes == FieldTypes.readonly,
                onEditingComplete: onSubmit,
                onChanged: onChange,
                validator: (value) => validate(value),
                style: TextStyle(
                  color: textColor ?? Styles.blackColor,
                  fontSize: 13,
                  fontFamily: fontFamily,
                ),
                decoration: InputDecoration(
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: radius ?? BorderRadius.circular(50),
                    borderSide: const BorderSide(color: Styles.redColor, width: 1),
                  ),
                  focusColor: focusColor ?? Styles.whiteColor,
                  errorBorder: OutlineInputBorder(
                    borderRadius: radius ?? BorderRadius.circular(50),
                    borderSide: BorderSide(color: borderColor ?? Styles.redColor, width: 1),
                  ),
                  labelText: label,
                  hintText: hint,
                  hintStyle: TextStyle(color: hintColor ?? Colors.grey, fontSize: 14),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: radius ?? BorderRadius.circular(50),
                    borderSide: BorderSide(
                      color: focusColor ?? Styles.greyColor,
                      width: 1,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: radius ?? BorderRadius.circular(50),
                    borderSide: BorderSide(
                      color: borderColor ?? Styles.greyColor,
                      width: 1,
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: radius ?? BorderRadius.circular(50),
                    borderSide: BorderSide(
                      color: borderColor ?? Styles.greyColor,
                      width: 1,
                    ),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderRadius: radius ?? BorderRadius.circular(50),
                    borderSide: BorderSide(
                      color: borderColor ?? Styles.greyColor,
                      width: 1,
                    ),
                  ),
                  filled: true,
                  enabled: fieldTypes != FieldTypes.disable,
                  prefixIcon: prefixIcon,
                  suffixIcon: suffixIcon,
                  fillColor: fillColor ?? Styles.whiteColor,
                  contentPadding: contentPadding ?? const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                  prefix: prefixWidget,
                  prefixIconConstraints: const BoxConstraints(minWidth: 18, minHeight: 18),
                  suffix: suffixWidget,
                  errorMaxLines: 3,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  List<String> getAutoFillHints(TextInputType inputType) {
    if (inputType == TextInputType.emailAddress) {
      return [AutofillHints.email];
    } else if (inputType == TextInputType.datetime) {
      return [AutofillHints.birthday];
    } else if (inputType == TextInputType.phone) {
      return [AutofillHints.telephoneNumber];
    } else if (inputType == TextInputType.url) {
      return [AutofillHints.url];
    }
    return [AutofillHints.name, AutofillHints.username];
  }
}

enum FieldTypes { normal, clickable, readonly, chat, password, rich, disable }

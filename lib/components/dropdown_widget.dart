import 'package:enjaz/components/my_text.dart';
import 'package:enjaz/helpers/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DropDownWidget<T> extends StatelessWidget {
  final String hintText;
  final String title;
  final String iconPath;
  final IconData? prefixIcon;
  final List<DropdownMenuItem<T>> items;
  final String? Function(T?)? validator;
  final T? value;
  final void Function(T?)? onChanged;

  const DropDownWidget({
    super.key,
    required this.hintText,
    this.prefixIcon,
    required this.items,
    this.validator,
    this.value,
    this.onChanged,
    required this.title,
    required this.iconPath,
  });

  @override
  Widget build(BuildContext context) {
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
              child: Theme(
                data: Theme.of(context).copyWith(
                  splashFactory: NoSplash.splashFactory,
                  highlightColor: Colors.transparent,
                  focusColor: Colors.transparent,
                ),
                child: SizedBox(
                  height: 50,
                  child: DropdownButtonFormField<T>(
                    items: items,
                    value: value,
                    validator: validator,
                    onChanged: onChanged,
                    icon: const SizedBox.shrink(),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    style: const TextStyle(color: Styles.blackColor, fontSize: 14),
                    decoration: InputDecoration(
                      hintText: hintText,
                      hintStyle: const TextStyle(color: Styles.greyColor, fontSize: 14),
                      contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        borderSide: const BorderSide(color: Styles.greyColor, width: 1),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        borderSide: const BorderSide(color: Styles.greyColor, width: 1),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        borderSide: const BorderSide(color: Styles.greyColor, width: 1),
                      ),
                      disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        borderSide: const BorderSide(color: Styles.greyColor, width: 1),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        borderSide: const BorderSide(color: Styles.greyColor, width: 1),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        borderSide: const BorderSide(color: Styles.redColor, width: 1),
                      ),
                      prefixIcon: prefixIcon != null
                          ? SizedBox(
                              height: 50,
                              width: 50,
                              child: Icon(prefixIcon, size: 30, color: Styles.greyColor),
                            )
                          : null,
                      suffixIcon: const SizedBox(
                        width: 50,
                        height: 50,
                        child: Icon(Icons.keyboard_arrow_down, size: 30, color: Styles.greyColor),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

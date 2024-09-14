import 'package:enjaz/app_config/image_name.dart';
import 'package:enjaz/components/custom_text_field.dart';
import 'package:enjaz/components/default_button.dart';
import 'package:enjaz/components/loading_button.dart';
import 'package:enjaz/components/my_text.dart';
import 'package:enjaz/core/validations.dart';
import 'package:enjaz/features/login/bloc/login_bloc.dart';
import 'package:enjaz/helpers/styles.dart';
import 'package:enjaz/helpers/translation/localization_methods.dart';
import 'package:enjaz/navigation/custom_navigation.dart';
import 'package:enjaz/navigation/routes.dart';
import 'package:flutter/material.dart';

class LoginFormWidget extends StatelessWidget {
  const LoginFormWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Styles.whiteColor,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Form(
        key: LoginBloc().formKey,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          physics: const BouncingScrollPhysics(),
          children: [
            CustomTextField(
              title: tr("phoneNumber"),
              hint: tr("enterPhoneNumber"),
              iconPath: ImageName.phoneSvg,
              type: TextInputType.phone,
              action: TextInputAction.next,
              fieldTypes: FieldTypes.normal,
              controller: LoginBloc().phoneController,
              validate: (value) => value?.validatePhone(),
            ),
            const SizedBox(height: 30),
            ValueListenableBuilder<bool>(
              valueListenable: LoginBloc().showPassword,
              builder: (context, value, child) => CustomTextField(
                title: tr("password"),
                hint: tr("enterPassword"),
                iconPath: ImageName.lockSvg,
                action: TextInputAction.next,
                type: TextInputType.visiblePassword,
                controller: LoginBloc().passwordController,
                validate: (value) => value?.validatePassword(),
                fieldTypes: value == true ? FieldTypes.normal : FieldTypes.password,
                suffixIcon: GestureDetector(
                  onTap: () => LoginBloc().showPassword.value = !value,
                  child: Icon(
                    value == true ? Icons.visibility : Icons.visibility_off,
                    color: Styles.greyColor,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
            Row(
              children: [
                ValueListenableBuilder<bool>(
                  valueListenable: LoginBloc().termsAccepted,
                  builder: (context, value, child) => GestureDetector(
                    onTap: () => LoginBloc().termsAccepted.value = !value,
                    child: Icon(
                      value == true ? Icons.check_circle : Icons.circle_outlined,
                      color: value == true ? Styles.greenColor : Styles.greyColor,
                    ),
                  ),
                ),
                const SizedBox(width: 5),
                MyText(title: tr("agreeTo"), color: Styles.greyColor,size: 15),
                const SizedBox(width: 5),
                MyText(
                  title: tr("termsAndConditions"),
                  size: 15,
                  color: Styles.blackColor,
                  decoration: TextDecoration.underline,
                ),
              ],
            ),
            const SizedBox(height: 40),
            LoadingButton(
              title: tr("login"),
              btnKey: LoginBloc().btnKey,
              onTap: () => LoginBloc().loginFunction(),
            ),
            const SizedBox(height: 20),
            DefaultButton(
              title: tr("forgetPassword"),
              textColor: Styles.greyColor,
              color: Styles.whiteColor.withOpacity(0.5),
            ),
            const SizedBox(height: 80),
            GestureDetector(
              onTap: () => CustomNavigator.push(Routes.register),
              child: MyText(
                title: " ${tr("createNewAccount")} ؟ ",
                alien: TextAlign.center,
                color: Styles.primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

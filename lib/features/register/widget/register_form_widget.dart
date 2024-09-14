import 'package:enjaz/app_config/image_name.dart';
import 'package:enjaz/components/custom_text_field.dart';
import 'package:enjaz/components/default_button.dart';
import 'package:enjaz/components/dropdown_widget.dart';
import 'package:enjaz/components/loading_button.dart';
import 'package:enjaz/components/my_text.dart';
import 'package:enjaz/features/register/bloc/register_bloc.dart';
import 'package:enjaz/helpers/styles.dart';
import 'package:enjaz/core/validations.dart';
import 'package:enjaz/helpers/translation/localization_methods.dart';
import 'package:enjaz/main_blocs/generic_cubit/generic_cubit.dart';
import 'package:enjaz/main_models/city_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterFormWidget extends StatelessWidget {
  const RegisterFormWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Styles.whiteColor,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Form(
        key: RegisterBloc().formKey,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          physics: const BouncingScrollPhysics(),
          children: [
            CustomTextField(
              title: tr("name"),
              hint: tr("enterName"),
              iconPath: ImageName.userSvg,
              type: TextInputType.text,
              action: TextInputAction.next,
              fieldTypes: FieldTypes.normal,
              controller: RegisterBloc().nameController,
              validate: (value) => value?.validateEmpty(),
            ),
            const SizedBox(height: 20),
            CustomTextField(
              title: tr("phoneNumber"),
              hint: tr("enterPhoneNumber"),
              iconPath: ImageName.phoneSvg,
              type: TextInputType.phone,
              action: TextInputAction.next,
              fieldTypes: FieldTypes.normal,
              controller: RegisterBloc().phoneController,
              validate: (value) => value?.validatePhone(),
            ),
            const SizedBox(height: 20),
            CustomTextField(
              title: tr("email"),
              hint: tr("enterEmail"),
              iconPath: ImageName.emailSvg,
              action: TextInputAction.next,
              fieldTypes: FieldTypes.normal,
              type: TextInputType.emailAddress,
              controller: RegisterBloc().emailController,
              validate: (value) => value?.validateEmail(),
            ),
            const SizedBox(height: 20),
            BlocBuilder<GenericBloc<List<CityModel>>, GenericState<List<CityModel>>>(
              bloc: RegisterBloc().citiesCubit,
              builder: (_, state) => state is GenericUpdateState
                  ? DropDownWidget(
                      title: tr("selectCity"),
                      hintText: tr("selectCity"),
                      iconPath: ImageName.buildingSvg,
                      validator: (value) => value.toString().validateEmpty(),
                      onChanged: (val) => RegisterBloc().cityId = val.toString(),
                      items: state.data.map((e) {
                        return DropdownMenuItem(value: e.id.toString(), child: Text(e.title ?? ''));
                      }).toList(),
                    )
                  : const SizedBox.shrink(),
            ),
            const SizedBox(height: 20),
            ValueListenableBuilder<bool>(
              valueListenable: RegisterBloc().showPassword,
              builder: (context, value, child) => CustomTextField(
                title: tr("password"),
                hint: tr("enterPassword"),
                iconPath: ImageName.lockSvg,
                action: TextInputAction.next,
                type: TextInputType.visiblePassword,
                controller: RegisterBloc().passwordController,
                validate: (value) => value?.validatePassword(),
                fieldTypes: value == true ? FieldTypes.normal : FieldTypes.password,
                suffixIcon: GestureDetector(
                  onTap: () => RegisterBloc().showPassword.value = !value,
                  child: Icon(
                    value == true ? Icons.visibility : Icons.visibility_off,
                    color: Styles.greyColor,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            MyText(title: tr("selectGender"), color: Styles.blackColor, fontWeight: FontWeight.bold),
            const SizedBox(height: 5),
            ValueListenableBuilder<int>(
              valueListenable: RegisterBloc().selectGender,
              builder: (context, value, child) => Row(
                children: [
                  Expanded(
                    child: DefaultButton(
                      title: tr("male"),
                      onTap: () => RegisterBloc().selectGender.value = 1,
                      textColor: value == 1 ? Styles.whiteColor : Styles.greyColor,
                      color: value == 1 ? Styles.primaryColor : Styles.greyColor.withOpacity(0.3),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: DefaultButton(
                      title: tr("female"),
                      onTap: () => RegisterBloc().selectGender.value = 0,
                      textColor: value == 0 ? Styles.whiteColor : Styles.greyColor,
                      color: value == 0 ? Styles.primaryColor : Styles.greyColor.withOpacity(0.3),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            LoadingButton(
              title: tr("login"),
              btnKey: RegisterBloc().btnKey,
              onTap: () => RegisterBloc().registerFunction(),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}

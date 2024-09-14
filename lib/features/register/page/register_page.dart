import 'package:enjaz/app_config/image_name.dart';
import 'package:enjaz/components/custom_app_bar_widget.dart';
import 'package:enjaz/components/custom_scaffold_widget.dart';
import 'package:enjaz/components/my_text.dart';
import 'package:enjaz/features/register/bloc/register_bloc.dart';
import 'package:enjaz/features/register/widget/register_form_widget.dart';
import 'package:enjaz/helpers/styles.dart';
import 'package:enjaz/helpers/translation/localization_methods.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  void initState() {
    RegisterBloc().initData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      body: Column(
        children: [
          const CustomAppBarWidget(imageSvg: ImageName.addUserSvg),
          const SizedBox(height: 10),
          MyText(
            title: tr("createNewAccount"),
            size: 19,
            color: Styles.whiteColor,
          ),
          const SizedBox(height: 10),
          MyText(
            title: tr("registerDes"),
            size: 17,
            color: Styles.whiteColor.withOpacity(0.6),
          ),
          const SizedBox(height: 20),
          const Expanded(child: RegisterFormWidget()),
        ],
      ),
    );
  }
}

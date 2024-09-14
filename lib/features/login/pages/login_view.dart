import 'package:enjaz/components/custom_scaffold_widget.dart';
import 'package:enjaz/features/login/bloc/login_bloc.dart';
import 'package:enjaz/features/login/widget/login_form_widget.dart';
import 'package:enjaz/features/login/widget/login_header_widget.dart';
import 'package:flutter/material.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  void initState() {
    super.initState();
    LoginBloc().initLoginData();
  }

  @override
  Widget build(BuildContext context) {
    return const ScaffoldWidget(
      body: Column(
        children: [
          LoginHeaderWidget(),
          SizedBox(height: 20),
          Expanded(child: LoginFormWidget()),
        ],
      ),
    );
  }
}

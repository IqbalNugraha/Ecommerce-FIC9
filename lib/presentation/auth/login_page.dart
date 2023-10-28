import 'package:fic9_ecommerce_template_app/common/constants/images.dart';
import 'package:fic9_ecommerce_template_app/common/constants/variables.dart';
import 'package:fic9_ecommerce_template_app/data/datasources/local_remote_datasources.dart';
import 'package:fic9_ecommerce_template_app/data/models/request/login_request_model.dart';
import 'package:fic9_ecommerce_template_app/presentation/auth/bloc/login/login_bloc.dart';
import 'package:fic9_ecommerce_template_app/presentation/dashboard/dashboard_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../common/components/button.dart';
import '../../common/components/custom_text_field.dart';
import '../../common/components/space_height.dart';
import '../../common/constants/colors.dart';
import 'register_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool _hidePassword = true;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const SpaceHeight(80.0),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 130.0),
              child: Image.asset(
                Images.logo,
                width: 100,
                height: 100,
              )),
          const SpaceHeight(24.0),
          const Center(
            child: Text(
              Variables.headerLogin,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: ColorName.dark,
              ),
            ),
          ),
          const SpaceHeight(8.0),
          const Center(
            child: Text(
              Variables.bannerLogin,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: ColorName.grey,
              ),
            ),
          ),
          const SpaceHeight(40.0),
          CustomTextField(
            controller: emailController,
            label: Variables.hintEmail,
            textInputType: TextInputType.emailAddress,
          ),
          const SpaceHeight(12.0),
          CustomTextField(
            controller: passwordController,
            label: Variables.hintPassword,
            obscureText: _hidePassword,
            suffixIcon: GestureDetector(
              onTap: () {
                setState(() {
                  _hidePassword = !_hidePassword;
                });
              },
              child: Icon(
                _hidePassword ? Icons.visibility_off : Icons.visibility_rounded,
              ),
            ),
          ),
          const SpaceHeight(24.0),
          BlocConsumer<LoginBloc, LoginState>(
            listener: (context, state) {
              state.maybeWhen(
                orElse: () {},
                success: (data) {
                  if (data.error != null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(data.error!.message!),
                        backgroundColor: ColorName.red,
                      ),
                    );
                  } else {
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (context) => DashboardPage(token: data.jwt!),
                      ),
                      (route) => false,
                    );
                    LocalRemoteDatasource().saveToken(data.jwt ?? "");
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(Variables.successLogin),
                        backgroundColor: Colors.green,
                      ),
                    );
                  }
                },
                error: (message) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(message),
                      backgroundColor: ColorName.red,
                    ),
                  );
                },
              );
            },
            builder: (context, state) {
              return state.maybeWhen(
                orElse: () {
                  return Button.filled(
                    onPressed: () {
                      final loginRequestModel = LoginRequestModel(
                        identifier: emailController.text,
                        password: passwordController.text,
                      );
                      context
                          .read<LoginBloc>()
                          .add(LoginEvent.login(loginRequestModel));
                    },
                    label: Variables.btnLogin,
                  );
                },
                loading: () {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: ColorName.primary,
                    ),
                  );
                },
              );
            },
          ),
          const SpaceHeight(122.0),
          Center(
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const RegisterPage(),
                  ),
                );
              },
              child: const Text.rich(
                TextSpan(
                  text: Variables.notHaveAccount,
                  children: [
                    TextSpan(
                      text: Variables.btnRegister,
                      style: TextStyle(color: ColorName.primary),
                    ),
                  ],
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: ColorName.grey,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

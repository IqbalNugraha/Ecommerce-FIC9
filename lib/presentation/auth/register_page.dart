import 'package:fic9_ecommerce_template_app/common/constants/variables.dart';
import 'package:fic9_ecommerce_template_app/data/models/request/register_request_model.dart';
import 'package:fic9_ecommerce_template_app/presentation/auth/bloc/register/register_bloc.dart';
import 'package:fic9_ecommerce_template_app/presentation/auth/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../common/components/button.dart';
import '../../common/components/custom_text_field.dart';
import '../../common/components/space_height.dart';
import '../../common/constants/colors.dart';
import '../../common/constants/images.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  bool _hidePassword = true;
  bool _hideRePassword = true;
  String? _errorText;

  @override
  void initState() {
    passwordController.addListener(() {
      if (passwordController.text.isEmpty &&
          confirmPasswordController.text.isEmpty) {
        setState(() {
          _errorText = Variables.passwordEmpty;
        });
      } else if (passwordController.text != confirmPasswordController.text) {
        setState(() {
          _errorText = Variables.passwordNotSame;
        });
      } else {
        setState(() {
          _errorText = null;
        });
      }
    });
    confirmPasswordController.addListener(() {
      if (passwordController.text != confirmPasswordController.text) {
        setState(() {
          _errorText = Variables.passwordNotSame;
        });
      } else {
        setState(() {
          _errorText = null;
        });
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    nameController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
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
              Variables.letStart,
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
              Variables.createNewAccount,
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
            controller: nameController,
            label: Variables.hintUsername,
          ),
          const SpaceHeight(12.0),
          CustomTextField(
            controller: passwordController,
            label: Variables.hintPassword,
            obscureText: _hidePassword,
            errorText: _errorText,
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
          const SpaceHeight(12.0),
          CustomTextField(
            controller: confirmPasswordController,
            label: Variables.hintRePassword,
            obscureText: _hideRePassword,
            errorText: _errorText,
            suffixIcon: GestureDetector(
              onTap: () {
                setState(() {
                  _hideRePassword = !_hideRePassword;
                });
              },
              child: Icon(
                _hideRePassword
                    ? Icons.visibility_off
                    : Icons.visibility_rounded,
              ),
            ),
          ),
          const SpaceHeight(24.0),
          BlocConsumer<RegisterBloc, RegisterState>(
            listener: (context, state) {
              state.maybeWhen(
                orElse: () {},
                success: (data) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginPage(),
                    ),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(Variables.successRegister),
                      backgroundColor: Colors.green,
                    ),
                  );
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
                      final registerRequestModel = RegisterRequestModel(
                        name: nameController.text,
                        password: passwordController.text,
                        email: emailController.text,
                        username: nameController.text.replaceAll(' ', ''),
                      );
                      context
                          .read<RegisterBloc>()
                          .add(RegisterEvent.register(registerRequestModel));
                    },
                    label: Variables.btnRegister,
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
          const SpaceHeight(60.0),
          Center(
            child: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Text.rich(
                TextSpan(
                  text: Variables.haveAccount,
                  children: [
                    TextSpan(
                      text: Variables.btnLogin,
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

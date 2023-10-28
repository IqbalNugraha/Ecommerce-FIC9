import 'package:fic9_ecommerce_template_app/common/constants/images.dart';
import 'package:fic9_ecommerce_template_app/presentation/auth/login_page.dart';
import 'package:flutter/material.dart';

import '../../data/datasources/local_remote_datasources.dart';
import '../dashboard/dashboard_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    checkAuth();
    super.initState();
  }

  void checkAuth() async {
    final auth = await LocalRemoteDatasource().getToken();
    if (auth.isNotEmpty) {
      Future.delayed(const Duration(seconds: 3), () {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => DashboardPage(token: auth),
          ),
          (route) => false,
        );
      });
    } else {
      Future.delayed(const Duration(seconds: 3), () {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const LoginPage(),
          ),
          (route) => false,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          Images.logo,
          width: 200,
          height: 200,
        ),
      ),
    );
  }
}

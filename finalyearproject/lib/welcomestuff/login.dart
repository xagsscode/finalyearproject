import 'package:finalyearproject/welcomestuff/readylog.dart';
import 'package:finalyearproject/welcomestuff/signup.dart';
import 'package:finalyearproject/widgetrefactor/colors.dart';
import 'package:finalyearproject/widgetrefactor/reuseclass.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 40),
              child: Image.asset('assets/pc1.png'),
            ),
            const SizedBox(height: 30),
            AppLargeText(text: "WELCOME"),
            AppText(text: 'login or register to have access'),
            const SizedBox(height: 50),
            _buildLoginButton(context),
            const SizedBox(height: 30),
            _buildSignUpButton(context),
            const SizedBox(height: 25),
            Text(
              "Copyright © 2024 xagscode",
              style: TextStyle(fontSize: 16),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildLoginButton(BuildContext context) {
    return InkWell(
      onTap: () {
        _showProgressDialog(context);
        // Simulating a delay before navigating to LoginStuff page
        Future.delayed(const Duration(seconds: 2), () {
          Get.to(const LoginStuff());
        });
      },
      child: LoginButton(
        text: 'Sign In',
        color: AppColors.mainColor,
        size: 20,
        color2: Colors.white,
      ),
    );
  }

  Widget _buildSignUpButton(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(const SignUpPage());
      },
      child: LoginButton(
        text: 'Sign Up',
        color: AppColors.buttonBackgroud,
        size: 20,
        color2: AppColors.mainColor,
      ),
    );
  }

  void _showProgressDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 10),
              Text("Loading..."),
            ],
          ),
        );
      },
    );
  }
}

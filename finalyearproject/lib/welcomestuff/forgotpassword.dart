import 'package:finalyearproject/widgetrefactor/colors.dart';
import 'package:finalyearproject/widgetrefactor/textform.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _emailController = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
  }

  Future passwordReset() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: _emailController.text.trim());

      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text('Password reset link sent! check  your email'),
            );
          });
      _emailController.clear();
    } on FirebaseAuthException catch (e) {
      print(e);

      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text(e.message.toString()),
            );
          });

      _emailController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reset Password'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "enter your email to reset password",
            style: TextStyle(fontSize: 15),
          ),
          TextForm(
              controllerCallback: _emailController,
              text: 'Enter Email',
              text2: 'Email'),
          MaterialButton(
            color: AppColors.mainColor,
            onPressed: passwordReset,
            child: Text(
              'Reset Password',
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
    );
  }
}



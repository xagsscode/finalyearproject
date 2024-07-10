import 'package:finalyearproject/screens/firstscreen.dart';
import 'package:finalyearproject/screens/mainpage.dart';
import 'package:finalyearproject/welcomestuff/forgotpassword.dart';
import 'package:finalyearproject/welcomestuff/login.dart';
import 'package:finalyearproject/welcomestuff/signup.dart';
import 'package:finalyearproject/widgetrefactor/colors.dart';
import 'package:finalyearproject/widgetrefactor/reuseclass.dart';
import 'package:finalyearproject/widgetrefactor/textform.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class LoginStuff extends StatefulWidget {
  const LoginStuff({super.key});

  @override
  State<LoginStuff> createState() => _LoginStuffState();
}

class _LoginStuffState extends State<LoginStuff> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;
  User? user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(top: 50),
              child: Image.asset(
                'assets/pc2.png',
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Center(child: AppLargeText(text: 'Login')),
            const SizedBox(
              height: 20,
            ),
            TextForm(
                controllerCallback: _emailController,
                text: 'Enter Email',
                text2: 'Email'),
            const SizedBox(height: 10),
            TextForm(
                Obsecuretext: true,
                controllerCallback: _passwordController,
                text: 'Enter Password',
                text2: 'Password'),
            SizedBox(
              height: 10,
            ),
            Center(
              child: MaterialButton(
                onPressed: loginFunc,
                child: LoginButton(
                  text: 'Sign In',
                  color: AppColors.mainColor,
                  color2: AppColors.buttonBackgroud,
                  size: 20,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      Get.to(const SignUpPage());
                    },
                    child: AppText(
                      text: 'Register',
                      color: AppColors.mainColor,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.to(ForgotPasswordPage());
                    },
                    child: AppText(
                      text: 'Forgot Password',
                      color: AppColors.mainColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> loginFunc() async {
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      user = userCredential.user;
      if (user != null) {
        Get.to(MainPage());
        _emailController.clear();
        _passwordController.clear();
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found' || e.code == 'wrong-password') {
        Get.snackbar(
          'Retry',
          'Wrong email or password',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      print(e);
    }
  }
}

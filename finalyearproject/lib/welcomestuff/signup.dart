import 'package:finalyearproject/screens/forthscreen.dart';
import 'package:finalyearproject/screens/mainpage.dart';
import 'package:finalyearproject/welcomestuff/readylog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:finalyearproject/screens/firstscreen.dart';
import 'package:finalyearproject/welcomestuff/login.dart';
import 'package:finalyearproject/widgetrefactor/colors.dart';
import 'package:finalyearproject/widgetrefactor/reuseclass.dart';
import 'package:finalyearproject/widgetrefactor/textform.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final _schoolController = TextEditingController();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;
  User? user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  margin: const EdgeInsets.only(top: 25),
                  width: 150,
                  height: 100,
                  decoration: BoxDecoration(
                    color: AppColors.mainColor,
                    borderRadius: const BorderRadius.only(
                      bottomRight: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                      topLeft: Radius.circular(20),
                    ),
                  ),
                  child: Center(
                    child: AppLargeText(
                      text: "Sign Up",
                      color: AppColors.buttonBackgroud,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppText(text: "Already have an account"),
                  const SizedBox(width: 5),
                  InkWell(
                    onTap: () {
                      Get.to(LoginStuff());
                    },
                    child: AppText(
                      text: 'Login',
                      color: AppColors.mainColor,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              TextForm(
                controllerCallback: _schoolController,
                text: 'username',
                text2: 'User name',
                validator: (value) => _validateTextField(value, 'User Name'),
              ),
              const SizedBox(height: 10),
              TextForm(
                controllerCallback: _nameController,
                text: 'Registration Number*',
                text2: 'Registration number',
                validator: (value) => _validateTextSchoolID(),
              ),
              const SizedBox(height: 10),
              TextForm(
                controllerCallback: _emailController,
                text: 'Enter Email',
                text2: 'Email*',
                validator: (value) => _validateTextField(value, 'Email'),
              ),
              const SizedBox(height: 10),
              TextForm(
                Obsecuretext: true,
                controllerCallback: _passwordController,
                text: 'Enter Password*',
                text2: 'Password',
                validator: (value) => _validateTextField(value, 'Password'),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MaterialButton(
                      onPressed: signUpFunc,
                      child: LoginButton(
                        size: 20,
                        text: 'Register',
                        width: 120,
                        color: AppColors.mainColor,
                        color2: AppColors.buttonBackgroud,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String? _validateTextField(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return '$fieldName is required';
    }
    return null;
  }

  String? _validateTextSchoolID() {
    if (_nameController.text.isEmpty) {
      return 'Required';
    }
    return null;
  }

  Future<void> signUpFunc() async {
    if (_formKey.currentState?.validate() ?? false) {
      try {
        UserCredential userCredential =
            await auth.createUserWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text,
        );
        user = userCredential.user;
        await user!.updateDisplayName(_schoolController.text);
        await user!.updatePhotoURL(_nameController.text);
        await user!.reload();
        user = auth.currentUser;
        if (user != null) {
          Get.to(() => const MainPage());

          // Clear the text editing controllers
          _schoolController.clear();
          _nameController.clear();
          _emailController.clear();
          _passwordController.clear();
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          Get.snackbar(
            'error',
            e.message.toString(),
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        } else if (e.code == 'email-already-in-use') {
          Get.snackbar(
            'Error',
            e.message.toString(),
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        }
      } catch (e) {
        print(e);
      }
    }
  }
}

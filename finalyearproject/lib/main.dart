import 'package:finalyearproject/aipages/gemini/gemini.dart';
import 'package:finalyearproject/screens/firstscreen.dart';
import 'package:finalyearproject/screens/mainpage.dart';
import 'package:finalyearproject/slider/slider.dart';
import 'package:finalyearproject/welcomestuff/login.dart';
import 'package:finalyearproject/welcomestuff/signup.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(ChangeNotifierProvider(
    create: (_) => ChatHistory(),
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(                            
      debugShowCheckedModeBanner: false,
      title: "project",
      // home: LoginPage(),

      home: MainPage(),
      // home: SliderScreen(),
      initialRoute: '/',
      getPages: [
        GetPage(name: '/Sign Up', page: () => const SignUpPage()),
        GetPage(name: '/Profile', page: () => const FirstScreen())
      ],
    );
  }
}










// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:mypractice/get.dart';
// import 'package:mypractice/needs/need2.dart';

// void main() => runApp(getApp());

// class getApp extends StatelessWidget {
//   const getApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return GetMaterialApp(
//       title: 'Practice',
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('SnackBar'),
//         ),
//         body: const Center(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text(
//                 'MY TIC TAC TOE',
//                 textAlign: TextAlign.center,
//                 style: TextStyle(fontSize: 40),
//               ),
//               SizedBox(
//                 height: 20,
//               ),
//               Refactor(height: 100, width: 100, color: Colors.blue),
//               SizedBox(
//                 height: 20,
//               ),
//               Refactor(
//                 height: 100,
//                 width: 100,
//                 color: Colors.blue,
//               ),
//               SizedBox(
//                 height: 20,
//               ),
//               Refactor(
//                 height: 100,
//                 width: 100,
//                 color: Colors.blue,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

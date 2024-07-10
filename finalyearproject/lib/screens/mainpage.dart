import 'package:finalyearproject/screens/fifthscreen.dart';
import 'package:finalyearproject/screens/forthscreen.dart';
import 'package:finalyearproject/screens/mapview.dart';
import 'package:finalyearproject/screens/secondscreen.dart';
import 'package:finalyearproject/screens/thirdscreen.dart';
import 'package:finalyearproject/widgetrefactor/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(
              icon: Icon(
                Icons.map,
                color: Colors.white,
              ),
              text: 'Campus Map',
            ),
            Tab(
              icon: Icon(
                Icons.hub,
                color: Colors.white,
              ),
              text: 'AI Assistance',
            ),
            Tab(
              icon: Icon(
                Icons.transfer_within_a_station_sharp,
                color: Colors.white,
              ),
              text: 'Campus Guide',
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          MapViewPage(),
          AiPage(),
          GuidePage(),
        ],
      ),
    );
  }
}



// import 'dart:collection';

// import 'package:finalyearproject/screens/fifthscreen.dart';
// import 'package:finalyearproject/screens/firstscreen.dart';
// import 'package:finalyearproject/screens/forthscreen.dart';
// import 'package:finalyearproject/screens/mapview.dart';
// import 'package:finalyearproject/screens/secondscreen.dart';
// import 'package:finalyearproject/screens/thirdscreen.dart';
// import 'package:finalyearproject/widgetrefactor/colors.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:curved_navigation_bar/curved_navigation_bar.dart'; // Import the package

// class MainPage extends StatefulWidget {
//   const MainPage({super.key});

//   @override
//   State<MainPage> createState() => _MainPageState();
// }

// class _MainPageState extends State<MainPage> {
//   int currentIndex = 0;
//   bool _isPointed = true;
//   List pages = [
//     const HomePage(),
//     const MapViewPage(),
//     const AiPage(),
//     const GuidePage(),
//     const FirstScreen(),
//   ];
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: pages[currentIndex],
//       bottomNavigationBar: CurvedNavigationBar(
//         index: currentIndex,
//         height: 50.0,
//         items: <Widget>[
//           Icon(
//             Icons.home,
//             size: 30,
//             color: currentIndex == 0 ? Colors.white : Colors.grey,
//           ),
//           Icon(
//             Icons.map,
//             size: 30,
//             color: currentIndex == 1 ? Colors.white : Colors.grey,
//           ),
//           Icon(
//             Icons.hub,
//             size: 30,
//             color: currentIndex == 2 ? Colors.white : Colors.grey,
//           ),
//           Icon(
//             Icons.transfer_within_a_station_sharp,
//             size: 30,
//             color: currentIndex == 3 ? Colors.white : Colors.grey,
//           ),
//           Icon(
//             Icons.person,
//             size: 30,
//             color: currentIndex == 4 ? Colors.white : Colors.grey,
//           ),
//         ],
//         color: AppColors.mainColor,
//         buttonBackgroundColor: AppColors.mainColor,
//         backgroundColor: Colors.transparent,
//         animationCurve: Curves.easeInOut,
//         animationDuration: Duration(milliseconds: 600),
//         onTap: (index) {
//           setState(() {
//             currentIndex = index;
//           });
//         },
//       ),
//     );
//   }
// }

// import 'package:finalyearproject/screens/fifthscreen.dart';
// import 'package:finalyearproject/screens/firstscreen.dart';
// import 'package:finalyearproject/screens/forthscreen.dart';
// import 'package:finalyearproject/screens/secondscreen.dart';
// import 'package:finalyearproject/screens/thirdscreen.dart';
// import 'package:finalyearproject/widgetrefactor/colors.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class MainPage extends StatefulWidget {
//   const MainPage({super.key});

//   @override
//   State<MainPage> createState() => _MainPageState();
// }

// class _MainPageState extends State<MainPage> {
//   int currentIndex = 0;
//   List pages = [
//     const HomePage(),
//     const MapPage(),
//     const AiPage(),
//     const GuidePage(),
//     const FirstScreen(),
//   ];
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: pages[currentIndex],
//       bottomNavigationBar: BottomNavigationBar(
//           unselectedFontSize: 0,
//           selectedFontSize: 0,
//           type: BottomNavigationBarType.fixed,
//           backgroundColor: Colors.white,
//           onTap: onTap,
//           currentIndex: currentIndex,
//           selectedItemColor: AppColors.mainColor,
//           unselectedItemColor: Colors.grey.withOpacity(0.5),
//           showSelectedLabels: false,
//           showUnselectedLabels: false,
//           elevation: 0,
//           items: const [
//             BottomNavigationBarItem(
//                 label: 'Home',
//                 icon: Icon(
//                   Icons.home,
//                   size: 30,
//                 )),
//             BottomNavigationBarItem(
//                 label: 'Map',
//                 icon: Icon(
//                   Icons.map,
//                   size: 30,
//                 )),
//             BottomNavigationBarItem(
//                 label: 'Guide',
//                 icon: Icon(
//                   Icons.hub,
//                   size: 30,
//                 )),
//             BottomNavigationBarItem(
//                 label: 'Guide',
//                 icon: Icon(
//                   Icons.transfer_within_a_station_sharp,
//                   size: 30,
//                 )),
//             BottomNavigationBarItem(
//                 label: 'Me',
//                 icon: Icon(
//                   Icons.person,
//                   size: 30,
//                 )),
//           ]),
//     );
//   }

//   void onTap(index) {
//     setState(() {
//       currentIndex = index;
//     });
//   }
// }

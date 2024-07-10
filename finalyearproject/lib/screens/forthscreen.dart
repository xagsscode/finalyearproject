import 'package:carousel_slider/carousel_slider.dart';
import 'package:finalyearproject/disabilities/blindpage.dart';
import 'package:finalyearproject/disabilities/deafpage.dart';
import 'package:finalyearproject/disabilities/howtopage.dart';
import 'package:finalyearproject/gamepage/game.dart';
import 'package:finalyearproject/screens/fifthscreen.dart';
import 'package:finalyearproject/screens/mainpage.dart';
import 'package:finalyearproject/widgetrefactor/colors.dart';
import 'package:finalyearproject/widgetrefactor/reuseclass.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late MainPage _page;
  FirebaseAuth auth = FirebaseAuth.instance;
  User? user;
  @override
  void initState() {
    super.initState();
    if (auth.currentUser != null) {
      user = auth.currentUser;
    }
  }

  var bannerImages = {
    'buk.png': 'Welcome to buk guide',
  };

  List icons = [
    Icons.language,
    Icons.transcribe,
    Icons.edit_document,
    Icons.speaker,
  ];

  var images = {
    "lang.png": "⅂@ℿⓖ℧@ⓖ∑",
    "gemini.png": "Ⓖ∑ℿℿℹℿℹ",
    "text.png": "₮∑✕†",
    "speech.png": "S⅌∑∑ℭ|-|"
  };
  var imagesDisable = {
    "deaf3.jpg": "Deaf",
    "blind2.jpg": "Blind",
    "howto2.jpg": "How to use",
  };

  List pages = [const DeafPage(), BlindPage(), const HowtoPage()];
  @override
  Widget build(BuildContext context) {
    TabController _tabController = TabController(length: 2, vsync: this);
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppLargeText(text: 'Home'),
                    AppText(
                      text: 'HI, ${user?.displayName}',
                      size: 15,
                    ),
                    CircleAvatar(
                      child: Icon(Icons.account_circle_outlined),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: Container(
                  height: 200,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 4,
                        spreadRadius: 1,
                      ),
                    ],
                    // gradient: LinearGradient(
                    //     begin: Alignment.topLeft,
                    //     end: Alignment.bottomLeft,
                    //     stops: const [
                    //       0.6,
                    //       1
                    //     ],
                    //     colors: [
                    //       AppColors.mainColor,
                    //       const Color(0xffffcc6)
                    //     ]),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: CarouselSlider(
                    items: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                          image: AssetImage("assets/buk.png"),
                          fit: BoxFit.contain,
                        )),
                        child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Text(
                              "Bayero university guide",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            )),
                      ),
                      Center(
                        child: ListTile(
                          title: AppLargeText(
                            text: 'وفوق كل ذي علم عليم',
                            size: 20,
                          ),
                          subtitle: AppText(
                            text:
                                '"and above every possessor of knowledge there is one more learned"',
                            size: 12,
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage("assets/uni.png"),
                                fit: BoxFit.fitHeight)),
                      ),
                    ],
                    options: CarouselOptions(
                      height: 200.0,
                      enlargeCenterPage: true,
                      autoPlay: true,
                      aspectRatio: 16 / 9,
                      autoPlayCurve: Curves.fastEaseInToSlowEaseOut,
                      enableInfiniteScroll: true,
                      autoPlayAnimationDuration:
                          const Duration(milliseconds: 1000),
                      viewportFraction: 0.8,
                    ),
                  ),
                ),
              ),
              // Container(
              //     padding: const EdgeInsets.all(20),
              //     child: AppText(
              //       text: 'Bayero university guide',
              //       color: AppColors.bigTextColor,
              //       size: 20,
              //     )),
              SizedBox(
                height: 5,
              ),

              SizedBox(
                height: 10,
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 4,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                child: TabBar(
                    controller: _tabController,
                    labelColor: Colors.black,
                    unselectedLabelColor: Colors.grey,
                    indicator:
                        CircleIndicator(color: AppColors.mainColor, radius: 5),
                    tabs: [
                      const Tab(
                        text: "Disabled",
                      ),
                      const Tab(
                        text: "PlayGame",
                      ),
                    ]),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 200,
                width: MediaQuery.of(context).size.width,
                child: TabBarView(controller: _tabController, children: [
                  // ...

                  ListView.builder(
                    itemCount: 3,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          Get.to(pages[index]);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => pages[index]),
                          );
                        },
                        child: Container(
                          // margin: const EdgeInsets.only(top: 10),
                          child: Column(
                            children: [
                              Container(
                                margin: const EdgeInsets.only(left: 20),
                                height: 150,
                                width: 150,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.grey,
                                  image: DecorationImage(
                                    image: AssetImage('assets/' +
                                        imagesDisable.keys.elementAt(index)),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(imagesDisable.values.elementAt(index)),
                            ],
                          ),
                        ),
                      );
                    },
                  ),

                  Container(
                      height: 200,
                      width: MediaQuery.of(context).size.width,
                      child: TextButton(
                          onPressed: () {
                            Get.to(TicTacToeGame());
                          },
                          child: const Text(
                              "All read but no play makes jack a dull boy \n  Tap To Play")))
                ]),
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppLargeText(
                      text: "Features",
                      size: 20,
                      color: AppColors.textColor2,
                    ),
                    AppText(text: "swipe left")
                  ],
                ),
              ),
              Container(
                height: 110,
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.only(top: 10),
                // margin: const EdgeInsets.only(left: 20),
                child: ListView.builder(
                    itemCount: 4,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (_, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () {
                            Get.to(());
                          },
                          child: Container(
                            child: Column(
                              children: [
                                Container(
                                  height: 60,
                                  width: 90,
                                  child: CircleAvatar(
                                    backgroundColor: AppColors.mainColor,
                                    child: Icon(
                                      icons[index],
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                // Container(
                                //   // margin: EdgeInsets.only(right: 50),
                                //   height: 50,
                                //   width: 50,
                                //   decoration: BoxDecoration(
                                //     gradient: LinearGradient(
                                //         begin: Alignment.topCenter,
                                //         end: Alignment.bottomCenter,
                                //         stops: const [
                                //           0.9,
                                //           2
                                //         ],
                                //         colors: [
                                //           AppColors.mainColor,
                                //           const Color(0xffffcc6)
                                //         ]),
                                //     borderRadius: BorderRadius.circular(20),
                                //     color: Colors.grey,
                                //   ),
                                //
                                //   child: Icon(
                                //     icons[index],
                                //     color: Colors.white,
                                //   ),
                                // ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Container(
                                  child: AppText(
                                      size: 10,
                                      color: Colors.black,
                                      text: images.values.elementAt(index)),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

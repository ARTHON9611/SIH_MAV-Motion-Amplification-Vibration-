import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mav/profile_page.dart';
import 'package:mav/services/firebase_auth_methods.dart';
import 'package:mav/technique_selection.dart';
import 'package:mav/video_edit_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FirebaseAuth auth = FirebaseAuth.instance;  
  final ImagePicker _picker = ImagePicker();
  int _selectedIndex=0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _selectedIndex = 0; 
  }

  void _logout() async {
    FirebaseAuthMethods(FirebaseAuth.instance).logout(context: context);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      // appBar: PreferredSize(
      //   preferredSize: const Size.fromHeight(150),
      //   child: AppBar(
      //     backgroundColor: Colors.black,
      //     elevation: 10,
      //     centerTitle: true,
      //     shape: const RoundedRectangleBorder(
      //       borderRadius: BorderRadius.vertical(
      //         bottom: Radius.circular(10),
      //       ),
      //     ),
      //     flexibleSpace: Column(crossAxisAlignment: CrossAxisAlignment.start,children: [Padding(padding: EdgeInsets.only(top: 40,left: 0),child: Text("Welcome,",style: TextStyle(color: Colors.white,fontSize: 35),))]),
      //   ),
      // ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Padding(
            //     padding: EdgeInsets.symmetric(horizontal: 5,vertical: 5),
            //     child: Row(
            //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //       children: [
            //         Icon(
            //           Icons.menu_rounded,
            //           color: Colors.white,
            //           size: 35,
            //         ),
            //         Icon(
            //           Icons.settings,
            //           color: Colors.grey.shade200,                      
            //           size: 35,
            //         )
            //       ],
            //     )),
            Container(
                child: Column(children: [
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                            padding: EdgeInsets.all(10),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Welcome,",
                                    style: TextStyle(
                                      color: Colors.blue.shade200,
                                        fontSize: 35,
                                        fontWeight: FontWeight.w900),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Text(auth.currentUser!.displayName.toString().split(' ').first.toLowerCase().replaceFirst(auth.currentUser!.displayName.toString().split(' ').first[0].toLowerCase(),auth.currentUser!.displayName.toString().split(' ').first[0].toUpperCase()),
                                        style: TextStyle(
                                          color: Colors.white,
                                            fontSize: 30,
                                            fontWeight: FontWeight.w500)),
                                  )
                                ])),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProfilePage(),
                              ),
                            );
                          },
                          child: Container(
                            padding: EdgeInsets.only(right: 30),
                            child: CircleAvatar(
                              radius: 35,
                              backgroundImage: NetworkImage(auth.currentUser!.photoURL.toString()),
                            ),
                          ),
                        )
                      ]))
            ])),
            Container(
              height: 200,
              child: Swiper(
                itemCount: avatarUrls.length,
                loop: true,
                autoplay: true,
                autoplayDelay: 2000,
                autoplayDisableOnInteraction: true,
                duration: 1200,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: EdgeInsets.fromLTRB(5, 10, 5, 0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.vertical(
                        bottom: Radius.circular(20),
                        top: Radius.circular(20),
                      ),
                      child: Image.network(
                        avatarUrls[index],
                        fit: BoxFit.fill,
                      ),
                    ),
                  );
                },
                pagination: SwiperPagination(
                  alignment: Alignment.bottomCenter,
                  builder: CustomRectangularPaginationBuilder(),
                ),
                scrollDirection: Axis.horizontal,
              ),
            ),
            SizedBox(height: 20,),
            // Other widgets or content below the Swiper can be added here
            Expanded(child:GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
          shrinkWrap: true,
          children: List.generate(2, (index) {
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black,
                    image: DecorationImage(
                      image: AssetImage('assets/images/background.jpg'),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: 
                    BorderRadius.all(Radius.circular(20.0),),
                  ),
                ),
              );
            },),
        ),
      ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        color: Colors.black,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
          child: GNav(
            backgroundColor: Colors.black,
            selectedIndex: _selectedIndex,
            gap: 8,
            onTabChange: (value) {
              setState(() {
              });
            },
            color: Colors.white,
            activeColor: Colors.white,
            tabBorderRadius: 300,
            tabBackgroundColor: Colors.grey.shade800,
            padding: EdgeInsets.all(16.0),
            tabs: [
              GButton(
                icon: Icons.home,
                // style: GnavStyle.oldSchool,
                onPressed: () {},
                text: 'Home',
              ),
              GButton(
                icon: Icons.data_object_outlined,
                text: 'Techniques',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TechniqueSelectionPage(),
                    ),);

                }
              ),
              GButton(
                icon: Icons.settings,
                text: 'Settings',
                onPressed: (){
                },
              ),
              GButton(
                icon: Icons.person,
                text: 'Profile',
                onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProfilePage(),
                    ),);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

List<String> avatarUrls = [
  "https://www.fisdom.com/wp-content/uploads/2023/08/DEFENCE-SECTOR-cover.jpg",
  "https://i.ytimg.com/vi/v1-vECpfEnA/hq720.jpg?sqp=-oaymwEhCK4FEIIDSFryq4qpAxMIARUAAAAAGAElAADIQj0AgKJD&rs=AOn4CLAffTTlYhulhNKD9GPZyryBNQejMQ",
];

class CustomRectangularPaginationBuilder extends SwiperPlugin {
  @override
  Widget build(BuildContext context, SwiperPluginConfig config) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        RectangularBar(config, 1),
        RectangularBar(config, 2),
        RectangularBar(config, 3),
        RectangularBar(config, 4),
        RectangularBar(config, 5),
        RectangularBar(config, 6)
      ],
    );
  }
}

Widget RectangularBar(SwiperPluginConfig config, int index) {
  return Container(
    width: 10,
    height: 5,
    margin: EdgeInsets.all(5),
    decoration: BoxDecoration(
      color: config.activeIndex == index ? Colors.black : Colors.white,
      borderRadius: BorderRadius.circular(5),
    ),
  );
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mav/services/firebase_auth_methods.dart';
import 'package:mav/utils/constants.dart';
import 'package:mav/widgets/profile_widget.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FirebaseAuth auth = FirebaseAuth.instance;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(top: 50),
          child: Container(
            padding: const EdgeInsets.all(16),
            height: size.height,
            width: size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 150,
                  child: CircleAvatar(
                    radius: 60,
                    backgroundImage: NetworkImage(auth.currentUser!.photoURL!.toString()),
                  ),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Constants.primaryColor.withOpacity(.5),
                      width: 5.0,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: size.width * .5,
                  child: Text(
                    auth.currentUser!.displayName!,
                    style: TextStyle(
                      color: Constants.blackColor.withOpacity(0.7),
                      fontSize: 20,
                      fontWeight: FontWeight.w700
                    ),
                  ),
                ),
                Text(
                  auth.currentUser!.email!,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                    color: Constants.blackColor.withOpacity(.6),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                SizedBox(
                  height: size.height * .5,
                  width: size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ProfileWidget(
                        icon: Icons.settings,
                        title: 'Settings',
                        onPressed: (){},
                      ),
                      ProfileWidget(
                        icon: Icons.chat,
                        title: 'FAQs',
                        onPressed: (){},
                      ),
                      ProfileWidget(
                        icon: Icons.share,
                        title: 'Share',
                        onPressed: (){},
                      ),
                      ProfileWidget(
                        icon: Icons.logout,
                        title: 'Log Out',
                        onPressed: (){
                          FirebaseAuthMethods(auth).logout(context: context);
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
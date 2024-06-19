import 'package:flutter/material.dart';
import 'package:hackpue/constants.dart';
import 'package:hackpue/pages/app_intro/mainPage.dart';
import 'package:hackpue/pages/settings/userProfilePage.dart';
import 'package:hackpue/services/auth/auth_service.dart';
import 'package:hackpue/services/auth/authgate.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  void signOut(BuildContext context) {
    final auth = AuthService();
    auth.signOut();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const AuthGate()));
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      surfaceTintColor: lavender,
      width: 250,
      backgroundColor: deepPurple, //Theme.of(context).colorScheme.surface,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            children: [
              Center(
                child: DrawerHeader(
                  //margin: EdgeInsets.symmetric(vertical: 50),
                  child: Column(children: [
                    //Image.asset("assets/images/5887_trans.png", height: 125,),
                    Image(
                      image: AssetImage('assets/images/unatintablanco.png'),
                      width: 150,
                    ),
                    //SizedBox(height: 20,)
                  ]),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25),
                child: ListTile(
                  title: Text("Home",
                      style: TextStyle(
                          fontFamily: "Industry",
                          color: backgroundGlobal,
                          fontWeight: FontWeight.bold)),
                  leading: Icon(
                    Icons.home,
                    color: pink,
                  ),
                  onTap: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MainPage()));
                  },
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 28),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 0, bottom: 0),
                  child: ListTile(
                    splashColor: happyOrange,
                    shape: RoundedRectangleBorder(),
                    title: Text("Settings",
                        style: TextStyle(
                            fontFamily: "Industry",
                            color: backgroundGlobal,
                            fontWeight: FontWeight.bold)),
                    leading: Icon(
                      Icons.settings,
                      color: happyOrange,
                    ),
                    onTap: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const UserProfilePage()));
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 0, bottom: 0),
                  child: ListTile(
                    title: Text("Log Out",
                        style: TextStyle(
                            fontFamily: "Industry",
                            color: backgroundGlobal,
                            fontWeight: FontWeight.bold)),
                    leading: Icon(
                      Icons.logout,
                      color: happyYellow,
                    ),
                    onTap: () {
                      signOut(context);
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

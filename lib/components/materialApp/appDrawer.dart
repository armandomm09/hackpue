import 'package:flutter/material.dart';
import 'package:hackpue/constants.dart';
import 'package:hackpue/pages/app_intro/mainPage.dart';
import 'package:hackpue/pages/settings/userProfilePage.dart';
import 'package:hackpue/services/auth/auth_service.dart';
import 'package:hackpue/services/auth/authgate.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  void signOut(BuildContext context){
    final auth = AuthService();
    auth.signOut();
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const AuthGate()));
  }
  
  
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Color.fromARGB(206, 7, 7, 7),//Theme.of(context).colorScheme.surface,
      child:  Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Center(
                child: DrawerHeader(
                  //margin: EdgeInsets.symmetric(vertical: 50),
                child: Column(children: [
                  //Image.asset("assets/images/5887_trans.png", height: 125,),
                  Icon(Icons.settings, size: 130, color: lavender,)
                  //SizedBox(height: 20,)
                  ]),

                ),
              ),
              
              const SizedBox(height: 30,),
              Padding(
                padding: const EdgeInsets.only(left: 25),
                child: ListTile(
                  title: Text("H O M E", style: TextStyle(fontFamily: "Industry", color: Theme.of(context).colorScheme.inversePrimary,)),
                  leading: Icon(Icons.home, color: Theme.of(context).colorScheme.inversePrimary,),
                  onTap: () {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const MainPage()));
                  },
                ),
              ),
              const SizedBox(height: 12,),

              
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
                    title: Text("S E T T I N G S", style: TextStyle(fontFamily: "Industry", color: Theme.of(context).colorScheme.primary,)),
                    leading: Icon(Icons.settings, color: Theme.of(context).colorScheme.inversePrimary,),
                    onTap: () {
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const UserProfilePage()));
                    },
                  ),
                ),
                Padding(
                      padding: const EdgeInsets.only(left: 0, bottom: 0),
                      child: ListTile(
                        title: Text("L O G  O U T", style: TextStyle(fontFamily: "Industry", color: Theme.of(context).colorScheme.primary,)),
                        leading: Icon(Icons.logout, color: Theme.of(context).colorScheme.inversePrimary,),
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
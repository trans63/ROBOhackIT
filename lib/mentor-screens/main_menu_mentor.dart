import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:look_up/login/login.dart';
import 'package:look_up/mentee-screens/dashboard-mentee.dart';
import 'package:look_up/mentor-screens/dashboard-mentor.dart';
import 'package:look_up/screens/welcome/welcome_screen.dart';


class MainMenuMentor extends StatefulWidget {
  final String uid;
  const MainMenuMentor({Key? key, required this.uid}) : super(key: key);

  @override
  _MainMenuMentorState createState() => _MainMenuMentorState(uid);
}

class _MainMenuMentorState extends State<MainMenuMentor> {
  final String uid;
  int currentIndex = 0;

  _MainMenuMentorState(this.uid);



  @override
  Widget build(BuildContext context) {

    final screens = [
      DashboardMentor(uid: uid),
      WelcomeScreen(uid: uid)
    ];
    return Scaffold(
      body: screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        selectedItemColor: Color.fromARGB(255, 23, 166, 255),
        iconSize: 24,
        showUnselectedLabels: false,
        currentIndex: currentIndex,
        onTap: (index) => setState(() {
          currentIndex = index;
          setState(() {
            loading = true;

          });
        }),
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label:'Home'
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.chat),
              label:'Chat'
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.lightbulb_outline),
              label:'Idea'
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today),
              label:'Booking'
          ),
        ],
      ),
    );
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:look_up/login/login.dart';
import 'package:look_up/mentee-screens/blogs-screen.dart';
import 'package:look_up/mentee-screens/bookings-page.dart';
import 'package:look_up/mentee-screens/dashboard-mentee.dart';


class MainMenuMentee extends StatefulWidget {
  final String uid;
  const MainMenuMentee({Key? key, required this.uid}) : super(key: key);

  @override
  _MainMenuMenteeState createState() => _MainMenuMenteeState(uid);
}

class _MainMenuMenteeState extends State<MainMenuMentee> {
  final String uid;
  int currentIndex = 0;

  _MainMenuMenteeState(this.uid);

  @override
  Widget build(BuildContext context) {

    final screens = [
      DashboardMentee(uid: uid),
      BlogsScreen(),
      BlogsScreen(),
      BookingsPage(uid: uid)
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
              icon: Icon(Icons.lightbulb_outline),
              label:'Idea'
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.chat),
              label:'Chat'
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

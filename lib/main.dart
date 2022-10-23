//@dart=2.9
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:look_up/login/login.dart';
import 'package:look_up/size_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner:false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {


  @override
  _HomePageState createState() => _HomePageState();
}



class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin{



  @override
  void initState() {
    super.initState();

  }




  @override
  Widget build(BuildContext context) {

    return LayoutBuilder(
      builder: (context, constraints) {
        return OrientationBuilder(
          builder: (context, orientation) {
            SizeConfig().init(constraints, orientation);
            return GetMaterialApp(
              debugShowCheckedModeBanner:false,
              home: Scaffold(
                backgroundColor: Colors.white,
                body: LoginScreen(),
              ),
            );
          },
        );
      },
    );



  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:look_up/constants.dart';
import 'package:look_up/loading.dart';
import 'package:look_up/login/login.dart';
import 'package:look_up/screens/quiz/quiz_screen.dart';


class WelcomeScreen extends StatefulWidget {
  final String uid;

  const WelcomeScreen({Key? key, required this.uid}) : super(key: key);
  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState(uid);
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final String uid;
  _WelcomeScreenState( this.uid);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      loading = false;

    });
  }

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              color: Color(0xff272B4A),
            ),
            Center(child: SvgPicture.asset("assets/icons/bg.svg",fit: BoxFit.fitWidth,)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Spacer(flex: 2), //2/6
                  Text(
                    "Welcome to the Quiz !",
                    style: Theme.of(context).textTheme.headline4?.copyWith(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  Text("Enter your details below",
                  style: TextStyle(
                    color: Colors.white,
                  ),),
                  Spacer(), // 1/6
                  TextField(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Color(0xFF1C2341),
                      hintText: "Full Name",
                      hintStyle: TextStyle(
                        color: Colors.white70,
                        fontStyle: FontStyle.italic,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                    ),
                  ),
                  Spacer(), // 1/6
                  InkWell(
                    onTap: () => Get.to(QuizScreen(uid: uid,)),
                    child: Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(kDefaultPadding * 0.75), // 15
                      decoration: BoxDecoration(
                        gradient: kPrimaryGradient,
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                      child: Text(
                        "Let's Start",
                        style: Theme.of(context)
                            .textTheme
                            .button
                            ?.copyWith(color: Colors.black),
                      ),
                    ),
                  ),
                  Spacer(flex: 2), // it will take 2/6 spaces
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

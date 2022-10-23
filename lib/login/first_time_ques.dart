import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:look_up/login/login.dart';
import 'package:look_up/mentee-screens/main_menu_mentee.dart';
import 'package:look_up/mentor-screens/main_menu_mentor.dart';
import 'package:look_up/size_config.dart';

class FirstTimeQues extends StatefulWidget {
  final String uid;
  const FirstTimeQues({Key? key, required this.uid}) : super(key: key);

  @override
  State<FirstTimeQues> createState() => _FirstTimeQuesState(uid);
}

class _FirstTimeQuesState extends State<FirstTimeQues> {
  final String uid;
  String skill = "";
  DocumentSnapshot? ds;
  _FirstTimeQuesState(this.uid);



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserData();
  }

  void getUserData() async{
    ds = await FirebaseFirestore.instance.collection("userdata").doc(uid).get();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                  width: double.infinity,

                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 23, 166, 255),
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 20),
                  child: Column(

                    children: [
                      Text(
                        "Join As :",
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),

                      SizedBox(height: 40,),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 0,horizontal: 60),
                        child: InkWell(
                          onTap: () async{

                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              builder: (context) => SingleChildScrollView(
                                child: Container(
                                  padding: EdgeInsets.only(
                                      bottom: MediaQuery.of(context).viewInsets.bottom),
                                  child: Container(
                                    color: Color(0xff757575),
                                    child: Container(
                                      padding: EdgeInsets.all(20.0),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(20.0),
                                          topRight: Radius.circular(20.0),
                                        ),
                                      ),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.stretch,
                                        children: <Widget>[
                                          Text(
                                            'You are skilled in :- ',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 30.0,
                                              color: Colors.blue,
                                            ),
                                          ),
                                          TextField(
                                            decoration: InputDecoration(
                                              hintText: "Eg: Web development"
                                            ),
                                            autofocus: true,
                                            textAlign: TextAlign.center,
                                            onChanged: (newText) {
                                              setState(() {
                                                skill = newText;
                                              });
                                            },
                                          ),
                                          FlatButton(
                                            child: Text(
                                              'Join',
                                              style: TextStyle(color: Colors.white),
                                            ),
                                            color: Colors.blue,
                                            onPressed: () async{
                                              setState(() {
                                                loading = true;

                                              });
                                              await FirebaseFirestore.instance.collection('userdata').doc(uid).update(
                                                  {

                                                    'type' : "Mentor"
                                                  }
                                              );
                                              await FirebaseFirestore.instance.collection('mentors-data').doc(uid).set(
                                                  {
                                                    'name' : ds!['name'],
                                                    'profilePic' : ds!['profilePic'],
                                                    'skill': skill,
                                                    'Slots' : [],
                                                    'bookings' : []
                                                  }
                                              );
                                              await Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => MainMenuMentor(uid: uid,)));

                                              setState(() {
                                                loading = false;

                                              });
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );



                          },
                          child: Container(

                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Center(
                              child: Text(
                                "Mentor",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Color.fromARGB(255, 23, 166, 255),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10,),
                      Text(
                        "Or",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 10,),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 0,horizontal: 60),
                        child: InkWell(
                          onTap: () async{

                            setState(() {
                              loading = true;

                            });
                            await FirebaseFirestore.instance.collection('userdata').doc(uid).update(
                                {

                                  'type' : "Mentee"
                                }
                            );
                            await FirebaseFirestore.instance.collection('mentees-data').doc(uid).set(
                                {
                                  'name' : ds!['name'],
                                  'profilePic' : ds!['profilePic'],
                                  'bookings' : []
                                }
                            );
                            await Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => MainMenuMentee(uid:uid)));

                            setState(() {
                              loading = false;

                            });
                          },
                          child: Container(

                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Center(
                              child: Text(
                                "Mentee",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Color.fromARGB(255, 23, 166, 255),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                  ),
            ],
          ),
        ),
      ),
    );
  }
}

class reusable extends StatelessWidget {
  const reusable({Key? key, required this.text}) : super(key: key);

  final text;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Color.fromARGB(255, 23, 166, 255), borderRadius: BorderRadius.circular(25.0)),
      height: 45.0,
      // width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.white
          ),
        ),
      ),
    );
  }
}

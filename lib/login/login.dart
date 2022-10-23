import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:look_up/mentee-screens/main_menu_mentee.dart';
import 'package:look_up/mentor-screens/main_menu_mentor.dart';
import 'package:look_up/size_config.dart';
import 'first_time_ques.dart';

bool loading = false;

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              flex: 3,
              child: Container(
                width: double.infinity,
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.only(top: 100),
                  child: Column(
                    children: [
                      Text(
                        "LOOK UP",
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 23, 166, 255),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Welcome to Look Up, lets find you a mentor!",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Image(
                          image: AssetImage("assets/images/learn.png"),
                          width: 300),
                      SizedBox(
                        height: 60,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: InkWell(
                          onTap: () async {

                            setState(() {
                              loading = true;

                            });

                            FirebaseAuth auth = FirebaseAuth.instance;
                            final gooleSignIn = GoogleSignIn();

                            GoogleSignInAccount? googleSignInAccount =
                                await gooleSignIn.signIn();
                            //
                            if (googleSignInAccount != null) {
                              GoogleSignInAuthentication
                                  googleSignInAuthentication =
                                  await googleSignInAccount.authentication;
                              AuthCredential credential =
                                  GoogleAuthProvider.credential(
                                      idToken: googleSignInAuthentication.idToken,
                                      accessToken:
                                          googleSignInAuthentication.accessToken);

                              UserCredential result =
                                  await auth.signInWithCredential(credential);

                              User? user = await auth.currentUser;

                              DocumentSnapshot ds1 = await FirebaseFirestore.instance.collection('userdata').doc(user!.uid).get();

                              if(ds1.exists){
                                print("it exists");
                              }else{
                                print("its does not exists");
                                await FirebaseFirestore.instance.collection('userdata').doc(user.uid).set(
                                    {
                                      'name' : user!.displayName,
                                      'profilePic':user!.photoURL,
                                      'type' : "none"
                                    }
                                );
                              }


                              try{

                                DocumentSnapshot ds = await FirebaseFirestore.instance.collection('userdata').doc(user.uid).get();

                                print("testing1234");

                                if(ds['type'] == "Mentor"){

                                  print("go to main menu");
                                  await Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => MainMenuMentor(uid: user.uid,)));

                                  setState(() {
                                    loading = false;

                                  });
                                  //await Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => MainWidget(uid : user.uid)));

                                }else if(ds['type'] == "Mentee"){
                                  await Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => MainMenuMentee(uid: user.uid,)));

                                  setState(() {
                                    loading = false;

                                  });
                                }else if(ds['type'] == "none"){
                                  print("ppppppppp");
                                  await Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => FirstTimeQues(uid: user!.uid,)));

                                  setState(() {
                                    loading = false;

                                  });

                                }


                              }catch(e){
                                print(e);
                              }


                              print(user!.displayName);

                             // await Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => Home()));
                            }


                          },
                          child: Container(
                            width: double.infinity,
                            height: 50,
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 23, 166, 255),
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 20),
                                      child: Text(
                                        "Sign In With Google",
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 20),
                                      child: Image(
                                          image: AssetImage(
                                              "assets/images/googleicon.png"),
                                          width: 30),
                                    ),
                                  ],
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
            ),
          ]),
    );
  }
}

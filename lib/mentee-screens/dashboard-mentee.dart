import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:look_up/loading.dart';

import 'package:look_up/login/login.dart';
import 'package:look_up/size_config.dart';


String userName = "";
class DashboardMentee extends StatefulWidget {
  final String uid;
  const DashboardMentee({Key? key, required this.uid}) : super(key: key);

  @override
  _DashboardMenteeState createState() => _DashboardMenteeState(uid);
}

class _DashboardMenteeState extends State<DashboardMentee> {
  final String uid;
  DocumentSnapshot? ds;
  List mentorsList = [];


  _DashboardMenteeState(this.uid);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserData();
  }

  void getUserData() async{
    ds = await FirebaseFirestore.instance.collection("mentees-data").doc(uid).get();
    setState(() {
      userName = ds!['name'];
    });

    await FirebaseFirestore.instance.collection('mentors-data').get().then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        setState(() {

          mentorsList.add(doc);
        });

        // print(value['Name']);
      });
    });
    setState(() {
      loading = false;

    });
  }
  @override
  Widget build(BuildContext context) {
    return loading ? Loading() :  Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40,vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(userName,
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),

                      Padding(
                        padding: const EdgeInsets.only(top: 2),
                        child: Text("Mentee",
                          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12, color: Colors.grey),),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: ClipOval(
                      child: FadeInImage.assetNetwork(
                        placeholder: 'assets/images/googleicon.png',
                        image: ds!['profilePic'],

                        width: 5.78*SizeConfig.heightMultiplier,
                        height: 5.78*SizeConfig.heightMultiplier,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ],),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color.fromARGB(255, 5, 143, 254),
                        Color.fromARGB(255, 40, 183, 252),
                      ],
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Text("Let's Find Your Mentor",
                          style: TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 20,
                          color: Colors.white),),
                      ),
                      SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(45.0),
                                color: Colors.white
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image(
                                image: AssetImage("assets/images/business-man.png"),

                                width: 30,
                                height: 30,

                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(45.0),
                                color: Colors.white
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image(
                                image: AssetImage("assets/images/laptop-icon.png"),

                                width: 30,
                                height: 30,

                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(45.0),
                                color: Colors.white
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image(
                                image: AssetImage("assets/images/notepad-icon.png"),

                                width: 30,
                                height: 30,

                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(45.0),
                                color: Colors.white
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image(
                                image: AssetImage("assets/images/mic-icon.png"),

                                width: 30,
                                height: 30,

                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 5,),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Container(
                          width: double.infinity,
                          height: 40,
                          decoration: BoxDecoration(
                              color: Colors.white, borderRadius: BorderRadius.circular(20)),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(15,0,0,5),
                              child: TextField(
                                decoration: InputDecoration(

                                    suffixIcon: IconButton(
                                      color: Color.fromARGB(255, 23, 166, 255),
                                      icon: Icon(Icons.search),
                                      onPressed: () {
                                        /* Clear the search field */
                                      },
                                    ),
                                    hintText: 'Try "Artificial Intelligence"',
                                    hintStyle: TextStyle(fontSize: 14,fontWeight: FontWeight.w600,color: Colors.grey),
                                    border: InputBorder.none),
                              ),
                            ),
                          ),

                        ),
                      )
               ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(45.0),
                      color: Color.fromARGB(255, 0, 136, 254)
                    ),
                  child:
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(

                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 0),
                          child: Column(
                            crossAxisAlignment:CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Trending\nSkills",style: TextStyle(color: Colors.white, fontSize: 16),),
                              SizedBox(height: 10,),

                              Text("\"Lets stay updated\"",style: TextStyle(color: Colors.white70, fontSize: 12,fontWeight: FontWeight.w500),)
                            ],
                          ),
                        ),
                        Image(
                          image: AssetImage("assets/images/trending-skills.png"),

                          width: 150,
                          fit: BoxFit.fill,
                        ),
                        IconButton(onPressed: (){}, icon: Icon(Icons.arrow_forward_outlined,color: Colors.white,),)

                      ],
                    ),
                  )
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Available Mentors Nearby",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
                    Text("View More",
                      style: TextStyle(fontWeight: FontWeight.w400, fontSize: 12, color: Colors.black),)

                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12),
                child: Container(
                  height: 200,

                  child: ListView.builder(

                      itemCount: mentorsList.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index){

                        return MentorCard(name: mentorsList[index]['name'], skill: mentorsList[index]['skill'], url: mentorsList[index]['profilePic'], rating: 5.0,slots: mentorsList[index]['Slots'],mentorId: mentorsList[index].id,uid: uid,);
                  }),
                ),
              ),

              FlatButton(onPressed: () async{

                User? user = await FirebaseAuth.instance.currentUser;
                FirebaseAuth auth = FirebaseAuth.instance;
                final gooleSignIn = GoogleSignIn();
                await gooleSignIn.disconnect();
                await auth.signOut();
                Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                    LoginScreen()), (Route<dynamic> route) => false);
              }, child: Text("Logout Mentee"))
            ],
          ),
        ),
      ),
    );
  }
}

class MentorCard extends StatefulWidget {
  const MentorCard({
    required this.name,
    required this.skill,
    required this.url,
    required this.rating,
    required this.slots,
    required this.mentorId,
    required this.uid,
    Key? key}) : super(key: key);

  final String name;
  final String skill;
  final String url;
  final double rating;
  final List slots;
  final String mentorId;
  final String uid;

  @override
  State<MentorCard> createState() => _MentorCardState(name,skill,url,rating, slots,mentorId,uid);
}

class _MentorCardState extends State<MentorCard> {
  final String name;
  final String skill;
  final String url;
  final double rating;
  final List slots;
  final String mentorId;
  final String uid;
  _MentorCardState(this.name, this.skill, this.url, this.rating, this.slots, this.mentorId, this.uid);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: (){


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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(name,
                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                                SizedBox(height: 5,),
                                Text(skill,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                      color: Color.fromARGB(255, 0, 136, 254),
                                      fontSize: 14),),
                              ],
                            ),
                            ClipOval(
                              child: FadeInImage.assetNetwork(
                                placeholder: 'assets/images/googleicon.png',
                                image: url,

                                width: 9.78*SizeConfig.heightMultiplier,
                                height: 9.78*SizeConfig.heightMultiplier,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10,),
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                          style: TextStyle(fontSize: 14),),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
                          child: Text("Available Slots :",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Color.fromARGB(255, 0, 136, 254),
                                fontSize: 16),),
                        ),
                        Container(
                          height: 80,
                          child: ListView.builder(

                              itemCount: slots.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index){

                                return Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10.0),
                                  child: InkWell(
                                    onTap: (){

                                      Map booking = {
                                        'mentorName' : name,
                                        'menteeName' : userName,
                                        'meetingDate' : slots[index]['Date'],
                                        'meetingStartHour' : slots[index]['Hour'],
                                        'meetingStartMin' : slots[index]['Min']
                                      };
                                      FirebaseFirestore.instance.collection('mentors-data').doc(mentorId).update({


                                        'Slots' : FieldValue.arrayRemove([slots[index]]),
                                        'bookings' : FieldValue.arrayUnion([booking]),

                                      });
                                      FirebaseFirestore.instance.collection('mentees-data').doc(uid).update({

                                        'bookings' : FieldValue.arrayUnion([booking]),

                                      });



                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20.0),
                                        gradient: LinearGradient(
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                          colors: [
                                            Color(0xfff39c52),
                                            Color(0xffFFC15A)
                                          ],
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10.0),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text(slots[index]['Date'].toDate().toString().substring(0,10),
                                              style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                                            Text(slots[index]['Hour'].toString() + ":" + slots[index]['Min'].toString() + " - " + (slots[index]['Hour'] + 1).toString() + ":" + slots[index]['Min'].toString(),
                                              style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }),
                        ),
                        SizedBox(height: 30,)




                      ],
                    ),
                  ),
                ),
              ),
            ),
          );


        },
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 80),
              child: Container(
                width: 150,
                height: 110,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(45.0),
                    color: Color.fromARGB(255, 235, 249, 255)
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 15,),
                    Text(widget.name),
                    SizedBox(height: 5,),
                    Text(widget.skill,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Color.fromARGB(255, 0, 136, 254),
                          fontSize: 10),),
                    SizedBox(height: 5,),
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.star,color: Color.fromARGB(255, 0, 136, 254),size: 15,),
                          Text(widget.rating.toString(),style: TextStyle(
                              color: Color.fromARGB(255, 0, 136, 254),
                              fontSize: 12),)
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Container(
                width: 130,
                height: 110,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(45.0),
                    color: Colors.white
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child:ClipRRect(
                    borderRadius: BorderRadius.circular(45.0),
                    child: FadeInImage.assetNetwork(
                      placeholder: 'assets/images/googleicon.png',
                      image: widget.url,

                      width: 5.78*SizeConfig.heightMultiplier,
                      //height: 5.78*SizeConfig.heightMultiplier,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}


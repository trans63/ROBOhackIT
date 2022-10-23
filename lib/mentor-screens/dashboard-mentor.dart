import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:look_up/loading.dart';
import 'package:look_up/login/login.dart';
import 'package:look_up/size_config.dart';

class DashboardMentor extends StatefulWidget {
  final String uid;
  const DashboardMentor({Key? key, required this.uid}) : super(key: key);

  @override
  _DashboardMentorState createState() => _DashboardMentorState(uid);
}

class _DashboardMentorState extends State<DashboardMentor> {
  final String uid;
  DocumentSnapshot? ds;
  List mentorsList = [];
  List bookings = [];
  String userName = "";
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();

  _DashboardMentorState(this.uid);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserData();
  }

  void getUserData() async{

    ds = await FirebaseFirestore.instance.collection("mentors-data").doc(uid).get();
    setState(() {
      userName = ds!['name'];
      bookings = ds!['bookings'];
    });

    setState(() {
      loading = false;

    });




  }
  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
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
                          child: Text("Mentor",
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
                        padding: const EdgeInsets.only(top:20.0,right: 20,left: 20,bottom: 10),
                        child: Text("You have what they need !",
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
                      SizedBox(height: 20,),
                      Padding(
                        padding: const EdgeInsets.only(left: 60.0,right:20,bottom: 5),
                        child: Text('"Knowledge is love, light and vision"',
                          style: TextStyle(
                            fontWeight:FontWeight.w500, fontSize: 15,
                              fontStyle: FontStyle.italic,
                            color: Colors.white
                          ),
                        ),
                      ),
                        SizedBox(height: 2,),
                        Padding(
                          padding: const EdgeInsets.only(left:130.0,right:30,bottom: 5),
                          child: Text("- Hellen Keller",
                            style: TextStyle(
                                fontWeight:FontWeight.w300, fontSize: 13,
                                color: Colors.white
                            ),
                      ),
                        )
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () async{
                  DateTime? date = await showDatePicker(
                      context: context,
                      initialDate: selectedDate,
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(const Duration(days: 7))
                  );

                  if(date != null){
                    setState(() {
                      selectedDate = date;
                    });
                    TimeOfDay? t = await showTimePicker(
                        context: context,
                        initialTime: selectedTime,

                    );

                    if(t != null){
                      setState(() {
                        selectedTime = t;
                      });

                      print(selectedDate);
                      print(selectedTime);
                      String mssg = 'Are you sure you want to proceed with ${selectedDate.toString().substring(0,10)} ${selectedTime.hour.toString() +":"+ selectedTime.minute.toString()}';
                      showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          title: const Text('Hold on a sec..'),
                          content: Text(mssg),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () => Navigator.pop(context, 'Cancel'),
                              child: const Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context, 'OK');

                                Map slot = {
                                  'Date' : selectedDate,
                                  'Hour' : selectedTime.hour,
                                  'Min' : selectedTime.minute
                                };



                                FirebaseFirestore.instance.collection('mentors-data').doc(uid).update({


                                  'Slots' : FieldValue.arrayUnion([slot]),

                                });
                              },
                              child: const Text('OK'),
                            ),
                          ],
                        ),
                      );




                    }

                  }

                },
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                  child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(45.0),
                          color: Color.fromARGB(255, 0, 136, 254)
                      ),
                      child:
                      Padding(
                        padding: const EdgeInsets.only(left:12.0,right: 6,bottom:12,top: 12),
                        child: Row(

                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 15.0,right:2),
                              child: Column(
                                crossAxisAlignment:CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Tell Us When\nYou're Free ?",style: TextStyle(color: Colors.white, fontSize: 18),),
                                  SizedBox(height: 10,),

                                  Text("\"So that we stay updated!\"",style: TextStyle(color: Colors.white70, fontSize: 12,fontWeight: FontWeight.w500),)
                                ],
                              ),
                            ),
                            Image(
                              image: AssetImage("assets/images/slots-logo.png"),

                              width: 130,
                              fit: BoxFit.fill,
                            ),
                            IconButton(onPressed: (){}, icon: Icon(Icons.arrow_forward_outlined,color: Colors.white,),)

                          ],
                        ),
                      )
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Scheduled Bookings",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
                    Text("",
                      style: TextStyle(fontWeight: FontWeight.w400, fontSize: 12, color: Colors.black),)

                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 18),
                child: Container(

                  //child: BookingCard(menteeName: "Prabhav Chopra", meetDate: "15.03.2022", meetTime: "18:00", meetLink: "https://meet.google.com/rup-bzdq-zhn",),

                  child: ListView.builder(

                      itemCount: bookings.length,

                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index){


                        return BookingCard(menteeName: bookings[index]['menteeName'], meetDate: bookings[index]['meetingDate'].toDate().toString(), meetTime: bookings[index]['meetingStartHour'].toString() + ":" + bookings[index]['meetingStartMin'].toString() + " - " + (bookings[index]['meetingStartHour'] + 1).toString() + ":" + bookings[index]['meetingStartMin'].toString(), meetLink: "https://meet.google.com/rup-bzdq-zhn",);
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
              }, child: Text("Logout Mentor"))
            ],
          ),
        ),
      ),
    );
  }
}

class BookingCard extends StatelessWidget {
  const BookingCard({
    required this.menteeName,
    required this.meetTime,
    required this.meetDate,
    required this.meetLink,
    Key? key}) : super(key: key);

  final String menteeName;
  final String meetTime;
  final String meetDate;
  final String meetLink;


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: double.infinity,
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
          padding: const EdgeInsets.all(15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Mentee : ${menteeName}", style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),),
                  SizedBox(height: 2,),
                  Text("Date : ${meetDate.substring(0,10)}", style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold),),
                  SizedBox(height: 2,),
                  Text("Time : $meetTime", style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold),),
                  SizedBox(height: 2,),
                ],
              ),
              Icon(Icons.male,color: Color.fromARGB(255, 23, 166, 255),size: 50,)
            ],
          ),
        ),
      ),
    );
  }
}


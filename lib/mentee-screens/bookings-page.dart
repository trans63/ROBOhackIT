import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:look_up/loading.dart';
import 'package:look_up/login/login.dart';
import 'package:look_up/size_config.dart';


class BookingsPage extends StatefulWidget {
  final String uid;
  const BookingsPage({Key? key, required this.uid}) : super(key: key);

  @override
  _BookingsPageState createState() => _BookingsPageState(uid);
}

class _BookingsPageState extends State<BookingsPage> {
  final String uid;

  DocumentSnapshot? ds;
  List bookings = [];
  String userName = "";
  _BookingsPageState(this.uid);

  void initState() {
    // TODO: implement initState
    super.initState();
    getUserData();
  }

  void getUserData() async{

    ds = await FirebaseFirestore.instance.collection("mentees-data").doc(uid).get();
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
    return loading ? Loading() : SafeArea(
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
                              Text("Your Important \nDates ..",style: TextStyle(color: Colors.white, fontSize: 18),),
                              SizedBox(height: 10,),

                              Text("\"Dont miss out on them\"",style: TextStyle(color: Colors.white70, fontSize: 12,fontWeight: FontWeight.w500),)
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

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Scheduled Bookings",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
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


                      return BookingCard(mentorName: bookings[index]['mentorName'], meetDate: bookings[index]['meetingDate'].toDate().toString(), meetTime: bookings[index]['meetingStartHour'].toString() + ":" + bookings[index]['meetingStartMin'].toString() + " - " + (bookings[index]['meetingStartHour'] + 1).toString() + ":" + bookings[index]['meetingStartMin'].toString(), meetLink: "https://meet.google.com/rup-bzdq-zhn",);
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BookingCard extends StatelessWidget {
  const BookingCard({
    required this.mentorName,
    required this.meetTime,
    required this.meetDate,
    required this.meetLink,
    Key? key}) : super(key: key);

  final String mentorName;
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
                  Text("Mentor : ${mentorName}", style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),),
                  SizedBox(height: 2,),
                  Text("Date : ${meetDate.substring(0,10)}", style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold),),
                  SizedBox(height: 2,),
                  Text("Time : $meetTime", style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold),),
                  SizedBox(height: 2,),
                  Text("Meeting Link : \nmeet.google.com/iox-mwjd-bqk", style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold),),
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

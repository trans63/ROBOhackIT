import 'package:flutter/material.dart';
import 'package:look_up/loading.dart';
import 'package:look_up/login/login.dart';

class BlogsScreen extends StatefulWidget {
  const BlogsScreen({Key? key}) : super(key: key);

  @override
  _BlogsScreenState createState() => _BlogsScreenState();
}

class _BlogsScreenState extends State<BlogsScreen> {
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
    return loading ? Loading() : SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(12,25,12,15),
              child: Text("Blogs",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(12,25,12,0),
              child: Container(
                height: 160,
                margin: EdgeInsets.only(bottom: 15),
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image(
                        image: AssetImage("assets/images/trending-skills.png"),

                        width: MediaQuery.of(context).size.width,

                        fit: BoxFit.cover,
                      ),
                    ),
                    Container(
                      height: 160,
                      decoration: BoxDecoration(
                          color: Colors.black45.withOpacity(0.4),
                          borderRadius: BorderRadius.circular(15)
                      ),
                    ),
                    Container(
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(height: 6,),
                            Text("Is A.I really worth the hype ?",
                              style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.w600),
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,),
                            SizedBox(height: 4,),
                            Text("By : Prof. Andrew NG",
                              style: TextStyle(color: Colors.white,fontSize: 17,),
                              textAlign: TextAlign.center,)

                          ],

                        )
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 12),
              child: Container(
                height: 160,
                margin: EdgeInsets.only(bottom: 15),
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image(
                        image: AssetImage("assets/images/shop_banner.jpg"),

                        width: MediaQuery.of(context).size.width,

                        fit: BoxFit.cover,
                      ),
                    ),
                    Container(
                      height: 160,
                      decoration: BoxDecoration(
                          color: Colors.black45.withOpacity(0.4),
                          borderRadius: BorderRadius.circular(15)
                      ),
                    ),
                    Container(
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(height: 6,),
                            Text("Blockchain : The Backbone of every modern technology ?",
                              style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.w600),
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,),
                            SizedBox(height: 4,),
                            Text("By : Prof. Aryan Chowfla",
                              style: TextStyle(color: Colors.white,fontSize: 17,),
                              textAlign: TextAlign.center,)

                          ],

                        )
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 12),
              child: Container(
                height: 160,
                margin: EdgeInsets.only(bottom: 15),
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image(
                        image: AssetImage("assets/images/trending-skills.png"),

                        width: MediaQuery.of(context).size.width,

                        fit: BoxFit.cover,
                      ),
                    ),
                    Container(
                      height: 160,
                      decoration: BoxDecoration(
                          color: Colors.black45.withOpacity(0.4),
                          borderRadius: BorderRadius.circular(15)
                      ),
                    ),
                    Container(
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(height: 6,),
                            Text("A few of the best analytical case studies to solve",
                              style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.w600),
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,),
                            SizedBox(height: 4,),
                            Text("By : Aryan Chowfla",
                              style: TextStyle(color: Colors.white,fontSize: 17,),
                              textAlign: TextAlign.center,)

                          ],

                        )
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

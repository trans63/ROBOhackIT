import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:look_up/constants.dart';
import 'package:look_up/controllers/question_controller.dart';

import 'package:flutter_svg/svg.dart';

class ScoreScreen extends StatefulWidget {
  final String uid;

  const ScoreScreen({Key? key, required this.uid}) : super(key: key);
  @override
  State<ScoreScreen> createState() => _ScoreScreenState(uid);
}

class _ScoreScreenState extends State<ScoreScreen> {
  final String uid;
  _ScoreScreenState(this.uid);

  @override
  Widget build(BuildContext context) {
    QuestionController _qnController = Get.put(QuestionController(""));

    FirebaseFirestore.instance.collection('mentors-data').doc(uid).update({


      'Score' : _qnController.correctAns * 5,

    });
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          SvgPicture.asset("assets/icons/bg.svg", fit: BoxFit.fill),
          Column(
            children: [
              Spacer(flex: 3),
              Text(
                "Score",
                style: Theme.of(context)
                    .textTheme
                    .headline3
                    ?.copyWith(color: kSecondaryColor),
              ),
              Spacer(),
              // Container(
              //   decoration: BoxDecoration(
              //     borderRadius: BorderRadius(45.0)
              //   ),
              //   child:
                Text(
                  "${_qnController.correctAns * 5}/${_qnController.questions.length * 5}",
                  style: Theme.of(context)
                      .textTheme
                      .headline4
                      ?.copyWith(color: kSecondaryColor),
                ),
              // ),
              Spacer(flex: 3),
            ],
          )
        ],
      ),
    );
  }
}

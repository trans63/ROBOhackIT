import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:look_up/controllers/question_controller.dart';


import 'components/body.dart';

class QuizScreen extends StatefulWidget {
  final String uid;

  const QuizScreen({Key? key, required this.uid}) : super(key: key);
  @override
  State<QuizScreen> createState() => _QuizScreenState(uid);
}

class _QuizScreenState extends State<QuizScreen> {
  final String uid;

  _QuizScreenState(this.uid);
  @override
  Widget build(BuildContext context) {
    QuestionController _controller = Get.put(QuestionController(uid));
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        // Fluttter show the back button automatically
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          FlatButton(onPressed: _controller.nextQuestion, child: Text("Skip")),
        ],
      ),
      body: Body(),
    );
  }
}

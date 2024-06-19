import 'package:flutter/material.dart';
import 'package:hackpue/constants.dart';
import 'package:hackpue/pages/chat/quiz/questionTab.dart';

class quizChat extends StatefulWidget {
  const quizChat({super.key});

  @override
  State<quizChat> createState() => _quizChatState();
}

class _quizChatState extends State<quizChat> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
          length: 3,
          child: Scaffold(
            appBar: AppBar(
              title: Text(
                'Send sensor data',
                style: TextStyle(fontSize: 15),
              ),
              backgroundColor: Colors.purple[100],
              bottom: TabBar(tabs: [
                Tab(
                  icon: Icon(Icons.boy_rounded),
                  text: 'sensor 1',
                ),
                Tab(
                  icon: Icon(Icons.boy_rounded),
                  text: 'sensor 2',
                ),
                Tab(
                  icon: Icon(Icons.boy_rounded),
                  text: 'sensor 3',
                )
              ]),
            ),
            body: TabBarView(
                children: [questionTab(), questionTab(), questionTab()]),
          )),
    );
  }
}

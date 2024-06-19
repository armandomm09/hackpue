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
          length: 5,
          child: Scaffold(
            appBar: AppBar(
              title: Text(
                'Quiz',
                style: TextStyle(fontSize: 20),
              ),
              backgroundColor: backgroundGlobal,
              bottom: TabBar(
                  dividerHeight: 3,
                  dividerColor: Colors.grey[40],
                  indicatorColor: lavender,
                  tabAlignment: TabAlignment.center,
                  tabs: [
                    Tab(
                      icon: Icon(
                        Icons.question_mark,
                        color: lavender,
                      ),
                    ),
                    Tab(
                      icon: Icon(
                        Icons.question_mark,
                        color: lavender,
                      ),
                    ),
                    Tab(
                      icon: Icon(
                        Icons.question_mark,
                        color: lavender,
                      ),
                    ),
                    Tab(
                      icon: Icon(
                        Icons.question_mark,
                        color: lavender,
                      ),
                    ),
                    Tab(
                      icon: Icon(
                        Icons.question_mark,
                        color: lavender,
                      ),
                    ),
                  ]),
            ),
            body: TabBarView(children: [
              questionTab(
                index: 0,
              ),
              questionTab(index: 1),
              questionTab(index: 2),
              questionTab(
                index: 3,
              ),
              questionTab(
                index: 4,
              )
            ]),
          )),
    );
  }
}

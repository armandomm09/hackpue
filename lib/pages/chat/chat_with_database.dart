import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hackpue/components/appTextField.dart';
import 'package:hackpue/components/chat/chat_bubble.dart';
import 'package:hackpue/constants.dart';
import 'package:hackpue/pages/chat/quiz/AI/quizChatAI.dart';
import 'package:hackpue/services/auth/auth_service.dart';
import 'package:hackpue/services/chat/chatWithGpt.dart';

class ChatWithDatabase extends StatefulWidget {
  const ChatWithDatabase({super.key});

  @override
  State<ChatWithDatabase> createState() => _ChatWithDatabaseState();
}

class _ChatWithDatabaseState extends State<ChatWithDatabase> {
  FocusNode focusNode = FocusNode();
  ScrollController scrollController = ScrollController();

  final AuthService authService = AuthService();

  @override
  void initState() {
    scrollDown();
    super.initState();
  }

  @override
  void dispose() {
    focusNode.dispose();
    messageController.dispose();
    scrollController.dispose();
    super.dispose();
  }

  scrollDown() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollController.hasClients) {
        scrollController.jumpTo(scrollController.position.maxScrollExtent);
      }
    });
  }

  TextEditingController messageController = TextEditingController();

  buildUserInput() {
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(color: backgroundGlobal),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              width: 300,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: AppTextField(
                  desiredColor: deepPurple,
                  focusNode: focusNode,
                  textt: "Message",
                  controller: messageController,
                ),
              ),
            ),
            Container(
                decoration: BoxDecoration(
                  color: lavender,
                  shape: BoxShape.circle,
                ),
                height: 70,
                child: IconButton(
                  onPressed: () {
                    GPTService.newGptMessage(messageController.text);
                    //ScoutGPTService.newGptMessage(messageController.text);
                    messageController.text = '';
                  },
                  icon: Icon(
                    Icons.send_rounded,
                    size: 25,
                    color: deepPurple,
                  ),
                ))
          ],
        ),
      ),
    );
  }

  buildMessageList() {
    return StreamBuilder(
        stream: GPTService.getMessages(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text("There was an error");
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("Loading...");
          }
          scrollDown();
          return ListView(
            controller: scrollController,
            children: snapshot.data!.docs
                .map((doc) => buildMessageItem(doc))
                .toList(),
          );
        });
  }

  Widget buildMessageItem(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    bool isCurrentUser = data["senderId"] == authService.getCurrentUser()!.uid;

    var alignment =
        isCurrentUser ? Alignment.centerRight : Alignment.centerLeft;

    return Container(
      alignment: alignment,
      child: Column(
        crossAxisAlignment:
            isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          ChatBubble(message: data["question"], isCurrentUser: isCurrentUser),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundGlobal,
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => quizChat()));
              },
              icon: Icon(Icons.question_mark_outlined))
        ],
        backgroundColor: deepPurple, //Theme.of(context).colorScheme.primary,
        elevation: 50,
        foregroundColor: pink,
        title: Text(
          "Chat with AI",
          style: TextStyle(color: backgroundGlobal),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
            children: [Expanded(child: buildMessageList()), buildUserInput()]),
      ),
    );
  }
}

import 'dart:ui';

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

  Widget imageOverlayer = Container();

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

  setImageOverlay(String url) {
    setState(() {
      imageOverlayer = Stack(children: [
        Positioned.fill(
            child: GestureDetector(
          onTap: () => removeOverlayer,
          child: Container(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 0),
              child: Container(
                color: Colors.transparent,
              ),
            ),
          ),
        )),
        Center(
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: InteractiveViewer(
                  child: Image.network(
                    url,
                    width: MediaQuery.of(context).size.width - 20,
                  ),
                ),
              ),
              Positioned(
                  top: 0,
                  right: 10,
                  child: IconButton(
                    onPressed: removeOverlayer,
                    icon: const Icon(Icons.remove),
                    iconSize: 40,
                    color: Colors.amber,
                  ))
            ],
          ),
        ),
      ]);
    });
  }

  removeOverlayer() {
    print('REMOVING OVERLAYER');
    setState(() {
      imageOverlayer = Container();
    });
  }

  Widget buildMessageItem(DocumentSnapshot doc) {
    try {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

      bool isCurrentUser =
          data["senderId"] == authService.getCurrentUser()!.uid;

      var alignment =
          isCurrentUser ? Alignment.centerRight : Alignment.centerLeft;

      return Container(
        alignment: alignment,
        child: Column(
          crossAxisAlignment:
              isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            if (!data["question"].toString().contains(
                'oaidalleapiprodscus.blob.core.windows.net')) // Mostrar el mensaje si existe
              ChatBubble(
                  message: data["question"], isCurrentUser: isCurrentUser),
            if (data["question"].toString().contains(
                'oaidalleapiprodscus.blob.core.windows.net')) // Mostrar la imagen si existe
              GestureDetector(
                onTap: () {
                  print('SETTING OVERLAY');
                  setImageOverlay(data['question']);
                },
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  child: Container(
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(8)),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(data['question'], height: 200)),
                  ),
                ),
              ),
          ],
        ),
      );
    } catch (e) {
      return Container();
    }
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
        child: Container(
          child: Stack(
            children: [
              Column(children: [
                Expanded(child: buildMessageList()),
                buildUserInput()
              ]),
              imageOverlayer
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hackpue/components/appTextField.dart';
import 'package:hackpue/components/chat/chat_bubble.dart';
import 'package:hackpue/constants.dart';
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
    return Container(
      decoration: BoxDecoration(color: Theme.of(context).colorScheme.primary),
      child: Row(
        children: [
          Expanded(
            child: AppTextField(
              focusNode: focusNode,
              textt: "Message",
              controller: messageController,
            ),
          ),
          Container(
              decoration: const BoxDecoration(
                color: Colors.green,
                shape: BoxShape.circle,
              ),
              height: 70,
              margin: const EdgeInsets.only(right: 25),
              child: IconButton(
                onPressed: () {
                  GPTService.newGptMessage(messageController.text);
                  //ScoutGPTService.newGptMessage(messageController.text);
                  messageController.text = '';
                },
                icon: const Icon(
                  Icons.send,
                ),
              ))
        ],
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
        backgroundColor:
            backgroundGlobal, //Theme.of(context).colorScheme.primary,
        elevation: 50,
        foregroundColor: Theme.of(context).colorScheme.primary,
        title: Text(
          "Scout GPT",
          style: TextStyle(color: deepPurple),
        ),
      ),
      body: Column(
          children: [Expanded(child: buildMessageList()), buildUserInput()]),
    );
  }
}

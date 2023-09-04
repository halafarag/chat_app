import 'package:chat_app2/models/message.dart';
import 'package:chat_app2/widgets/chat_buble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../constant.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({super.key});
  static String id = 'ChatPage';
  final _controller =  ScrollController();
  CollectionReference messages =
      FirebaseFirestore.instance.collection('messages');
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    String email= ModalRoute.of(context)!.settings.arguments as String;
    return StreamBuilder<QuerySnapshot>(
        stream: messages.orderBy('createdAt',descending: true).snapshots(),
        builder: (context, snapshot) {
          List<Message> messagesList = [];
         if (snapshot.hasData) {
            for (int i = 0; i < snapshot.data!.docs.length; i++) {
              messagesList.add(Message.fromJson(snapshot.data!.docs[i]));
            }
            return Scaffold(
              appBar: AppBar(
                backgroundColor: kPrimary,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Scholar Chat'),
                    Image.asset(
                      'assets/images/photo.png.webp',
                      height: 50,
                    )
                  ],
                ),
              ),
              body: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      reverse: true,
                      controller: _controller,
                      itemCount: messagesList.length,
                      itemBuilder: (context, index) {
                        return messagesList[index].id==email?  CustomChatBuble(
                          message: messagesList[index],
                        ):CustomChatBubleForSecond(
                          message: messagesList[index],
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(16),
                    child: TextField(
                      controller: controller,
                      onSubmitted: (data) {
                        messages.add({
                          'message': data,
                          'createdAt':DateTime.now(),
                          'id':email
                        });
                        controller.clear();
                        // scrolling to the end of a ListView
                        _controller.animateTo(
                         0,
                          curve: Curves.easeIn,
                          duration: const Duration(milliseconds: 500),
                        );
                      },
                      decoration: InputDecoration(
                        hintText: 'sendMessage',
                        suffixIcon: const Icon(
                          Icons.send,
                          color: kPrimary,
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16)),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: const BorderSide(color: kPrimary),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            );


         } else {
           return  Text('loading...');
          }

        });
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:o_messaging_chat_app/main.dart';

class ChatUserCard extends StatefulWidget {
  const ChatUserCard({super.key});

  @override
  State<ChatUserCard> createState() => _ChatUserCardState();
}

class _ChatUserCardState extends State<ChatUserCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
       color: Colors.deepPurple.shade100,
      elevation: 0.5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: EdgeInsets.symmetric(horizontal: mq.width * .04, vertical: 4),
      child: InkWell(
        onTap: () {
        },
        child: const ListTile(
          leading: CircleAvatar(child: Icon(CupertinoIcons.person),),
          title: Text("zia khan"),
          subtitle: Text("Last user message",maxLines: 1,),
          trailing: Text("12 P.M"),
        ),
      ),
    );
  }
}
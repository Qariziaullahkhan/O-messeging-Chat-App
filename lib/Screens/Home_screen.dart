import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:o_messaging_chat_app/API/Api.dart';
import 'package:o_messaging_chat_app/widgets/chat_user_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _Home_ScreenState();
}

class _Home_ScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
    appBar: AppBar(
      backgroundColor: Colors.white,
      title: Text("Home Screen"),
      leading: const Icon(CupertinoIcons.home),
      actions: [
IconButton(onPressed: (){}, icon: Icon(Icons.search)),
IconButton(onPressed: (){}, icon: Icon(Icons.more_vert)),


      ],
    ),
    floatingActionButton: FloatingActionButton(onPressed: ()async{
      await FirebaseAuth.instance.signOut();
      await GoogleSignIn().signOut();
    },
    child: Icon(Icons.add_comment_rounded),
    ),
    body: StreamBuilder(stream: APIS.firestore.collection("users").snapshots(), 
    builder: (context, snapshot) {
      if(snapshot.hasData){
        final data = snapshot.data?.docs;

        for(var i in data!){
          print("Data: ${i.data()}");
        }
      }
      return ListView.builder(
      itemCount: 15,
      itemBuilder: (context,index){
return const ChatUserCard();
      });
      
    },
    )
    );
  }
}
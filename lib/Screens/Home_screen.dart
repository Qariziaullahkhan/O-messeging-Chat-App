import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:o_messaging_chat_app/API/Api.dart';
import 'package:o_messaging_chat_app/Models/user_model.dart';
import 'package:o_messaging_chat_app/Screens/profile_screen.dart';
import 'package:o_messaging_chat_app/widgets/chat_user_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _Home_ScreenState();
}

class _Home_ScreenState extends State<HomeScreen> {
    List<ChatUser> _list = [];

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
    appBar: AppBar(
      backgroundColor: Colors.white,
      title: Text("Home Screen"),
      leading: const Icon(CupertinoIcons.home),
      actions: [
IconButton(onPressed: (){}, icon: Icon(Icons.search)),
IconButton(onPressed: (){

  Navigator.push(context, MaterialPageRoute(builder: (_)=>  ProfileScreen(user: _list[0])));
}, icon: Icon(Icons.more_vert)),


      ],
    ),
    floatingActionButton: FloatingActionButton(onPressed: ()async{
      await FirebaseAuth.instance.signOut();
      await GoogleSignIn().signOut();
    },
    child: Icon(Icons.add_comment_rounded),
    ),
    body: StreamBuilder(stream: APIS.getAllusers(),
    builder: (context, snapshot) {
      switch(snapshot.connectionState){
          case ConnectionState.waiting:
              case ConnectionState.none:
                return const Center(child: CircularProgressIndicator());

            //Some or All data is loaded then show it
              case ConnectionState.active:
              case ConnectionState.done:
               final list = [];
        final data = snapshot.data?.docs;
        _list =
      
                          data?.map((e) => ChatUser.fromJson(e.data())) 
                              .toList() ?? [];
        if(list.isNotEmpty){
return ListView.builder(
      itemCount: list.length,
      itemBuilder: (context,index){
return ChatUserCard(user: list[index],);
      });
        }else{
          return const Text("No  connections found ");
        }
      
      }
    },
    )
    );
  }
}
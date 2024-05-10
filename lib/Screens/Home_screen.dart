import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
    floatingActionButton: FloatingActionButton(onPressed: (){},
    child: Icon(Icons.add_comment_rounded),
    ),
    );
  }
}
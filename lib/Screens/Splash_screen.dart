import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../main.dart';
import '../widgets/Custom_Appbar.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
Future.delayed(Duration(seconds: 5),(){
  Navigator.of(context).push(MaterialPageRoute(builder: (context){
    return const LoginScreen();
  }));
});
    super.initState();
  }
 
  @override
  Widget build(BuildContext context) {
        mq = MediaQuery.of(context).size;

    return   Scaffold(
      appBar: CustomAppbar(
        titleText: "Splash Screen"),
      body: Stack(children: [ Positioned(
        
        top: mq.height *.15,
        right: mq.width *.25,
                 width: mq.width *.5,   
        child: Image.asset("images/conversation.png")),
        
          Positioned(
            bottom: mq.height * .15,
            width: mq.width,
            
            child:   const Text("Chat App",
            textAlign: TextAlign.center,
            
            style: TextStyle(
              letterSpacing: 2,
              
              fontSize: 40,fontWeight: FontWeight.bold,color: Colors.black),))
      ],
        
      ),
      
    );
  }
}
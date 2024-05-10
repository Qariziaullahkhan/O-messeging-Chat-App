import 'package:flutter/material.dart';

import '../main.dart';
import '../widgets/Custom_Appbar.dart';
import 'Home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _Login_ScreenState();
}

class _Login_ScreenState extends State<LoginScreen> {

  @override
  void initState() {


    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    return  Scaffold(
      appBar: CustomAppbar(titleText: "Login Screen"),
      body: Stack(
        children: [
          
               Positioned(
             bottom: mq.height *.15,
            left: mq.width *.05,
         width: mq.width *.9,  
         height: mq.height *.07,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.lightBlue,
                elevation: 1,
              ),
onPressed: (){

  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: 
  (context){
    return const HomeScreen();
  }));
}, icon: Image.asset("images/google.png",height: mq.height *0.06,), 
              
              label: RichText(text:const TextSpan(
                style: TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.w700),
              children: [
                TextSpan(
                  text: "Login in "
                ),
                TextSpan(
                  text: "Google"
                ),
              ]
              )))),
        ],
      ),
    );
  }
}
import 'dart:io';
import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:o_messaging_chat_app/API/Api.dart';
import 'package:o_messaging_chat_app/Helpers/dialogs.dart';

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
   _Handlegooglebtnclikc(){
 Dialogs.showProgressIndicator(context);
signInWithGoogle().then((User) async{
  Navigator.pop(context);
  if(User != null){
print("user :${User.user}");
print("additional Information: ${User.additionalUserInfo}");
if(( await APIS.userExists())){
 Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
      return const HomeScreen();
    }));
}
else{
  APIS.createUser().then((value) {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
      return const HomeScreen();
    }));
  });
}

  

}
}
);
  }
  Future<UserCredential?> signInWithGoogle() async {
  // Trigger the authentication flow
 try{
  await InternetAddress.lookup("google.com");
   final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  // Obtain the auth details from the request
  final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

  // Create a new credential
  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth?.accessToken,
    idToken: googleAuth?.idToken,
  );

  // Once signed in, return the UserCredential
  return await FirebaseAuth.instance.signInWithCredential(credential);
 }
 catch(e){
print("/nsignInWithGoogle:$e");
 Dialogs.showSnackbar(context, 'Something went wrong (Check Internet Connection!)');
      return null;
 }
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
_Handlegooglebtnclikc();
  
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
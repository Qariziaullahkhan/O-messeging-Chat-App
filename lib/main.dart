import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:o_messaging_chat_app/Screens/Splash_screen.dart';
import 'package:o_messaging_chat_app/Screens/login_screen.dart';
import 'package:o_messaging_chat_app/Screens/profile_screen.dart';
late Size mq;
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: 
  const FirebaseOptions(apiKey: "AIzaSyCEgP9mbnJYfQAxERYLjooUlXd4EyvrlVM", 
  appId: "1:845932572618:android:79185d8d1c4e686430a933",
   messagingSenderId: "845932572618", 
   projectId:  "o-messeging-chat-app",
   storageBucket: "o-messeging-chat-app.appspot.com"
   ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
      
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: SplashScreen(),
    );
  }
}


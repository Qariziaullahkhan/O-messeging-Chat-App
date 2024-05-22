import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../Models/user_model.dart';

class APIS{

  static FirebaseAuth auth = FirebaseAuth.instance;
  static FirebaseFirestore firestore = FirebaseFirestore.instance;
  static late ChatUser me;

  //To Return current user
  static User get user => auth.currentUser!;
  //for accessing firebase messaging (Push Notifications)
   static Future<bool> userExists() async {
    return (await firestore.collection('users').doc(user.uid).get()).exists;
  }

  static Future<void> getSelfInfo() async {
     await firestore.collection('users').doc(user.uid).get().then((user){
   if (user.exists) {
        //If User Exists store it in me
        me = ChatUser.fromJson(user.data()!);
print("My data :${user.data()}");     
   //For setting user status to active
        // APIS.updateActiveStatus(true);
      } else {
        //If Not Exists then create one & store it in me by calling getSelfInfo ftn again
         createUser().then((value) => getSelfInfo());
      }
    });    
  }
  static Future<void> createUser() async {
    final time = DateTime
        .now()
        .millisecondsSinceEpoch
        .toString();
    final chatUser = ChatUser(
      id: user.uid,
      name: user.displayName.toString(),
      email: user.email.toString(),
      image: user.photoURL.toString(),
      about: "Hey, I'm using O Msg",
      createdAt: time,
      isOnline: false,
      lastActive: time,
      pushToken: '',
    );

    return await firestore
        .collection('users')
        .doc(user.uid)
        .set(chatUser.toJson());
  }
  static Stream<QuerySnapshot<Map<String, dynamic>>>  getAllusers()
  {
    return  APIS.firestore.collection("users").where("id",isNotEqualTo: user.uid).snapshots();
  }
     static Future<void> updateUseerInfo() async {
     await firestore.collection('users').doc(user.uid).update({
"name":me.name,
"about":me.about,

     });
  }
  }

  

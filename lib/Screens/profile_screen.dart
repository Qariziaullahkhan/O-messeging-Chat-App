import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:o_messaging_chat_app/API/Api.dart';
import 'package:o_messaging_chat_app/Helpers/dialogs.dart';
import 'package:o_messaging_chat_app/Models/user_model.dart';
import 'package:o_messaging_chat_app/Screens/login_screen.dart';
import 'package:o_messaging_chat_app/widgets/chat_user_card.dart';

import '../main.dart';

class ProfileScreen extends StatefulWidget {
  final ChatUser user;
   ProfileScreen({super.key, required this.user});

  @override
  State<ProfileScreen> createState() => _Home_ScreenState();
}

class _Home_ScreenState extends State<ProfileScreen> {
  final _formkey= GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Profile Screen"),
        leading: const Icon(CupertinoIcons.home),
        actions: [
      IconButton(onPressed: (){}, icon: Icon(Icons.search)),
      IconButton(onPressed: (){}, icon: Icon(Icons.more_vert)),
      
      
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(onPressed: ()async{
        Dialogs.showProgressIndicator(context);
        await FirebaseAuth.instance.signOut().then((value) async{
        await GoogleSignIn().signOut().then((value) {
      Navigator.pop(context);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
        return const LoginScreen();
      }));
        });
        });
      
      },
      backgroundColor: Colors.redAccent,
      icon: Icon(Icons.logout,color: Colors.red,),
      label: const Text("Log Out"),
      ),
      body: Form(
        key: _formkey,
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: mq.width * .05),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  width: mq.width ,height: mq.height *.03,
                ),
                Stack(
                  children: [
                    ClipRRect(
                        borderRadius: BorderRadius.circular(mq.height * .3),
                          
                        child: CachedNetworkImage(
                          width: mq.height * .055,
                          height: mq.width *.055,
                          fit: BoxFit.fill,
                                imageUrl: widget.user.image,
                                // placeholder: (context, url) => const CircularProgressIndicator(),
                                errorWidget: (context, url, error) =>  CircleAvatar(
                                  radius: 100,
                                  child: Icon(CupertinoIcons.person),),
                             ),
                             
                      ),
                      
                      Positioned(
                        bottom: 0,
                        top: 0,
                        
                        child: MaterialButton(onPressed: (){},
                        shape: CircleBorder(),
                        elevation: 1,
                        color: Colors.white,
                        child: Icon(Icons.edit,color: Colors.blue,),),
                      )
                  ],
                ),
                    SizedBox(
                  width: mq.width ,height: mq.height *.03,
                ),
                Text(widget.user.email,style: TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.w200),),
             SizedBox(
                height: mq.height *.03,
                ),
                TextFormField(

                  initialValue: widget.user.name,
                  onSaved: (value) =>APIS.me.name = value  ?? "",
                validator: (value) => value != null && value.isNotEmpty? null:"Required Field",
                  decoration: InputDecoration(
                    border:  OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                    ),
                    hintText: "Android developers",
                    labelText: "Name",
                    prefix: Icon(Icons.person,color: Colors.blue,),
                  ),
                ),
                    SizedBox(
                  width: mq.width ,height: mq.height *.03,
                ),
             TextFormField(
                  initialValue: widget.user.about,
                   onSaved: (value) =>APIS.me.about = value  ?? "",
                validator: (value) => value != null && value.isNotEmpty? null:"Required Field",
                  decoration: InputDecoration(
                    border:  OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                    ),
                    hintText: "Hi, I am using Chat App",
                    labelText: "About",
                    prefix: Icon(Icons.info_outline,color: Colors.blue,),
                  ),
                ),
                const Gap(20),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape:const StadiumBorder(
                    
                    ),
                    minimumSize: Size(mq.width *.05, mq.height *.05),
                  ),
                  onPressed: (){
                    if(_formkey.currentState!.validate()){
                    _formkey.currentState!.save();
                    APIS.updateUseerInfo().then((Value){
Dialogs.showSnackbar(context, "Profile Update Succesfully");
                    });
                      print("inside validator");
                    }
                  }, icon: Icon(Icons.edit,color: Colors.white,), label: const Text("UPDATE",style: const TextStyle(color: Colors.white,fontSize: 16),))
              ],
            ),
          ),
        ),
      )
      ),
    );
  }
}
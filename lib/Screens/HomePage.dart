import 'package:chat1/Screens/loginPage.dart';
import 'package:chat1/models/user_profil.dart';
import 'package:flutter/material.dart';
import'package:chat1/Screens/chatPage.dart';
import 'package:chat1/Screens/loginPage.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget{

  const HomePage({super.key,  required this.user});
  final UserProvider user;


  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {

    print(user.getuserId().toString()+"hehehe");
    return Scaffold(
      body: 
      ChatPage(user : user), 
    );
    
    ;
  }
}
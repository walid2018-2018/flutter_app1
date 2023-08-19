import 'package:chat1/Screens/HomePage.dart';
import 'package:chat1/Screens/chatDetailPage.dart';
import 'package:chat1/Screens/loginPage.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(MyApp());
}





class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'test chat',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ) ,
      debugShowCheckedModeBanner: false,
      
       home: loginPage(),
     //  home: HomePage(),
    
     
    );
  }
  
}
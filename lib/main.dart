/*import 'dart:ffi';

import 'package:flutter/material.dart';



void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor:Colors.green ,
          title: const Text('Drive Test Chatbot'),        
        ),

        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
                 ), 
            BottomNavigationBarItem(
              icon: Icon(Icons.business),
              label: 'Business',
                 ), 
            BottomNavigationBarItem(
              icon: Icon(Icons.school),
              label: 'School',
                 ), 
          ], 
          
        ),
        
        drawer: Drawer(
          child: Text('Yo!'),

        ),

        ),
        );
      
  }
}
*/

import 'package:chat1/Screens/HomePage.dart';
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
     /// home: HomePage(),
     
    );
  }
  
}
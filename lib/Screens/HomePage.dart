import 'package:chat1/Screens/loginPage.dart';
import 'package:chat1/models/user_profil.dart';
import 'package:flutter/material.dart';
import'package:chat1/Screens/chatPage.dart';
import 'package:chat1/Screens/loginPage.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget{
  //int user_id;
  //String username;
 // final User user ; 

//  HomePage();
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
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.indigo[500],
        unselectedItemColor: Colors.grey.shade600,
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.w600),
        unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w600),
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: 'Chat',
            
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.group_work),
            label: 'Groupes',
            
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_box),
            label: 'Profile',
          ),
        ],
      ),
    );
    
    ;
  }
}
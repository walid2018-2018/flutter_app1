import 'package:flutter/material.dart';
import'package:chat1/Screens/chatPage.dart';



class HomePage extends StatefulWidget{
  int user_id;
  String username;

  HomePage({required this.user_id,required this.username});



  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChatPage(user_id: widget.user_id, username: widget.username), 
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
import 'package:chat1/Screens/helpPage.dart';
import 'package:flutter/material.dart';


 
class helpPage extends StatefulWidget {

  
  @override
  _helpPageState createState() => _helpPageState();
}


class _helpPageState extends State<helpPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo[900],
        title: Text('Help' , style: TextStyle( fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: Colors.white),
            ),
        
      ),
    );
  }


}
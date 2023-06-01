import 'package:chat1/Screens/chatPage.dart';
import 'package:chat1/Screens/resgistrationPage.dart';
import 'package:flutter/material.dart';
 
 
class profilPage extends StatefulWidget {
  @override
    _profilPagetState createState() => _profilPagetState(); 

}


class _profilPagetState extends State<profilPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile Details'),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            CircleAvatar(
              radius: 60.0,
              backgroundImage: AssetImage('Assets/images/image1.jpg'), // Replace with your own image path
            ),
            SizedBox(height: 16.0),
            Text(
              'Walid Ighil',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text(
              'Drive tester Alger',
              style: TextStyle(fontSize: 18.0, color: Colors.grey),
            ),
            SizedBox(height: 16.0),
            Divider(),
            SizedBox(height: 16.0),
            Text(
              'About Me',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text(
              'Statut En ligne',
              style: TextStyle(fontSize: 16.0),
            ),
             SizedBox(height: 8.0),
            Text(
              ' Changer le compte.',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 8.0),
            Text(
              ' Aide',
              style: TextStyle(fontSize: 16.0),
            ),
          ],
        ),
      ),
    );
  }
}

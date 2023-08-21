import 'package:chat1/Screens/chatPage.dart';
import 'package:chat1/Screens/resgistrationPage.dart';
import 'package:flutter/material.dart';
 import 'package:chat1/models/globals.dart' as globals;
 
class profilPage extends StatefulWidget {
  @override
    _profilPagetState createState() => _profilPagetState(); 

}


class _profilPagetState extends State<profilPage> {
  String _printDuration(Duration duration) {
  String twoDigits(int n) => n.toString().padLeft(2, "0");
  String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
  String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
  return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
}
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
              backgroundImage: NetworkImage(globals.apiUrl+globals.userprofile.avatar), // Replace with your own image path
            ),
            SizedBox(height: 16.0),
            Text(globals.userprofile.first_name+ globals.userprofile.last_name,
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text(
              globals.userprofile.email,
              style: TextStyle(fontSize: 18.0, color: Colors.grey),
            ),
            SizedBox(height: 16.0),
            Text(
              globals.userprofile.username,
              style: TextStyle(fontSize: 18.0, color: Colors.grey),
            ),
            SizedBox(height: 16.0),
            Divider(),
            SizedBox(height: 16.0),
            Text(
              'More information',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text(
              'Online since '+_printDuration(DateTime.now().difference(DateTime.parse(globals.userprofile.last_login))),
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

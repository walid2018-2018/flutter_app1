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

  static String calculateTimeDifferenceBetween(
      {required DateTime startDate, required DateTime endDate}) {
    int seconds = endDate.difference(startDate).inSeconds;
    if (seconds < 60)
      return '$seconds second';
    else if (seconds >= 60 && seconds < 3600)
      return '${startDate.difference(endDate).inMinutes.abs()} minute';
    else if (seconds >= 3600 && seconds < 86400)
      return '${startDate.difference(endDate).inHours.abs()} hour';
    else
      return '${startDate.difference(endDate).inDays.abs()} day';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile Details'),
        backgroundColor: Colors.indigo[900]
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
            Text(globals.userprofile.first_name+" " + globals.userprofile.last_name,
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
              'Online since '+calculateTimeDifferenceBetween(endDate:DateTime.now(), startDate: DateTime.parse(globals.userprofile.last_login)),
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

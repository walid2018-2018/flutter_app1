import 'package:chat1/Screens/helpPage.dart';
import 'package:flutter/material.dart';


 
class resetpasswordPage extends StatefulWidget {
  @override
  _resetpasswordPageState createState() => _resetpasswordPageState();
}


class _resetpasswordPageState extends State<resetpasswordPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo[900],
        title: Text('Forgot Password' , style: TextStyle( fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: Colors.white),
            ),
        
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Enter your email address to reset your password',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18.0),
            ),
            SizedBox(height: 16.0),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
                focusColor: Colors.indigo[900]
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.indigo[900]) ),
              onPressed: () {
                // TODO: Implement password reset logic
              },
              child: Text('Reset Password'),
            ),
          ],
        ),
      ),
    );
  }


}
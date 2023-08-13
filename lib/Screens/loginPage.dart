import 'package:chat1/Screens/HomePage.dart';
import 'package:chat1/Screens/chatPage.dart';
import 'package:chat1/Screens/resetpasswordPage.dart';
import 'package:chat1/Screens/resgistrationPage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http ;
import 'dart:convert';
 
 
class loginPage extends StatefulWidget {
  @override
    _loginPagetState createState() => _loginPagetState(); 
    
}


class _loginPagetState extends State<loginPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
 


  Future<int> AuthenticateUser(String input_username , String password) async {
      final url = Uri.parse('http://f6e6-41-106-4-218.ngrok-free.app/login/');
      final /*Map<String, dynamic> */ body = jsonEncode({
      
          'username': input_username,
          'password': password,
        });
          print("******");
          print(body);
      try {
       final response = await http.post(url,headers: {'Content-Type': 'application/json'} ,body: body);
        if (response.statusCode == 202) {
          // API call succeeded, process the response
          Navigator.push(context, MaterialPageRoute(builder: (context){
                                                    return HomePage(user_id: 1, username: input_username);  /* 1 c'est le userid*/ 
                                                  }));
          return 1 ;

          // Handle the response data
        } else {
          // API call failed, handle the error
          print('API call failed with status code: ${response.statusCode}');
          return 0;
        }
      } catch (error) {
        // Handle any exceptions that occurred during the API call
        print('Error occurred during API call: $error');
        return 0;
      }
      }


  @override
  Widget build(BuildContext context) {
    return /*Padding*/ Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: const Text(
                  'Drive Test Chatbot',
                  style: TextStyle(
                      color: Colors.indigo,
                      fontWeight: FontWeight.w500,
                      fontSize: 35),
                )),
            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(30),
                child: const Text(
                  'Sign in',
                  style: TextStyle(fontSize: 28 , fontWeight: FontWeight.bold , color: Colors.black45),
                )),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: usernameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'User Name',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: TextField(
                obscureText: true,
                controller: passwordController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context){
                                                return resetpasswordPage();
                                              }));
              },
              
              child: const Text('Forgot Password', style: TextStyle(color: Colors.indigo) ,)
              
              ,
            ),
            Container(
                
                height: 50,
                padding: const EdgeInsets.fromLTRB(10,0,10,0),
                child: ElevatedButton(
                  style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.indigo[900]) ),
                  child: const Text('Login'),
                  onPressed: () {
                    var userid;
                      userid = AuthenticateUser(usernameController.text, passwordController.text);
               /*     Navigator.push(context, MaterialPageRoute(builder: (context){
                                                return HomePage();
                                              }));
*/

                    print(usernameController.text);
                    print(passwordController.text);
                  },
                )
            ),
            Row(
              children: <Widget>[
                const Text('Does not have account?'),
                TextButton(
                  child: const Text(
                    'Sign up',
                    style: TextStyle(fontSize: 20 , color: Colors.indigo),
                  ),
                  onPressed: () {
                     Navigator.push(context, MaterialPageRoute(builder: (context){
                                                return registrationPage();
                                              }));
                  },
                )
              ],
              mainAxisAlignment: MainAxisAlignment.center,
            ),
          ],
        )));
  }
}











/*


  static Future<String> getUserProfile() async {
    var loginDetails = await SharedService.loginDetails();

    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Basic ${loginDetails!.key}'
    };

    var url = Uri.parse(Config.apiURL + Config.userProfileAPI);
    var response = await client.get(
      url,
      headers: requestHeaders,
    );
    print(response.body);

    if (response.statusCode == 200) {
      return response.body;
      print(response.body);
    } else {
      return "";
    }
  }*/
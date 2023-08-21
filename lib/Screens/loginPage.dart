
import 'package:chat1/Screens/HomePage.dart';
import 'package:chat1/Screens/chatPage.dart';
import 'package:chat1/Screens/resetpasswordPage.dart';
import 'package:chat1/Screens/resgistrationPage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http ;
import 'dart:convert';
import 'package:chat1/models/user_profil.dart';
import 'package:provider/provider.dart';
 import 'package:chat1/models/globals.dart' as globals;
class loginPage extends StatefulWidget {
  @override
    _loginPagetState createState() => _loginPagetState(); 
    
}


class UserProvider extends ChangeNotifier {
  int? userId; 
  
  int? getuserId() => userId;
  Future AuthenticateUser(String input_username , String password) async {
      final url = Uri.parse(globals.apiUrl+'/login/');
      final /*Map<String, dynamic> */ body = jsonEncode({
      
          'username': input_username,
          'password': password,
        });
          print("******");
          print(body);
      try {
       final response = await http.post(url,headers: {'Content-Type': 'application/json'} ,body: body);
        if (response.statusCode == 202) {
          userId = json.decode(response.body)["id"];
          globals.userprofile.email=json.decode(response.body)["email"];
          globals.userprofile.first_name=json.decode(response.body)["first_name"];
          globals.userprofile.last_name=json.decode(response.body)["last_name"];
          globals.userprofile.username=json.decode(response.body)["username"];
          globals.userprofile.last_login=json.decode(response.body)["last_login"];
          notifyListeners();
          globals.isLoggedIn=true;       
          
          final tokenUrl=globals.apiUrl+"/api-token-auth/";
          final request= await http.post(Uri.parse(tokenUrl),headers: {'Content-Type': 'application/json'} ,body: body);
          if (request.statusCode == 200) {
              globals.token=json.decode(request.body)["token"]!;
          }
          final request2= await http.get(Uri.parse(globals.apiUrl+"/profile/?id="+userId.toString()));
          if( request2.statusCode==200){
            globals.userprofile.avatar=json.decode(request2.body)["avatar"]!;
          }
          // Handle the response data
        } else {
          // API call failed, handle the error
         
          userId= null;
          globals.isLoggedIn=false;        

          print('API call failed with status code: ${response}');
          notifyListeners();
        }
      } catch (error) {
        // Handle any exceptions that occurred during the API call
        print('Error occurred during API call: $error');
  
      }
      }
}

UserProvider user = UserProvider();
class _loginPagetState extends State<loginPage> {

  @override
  void initState() {
    super.initState();
    // 2
    user.addListener(() => mounted ? setState(() {return null;}) : null);
  }
  
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
 



  @override
  Widget build(BuildContext context) {
   
    final userprovider = user.userId;


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
                  onPressed: () async {

                    await user.AuthenticateUser(usernameController.text, passwordController.text);
                    
                    if(user.getuserId() != null){
                      Navigator.push(context, MaterialPageRoute(builder: (context){
                                                return HomePage(user: user);
                                              }));
                    }
                    print(user.getuserId());
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
import 'package:chat1/Screens/chatPage.dart';
import 'package:chat1/Screens/loginPage.dart';
import 'package:flutter/material.dart';

class registrationPage extends StatefulWidget {
  @override
  _registrationPagetState createState() => _registrationPagetState();
}

class _registrationPagetState extends State<registrationPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordController2 = TextEditingController();
  String val = 'Ericsson';

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
                          fontWeight: FontWeight.w600,
                          fontSize: 26),
                    )),
                Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(10),
                    child: const Text(
                      'Create Account!',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black26),
                    )),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: TextField(
                    controller: usernameController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      focusColor: Colors.indigo,
                      labelText: 'User Name',
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: TextField(
                    controller: emailController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      focusColor: Colors.indigo,
                      labelText: 'Email',
                    ),
                  ),
                ),

//*******************************************

//******************************************** */

                Container(
                  padding: const EdgeInsets.all(10),
                  child: TextField(
                    controller: phoneController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      focusColor: Colors.indigo,
                      labelText: 'Phone',
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  //padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: TextField(
                    obscureText: true,
                    controller: passwordController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      focusColor: Colors.indigo,
                      labelText: 'Password',
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),

                  ///  padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: TextField(
                    obscureText: true,
                    controller: passwordController2,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      focusColor: Colors.indigo,
                      labelText: 'Password Confirmation',
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DropdownButtonFormField(
                    icon: Icon(Icons.keyboard_arrow_down_sharp),
                    onChanged: (v) {
                      print("encienne : " + val);
                      val = v.toString();
                      print("nouvelle : " + val);
                    },
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xff0838a2), width: 1.5)),
                      labelText: "Select ASP",
                    ),
                    items: [
                      DropdownMenuItem(
                        child: Text(
                          "Ericsson",
                        ),
                        value: "Ericsson",
                      ),
                      DropdownMenuItem(
                        child: Text(
                          "ATM",
                        ),
                        value: "ATM",
                      ),
                      DropdownMenuItem(
                        child: Text(
                          "item3",
                        ),
                        value: "item3",
                      ),
                      DropdownMenuItem(
                        child: Text(
                          "item4",
                        ),
                        value: "item4",
                      ),
                      DropdownMenuItem(
                        child: Text(
                          "item5",
                        ),
                        value: "item5",
                      ),
                    ],
                  ),
                ),

                Container(
                    height: 50,
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: ElevatedButton(
                      child: const Text('Sign Up'),
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.indigo[900])),
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return loginPage();
                        }));

                        print(usernameController.text);
                        print(emailController.text);
                        print(phoneController.text);
                        print(passwordController.text);
                        if (passwordController.text ==
                            passwordController2.text) {
                          print(passwordController2.text);
                        } else {
                          print("Password confirmation error!");
                        }
                      },
                    )),
                Row(
                  children: <Widget>[
                    const Text('Already have account?'),
                    TextButton(
                      child: const Text(
                        'Sign in',
                        style: TextStyle(fontSize: 20, color: Colors.indigo),
                      ),
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return loginPage();
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

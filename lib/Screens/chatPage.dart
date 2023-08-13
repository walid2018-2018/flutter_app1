import 'package:chat1/Screens/helpPage.dart';
//import 'package:chat1/Screens/loginPage.dart';
import 'package:chat1/Screens/profilPage.dart';
import 'package:chat1/models/chatUsersModel.dart';
import 'package:chat1/widgets/conversationList.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http ;
import 'dart:convert';


 
class ChatPage extends StatefulWidget {

  int user_id;
  String username;

  ChatPage({required this.user_id,required this.username});

  @override
  _ChatPageState createState() => _ChatPageState();

}



class _ChatPageState extends State<ChatPage> {

  /* fonction new conversation */ 
  Future<Convo_Message> CreateConv(int userid , String username) async {
      final url = Uri.parse('http://688b-197-202-251-189.ngrok-free.app/convo/');
      final body = jsonEncode({
    
          'userid': userid,
          'username': username
        });
          print("******");
          print(body);
          Conversation? conv = null;
          Convo_Message? chatuser = null;
        
      try {
       final response = await http.post(url,headers: {'Content-Type': 'application/json'} ,body: body); 
        if (response.statusCode == 202) {
          // API call succeeded, process the response 
          conv = Conversation(id: userid, time: DateTime.now().toString());

          final convo_id = 1 ;   /* a récupéré avec get */ 

          chatuser = Convo_Message(convo_id:convo_id , messageText: "Hello welcome in a new conversation with the bot", imageURL: 'assets/images/image1.jpg', time: DateTime.now().toString());
          return chatuser as Convo_Message ;

          // Handle the response data
        } else {
          // API call failed, handle the error
          print('API call failed with status code: ${response.statusCode}');
          return chatuser as Convo_Message ;
        }
      } catch (error) {
        // Handle any exceptions that occurred during the API call
        print('Error occurred during API call: $error');
        return conv as Convo_Message;
      }
      }






 List<ChatSite> chatUsers = [
    ChatSite(name: "Site 01", messageText: "Hello i'm in site AL12505 ", imageURL: 'Assets/images/image1.jpg', time: "Now"),
    ChatSite(name: "Site 02", messageText: "That's Great", imageURL: "Assets/images/image2.jpg", time: "Yesterday"),
    ChatSite(name: "Site 03", messageText: "Hey where are you?", imageURL: "Assets/images/image3.jpg", time: "31 Mar"),
    ChatSite(name: "Site 04", messageText: "Busy! Call me in 20 mins", imageURL: "Assets/images/image4.jpg", time: "28 Mar"),
    ChatSite(name: "Site 04", messageText: "Thankyou", imageURL: "Assets/images/image5.jpg", time: "23 Mar"),

  ];

  @override
  Widget build(BuildContext context) {
   return Scaffold(
      drawer: Drawer(
          child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.indigo,
            ),
            child: Text(
              'Dashboard',
              style: TextStyle(fontSize: 35 , fontWeight: FontWeight.bold , color: Colors.black54),
              
              ),        
          ),
          ListTile(
            leading: Icon(
              Icons.home,
            ),
            title: const Text('Home'),
            onTap: () {
              Navigator.pop(context);
            },
          ),

          ListTile(
              leading: Icon(
                Icons.person,
              ),
              title: const Text('Profil'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context){
                                                return profilPage();
                                              }));
              },
            ),

          ListTile(
            leading: Icon(
              Icons.help,
            ),
            title: const Text('Help'),
            onTap: () {
               Navigator.push(context, MaterialPageRoute(builder: (context){
                                                return helpPage();
                                              }));
            },
          ),
        ],
      ),


      ),
     
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SafeArea(
              child: Padding(
                padding: EdgeInsets.only(left: 16,right: 16,top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("Conversations",style: TextStyle(fontSize: 28,fontWeight: FontWeight.bold),),
                    Container(
                      padding: EdgeInsets.only(left: 8,right: 8,top: 2,bottom: 2),
                      height: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.indigo[400],
                      ),
                      child: Row(
                        children: <Widget>[
                          Icon(Icons.add,color: Colors.indigo[20],size: 20,),
                          SizedBox(width: 2,),
                          TextButton(
                            child: const Text("Add New", style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold , color: Colors.black87),), 
                            onPressed: () {

                              int userid = widget.user_id; 
                              String username = widget.username;
                                  CreateConv(userid , username);
                            }
                            ),         
                        ],
                      ),
                    )
                  ],
                ),
              ), 
            ),
            Padding(
              padding: EdgeInsets.only(top: 16,left: 16,right: 16),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Search...",
                  hintStyle: TextStyle(color: Colors.grey.shade600),
                  prefixIcon: Icon(Icons.search,color: Colors.grey.shade600, size: 20,),
                  filled: true,
                  fillColor: Colors.grey.shade100,
                  contentPadding: EdgeInsets.all(8),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(
                          color: Colors.grey.shade100
                      )
                  ),
                ),
              ),
            ),
          ListView.builder(
              itemCount: chatUsers.length,
              shrinkWrap: true,
              padding: EdgeInsets.only(top: 16),
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index){
                return ConversationList(name: chatUsers[index].name , messageText: chatUsers[index].messageText, imageUrl: chatUsers[index].imageURL , time: chatUsers[index].time, isMessageRead: (index == 0 || index == 3)?true:false );
              },
            ),


          ],
        ),
      ),
      
    );
  }
}

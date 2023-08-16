import 'dart:js_interop';

import 'package:chat1/Screens/helpPage.dart';
//import 'package:chat1/Screens/loginPage.dart';
import 'package:chat1/Screens/profilPage.dart';
import 'package:chat1/models/chatUsersModel.dart';
import 'package:chat1/widgets/conversationList.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http ;
import 'dart:convert';
import 'package:chat1/models/user_profil.dart';
import 'package:provider/provider.dart';
import 'package:chat1/Screens/loginPage.dart';
import 'package:provider/provider.dart';

 

class RoomsProvider extends ChangeNotifier {
  List<ChatSite> _chatRooms = [];

  void getRooms(User? user_id) async {
    final url = Uri.parse('http://localhost');
    final body = jsonEncode({
          'user_id': user_id,
        });

      String URL = "http://localhost/g=user_id";
     try {
       final jsonResponse = await http.get(Uri.parse(URL)); 
      
        if (jsonResponse.statusCode == 202) {
          final List responseList = json.decode(jsonResponse.body);
          
          for (var j in responseList) {
            String name = j['title'];
            String lastMessage = j['Last_message'];
            String imageURL = j['image'];
            String time = j['end_session'];

            ChatSite room = ChatSite(name: name, messageText: lastMessage, imageURL: imageURL, time: time);
            _chatRooms.add(room);
          }
        
          } 
          else {
         
               print('API call failed with status code: ${jsonResponse.statusCode}');
            
          }
     
      } catch (error) {
        // Handle any exceptions that occurred during the API call
        print('Error occurred during API call: $error');
        throw Exception('Error occurred during API call: $error');
      }
       throw Exception('Error');
      }

    notifyListeners();



  }







class ChatPage extends StatefulWidget {

  ChatPage();

  @override
  _ChatPageState createState() => _ChatPageState();

}



class _ChatPageState extends State<ChatPage> {

late ChatSite newR;


Future<ChatSite> newRoom(User? sender_id) async {
      final url = Uri.parse('http://localhost');
      ChatSite Room; 
      final /*Map<String, dynamic> */ body = jsonEncode({
          'sender_id': sender_id,
        });
          
      try {
       final jsonResponse = await http.post(url,headers: {'Content-Type': 'application/json'} ,body: body);
        if (jsonResponse.statusCode == 202) {
          final List response = json.decode(jsonResponse.body);
          if (response[0]['session'] == true) {   

            String welcomMessage = "Welcom in your drive test session !" ;
            String codeSite = response[0]['codeSite'];
            Room = ChatSite(name: codeSite, messageText: welcomMessage, imageURL:'Assets/images/image1.jpg', time: DateTime.now().toString()); 
            return Room;
          } 
          else {
            if(response[0]['session'] == false){
              
              throw Exception('session failed');
            }
            else{
              print('API call failed with status code: ${jsonResponse.statusCode}');
              throw Exception('Failed to send message to Rasa');
             }
          }
        }

      } catch (error) {
        // Handle any exceptions that occurred during the API call
        print('Error occurred during API call: $error');
        throw Exception('Error occurred during API call: $error');
      }
       throw Exception('Error');
      }



   Future<void> fetchNewRoom() async {
    // Fetch the ChatSite using the async function
    final userprovider = context.watch<UserProvider>();

    ChatSite fetchedNewRoom = await newRoom(userprovider.userId);

    // Update the state to trigger a rebuild
    setState(() {
      newR = fetchedNewRoom;
    });
  }









bool shouldRebuild = false;




  
  RoomsProvider Rooms = RoomsProvider();
  
 /*List<ChatSite> chatRooms = [
    ChatSite(name: "Site 01", messageText: "Hello i'm in site AL12505 ", imageURL: 'Assets/images/image1.jpg', time: "Now"),
    ChatSite(name: "Site 02", messageText: "That's Great", imageURL: "Assets/images/image2.jpg", time: "Yesterday"),
    ChatSite(name: "Site 03", messageText: "Hey where are you?", imageURL: "Assets/images/image3.jpg", time: "31 Mar"),
    ChatSite(name: "Site 04", messageText: "Busy! Call me in 20 mins", imageURL: "Assets/images/image4.jpg", time: "28 Mar"),
    ChatSite(name: "Site 04", messageText: "Thankyou", imageURL: "Assets/images/image5.jpg", time: "23 Mar"),

  ];
*/
  @override
  Widget build(BuildContext context) {

final userprovider = context.watch<UserProvider>();
final roomsprovider = context.watch<RoomsProvider>();

Rooms.getRooms(userprovider.userId);

List<ChatSite> chatRooms = roomsprovider._chatRooms;
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
                              fetchNewRoom();
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
              itemCount: chatRooms.length,
              shrinkWrap: true,
              padding: EdgeInsets.only(top: 16),
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index){
                return ConversationList(name: chatRooms[index].name , messageText: chatRooms[index].messageText, imageUrl: chatRooms[index].imageURL , time: chatRooms[index].time, isMessageRead: (index == 0 || index == 3)?true:false );
              },
            ),


          ],
        ),
      ),
      
    );
  }
}

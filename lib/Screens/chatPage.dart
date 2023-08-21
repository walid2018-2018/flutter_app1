
import 'dart:ffi';

import 'package:chat1/Screens/chatDetailPage.dart';
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
import 'package:chat1/models/globals.dart' as globals ;
 

class RoomsProvider extends ChangeNotifier {
  List<ChatSite> _chatRooms = [];
  List<ChatSite> getstateRooms() => _chatRooms;
  int? currentsession =null;

  int? getCurrentSession ()=> currentsession;
  void getRooms(int user_id) async {
    _chatRooms.clear();
    final url = Uri.parse('http://localhost');
    final body = jsonEncode({
          'user_id': user_id,
        });

      String URL = globals.apiUrl+"/dtsession/?g=1";
     try {
       final jsonResponse = await http.get(Uri.parse(URL)); 
      
        if (jsonResponse.statusCode == 200) {
          final List responseList = json.decode(jsonResponse.body);
          
          for (var j in responseList) {
            String name = j['title'];
            String lastMessage = j['startDate'];
            String imageURL = "Assets/images/image2.jpg";
            String time = j['endDate'];
            int id= j['id'];
            print("ididid"+id.toString());
            ChatSite room = ChatSite(name: name, messageText: lastMessage, imageURL: imageURL, time: time, id: id);
            _chatRooms.add(room);
          }
          print("hehehe"+_chatRooms.toString());
                    notifyListeners();

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

    Future checkIswithinTimeframe(int user_id) async {


      String URL = globals.apiUrl+"/isintimeframe/3";
     try {
       final jsonResponse = await http.get(Uri.parse(URL)); 
      
        if (jsonResponse.statusCode == 200) {
          var responseList = json.decode(jsonResponse.body);
          for (var i in responseList){
           currentsession=i;
          }
          
         
           notifyListeners();         
          } 
          else {
         
               print('API call failed with status code: ${jsonResponse.statusCode}');
            
          }
     
      } catch (error) {
        // Handle any exceptions that occurred during the API call
        print('Error occurred during API call: $error');
        throw Exception('Error occurred during API call: $error');
      }
      }



  }







class ChatPage extends StatefulWidget {

//  ChatPage();
  const ChatPage({super.key,  required this.user});
  
  final UserProvider user;
  @override
  _ChatPageState createState() => _ChatPageState();

}


RoomsProvider rooms=RoomsProvider();
class _ChatPageState extends State<ChatPage> {

Future<void> _showMyDialog() async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Session not planned'),
        content: const SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('Contact providers for a planned session.'),
              Text('your next session isn"t until'),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Ok'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}


@override
  void initState() {
    
    super.initState();
    rooms.getRooms(user.getuserId()!);
    // 2
    rooms.addListener(() => mounted ? setState(() { null;}) : null);
  }

 List<ChatSite>? chatRooms = [
    ChatSite(name: "Site 01", messageText: "Hello i'm in site AL12505 ", imageURL: 'Assets/images/image1.jpg', time: "Now",id: 1),
    ChatSite(name: "Site 02", messageText: "That's Great", imageURL: "Assets/images/image2.jpg", time: "Yesterday",id: 2),
    ChatSite(name: "Site 03", messageText: "Hey where are you?", imageURL: "Assets/images/image3.jpg", time: "31 Mar",id: 3),
    ChatSite(name: "Site 04", messageText: "Busy! Call me in 20 mins", imageURL: "Assets/images/image4.jpg", time: "28 Mar",id: 4),
    ChatSite(name: "Site 04", messageText: "Thankyou", imageURL: "Assets/images/image5.jpg", time: "23 Mar",id: 5),
  ];
  bool isSwitched= globals.french; 

  @override
  Widget build(BuildContext context) {
    chatRooms=rooms.getstateRooms();
    

    print("hello"+user.getuserId().toString());
   return Scaffold(
      drawer: Drawer(
          child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 58, 147, 189),
            ),
            child: Text(
              'Drive test assistant',
              style: TextStyle(fontSize: 35 , fontWeight: FontWeight.bold , color: Colors.white38),
              
              ),        
          ),Padding(padding: EdgeInsets.fromLTRB(20, 0, 0, 0), child:Row(
            
            children:<Widget>[Text(
              globals.french ? "French" : "English",
              style: TextStyle(
                color: Colors.black54,
                fontWeight: FontWeight.normal,
                fontSize: 28,
              ),          
                ),
Switch(value: isSwitched , onChanged: (value){

  globals.french= !globals.french ;
  print("glooo"+globals.french.toString());
  setState((){
    isSwitched=value;
  });
})]
            ,
          ),)
          
          ,

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
                            onPressed: () async {
                              await rooms.checkIswithinTimeframe(user.getuserId()!);

                              if(rooms.getCurrentSession() != null){
                                                  print("ehe"+rooms.getCurrentSession().toString());
                                                  // ignore: use_build_context_synchronously
                                                  Navigator.push(context, MaterialPageRoute(builder: (context){
                                                return ChatDetailPage( conversation_id:rooms.getCurrentSession()!.toInt(),roomprovider: rooms);
                                              }));
                                                }
                                                else{
                                                  _showMyDialog();
                                                  print("doesn't exist");
                                                }
                              
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
              itemCount: chatRooms?.length,
              shrinkWrap: true,
              padding: EdgeInsets.only(top: 16),
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index){
                
                return ConversationList(name: chatRooms![index].name, messageText: chatRooms![index].messageText, imageUrl: chatRooms![index].imageURL , time: chatRooms![index].time, isMessageRead: (index == 0 || index == 3)?true:false, id:chatRooms![index].id  );
              },
            ),


          ],
        ),
      ),
      
    );
  }
}

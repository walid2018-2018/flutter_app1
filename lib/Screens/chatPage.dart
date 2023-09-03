
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
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:chat1/Screens/loginPage.dart';
import 'package:chat1/models/globals.dart' as globals ;
 

class RoomsProvider extends ChangeNotifier {
  List<ChatSite> _chatRooms = [];
  List<ChatSite> getstateRooms() => _chatRooms;
  int? currentsession =null;

  int? getCurrentSession ()=> currentsession;
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
            DateFormat dateFormat = DateFormat.yMMMEd();

            String lastMessage ="Started "+ dateFormat.format(DateTime.parse( j['startDate']));
            String imageURL = "Assets/images/ContentBlock.png";
            String time = calculateTimeDifferenceBetween(endDate: DateTime.parse(j['endDate']), startDate:DateTime.parse( j['startDate']));

            
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
              Text("your next session isn't until 2 hours"),
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




final List<ChatSite> _results = [];

  void _handleSearch(String input) {
  _results.clear();
if(chatRooms !=null){

for (var str in chatRooms!){
    if(str.name.contains(input.toLowerCase())){
      setState(() {
        _results.add(str);
        print("************************"+_results.toString());
  
      });
    }
  }
}

}




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
           DrawerHeader(
                margin: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
            
              image: DecorationImage(
                
              image: AssetImage(
              "Assets/images/logo2.png"),
        ),
        
            ),
            child: Text(
              '',
              style: TextStyle(fontSize: 35 , fontWeight: FontWeight.bold , color: Colors.white38),
              
              ),        
          ),Padding(padding: EdgeInsets.fromLTRB(20, 0, 0, 0), child:Row(
            
            children:<Widget>[
Switch(value: isSwitched , onChanged: (value){

  globals.french= !globals.french ;
  print("glooo"+globals.french.toString());
  setState((){
    isSwitched=value;
  });
}), Text(
              globals.french ? "French" : "English",
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),          
                )]
            ,
          ),)
          
          ,

          ListTile(
            leading: Icon(
              Icons.home,
            ),
            title: const Text('Home',style: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),),
            onTap: () {
              Navigator.pop(context);
            },
          ),

          ListTile(
              leading: CircleAvatar(
              radius: 13.0,
              backgroundImage: NetworkImage(globals.apiUrl+globals.userprofile.avatar), // Replace with your own image path
            ),
              title: const Text('Profile',style: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),),
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
            title: const Text('Help',style: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),),
            onTap: () {
               Navigator.push(context, MaterialPageRoute(builder: (context){
                                                return helpPage();
                                              }));
            },
          ),
        ],
      ),


      ),
     
      body: Stack(
        children:<Widget>[
      SingleChildScrollView(
        padding: EdgeInsets.only(left: 16,right: 16,top: 10),

        physics: BouncingScrollPhysics(),
        child: Column(
          
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SafeArea(
              child: Padding(
                padding: EdgeInsets.only(left: 30,right: 30,top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Chat history",style: TextStyle(fontSize: 28,fontWeight: FontWeight.w400),),
                    
                  ],
                ),
              ), 
            ),
            Padding(
             padding: EdgeInsets.only(top: 16,left: 16,right: 16),
             child :TextField(
              
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
//                onChanged:// _handleSearch,

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
SizedBox(  width: 150.0,
  height: 100.0)
          ],
        
        ),
      
      ),Positioned(left:0,bottom:0,right:0,child:Container(
            color: Colors.transparent,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,

                        children: <Widget>[Padding(padding: EdgeInsets.fromLTRB(20, 20, 20, 30), child:
                          SizedBox(  width: 150.0,
  height: 50.0, child:
                          
                          ElevatedButton(
                            
                  style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.indigo[900]),   shape: MaterialStateProperty.all<RoundedRectangleBorder>(
    RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(18.0),
    )
  ) ),
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
                              
                            } ,
                  child: const Text('New Chat',style: TextStyle(color: Colors.white,fontFamily: 'roboto') ),
                ),), )
                              
                        ],
                      ),),), 
                     
                      ]
             
 
    ));
  }
}

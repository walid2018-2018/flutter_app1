import 'dart:collection';

import 'package:chat1/models/chatMessageModel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http ;
import 'dart:convert';

class ChatDetailPage extends StatefulWidget{

  int user_id;
  String username;

  ChatDetailPage({required this.user_id,required this.username});

 



  @override
  _ChatDetailPageState createState() => _ChatDetailPageState();
}

class _ChatDetailPageState extends State<ChatDetailPage> {
//List<ChatMessage> list_Q_R = [];

Future<List<ChatMessage>> sendMssgRasa(int sender_id, String message) async {
      final url = Uri.parse('http://4624-41-108-100-124.ngrok-free.app/webhooks/rest/webhook');
      final /*Map<String, dynamic> */ body = jsonEncode({
      
       'sender_id': sender_id,
          'message': message,
        });
          print("******");
          print(body);
      try {
       var response = await http.post(url,headers: {'Content-Type': 'application/json'} ,body: body);
        var jsonResponse = json.decode(response.body);
        print(jsonResponse);

          
          if (jsonResponse.isNotEmpty) {
            print("----------------------");
            print(jsonResponse);
            return [ChatMessage(messageContent: message, messageType: "sender"),ChatMessage(messageContent: jsonResponse[0]['text'] , messageType: "receiver")];  // Assuming Rasa returns a 'text' key
          } 
          else {
            if(jsonResponse.isEmpty){
              throw Exception('Rasa response was empty');
            }
            else{
              print('API call failed with status code: ${response.statusCode}');
              throw Exception('Failed to send message to Rasa');
             }
          }
              //return true;
      

          // Handle the response data
    //    else {
          // API call failed, handle the error
      //    print('API call failed with status code: ${response.statusCode}');
       //   return false;
       // }
      } catch (error) {
        // Handle any exceptions that occurred during the API call
        print('Error occurred during API call: $error');
        throw Exception('Error occurred during API call: $error');
      }
      return [ChatMessage(messageContent: message, messageType: "sender") , ChatMessage(messageContent: '', messageType: "receiver")]; 
      }


 Future<void> fetchDataAndAssign(sender_id , messsage) async {
    // Call the function and wait for the result
    List<ChatMessage> list_Q_R = await sendMssgRasa(sender_id, messsage);
    // Assign the result to the itemList
    //messages_queue.add(list_Q_R[0]);  // technician message 
    messages_queue.add(list_Q_R[1]);  // bot response
    setState(() {
      //list_Q_R = result; 
      shouldRebuild = !shouldRebuild;   // rebuild 
    });
  }



bool shouldRebuild = false;

TextEditingController sendMessageController = TextEditingController();


/*List<ChatMessage> messages_list = [
    ChatMessage(messageContent: "Hello, Will", messageType: "receiver"),
    ChatMessage(messageContent: "How have you been?", messageType: "receiver"),
    ChatMessage(messageContent: "Hey Kriss, I am doing fine dude. wbu?", messageType: "sender"),
    ChatMessage(messageContent: "ehhhh, doing OK.", messageType: "receiver"),
    ChatMessage(messageContent: "Is there any thing wrong?", messageType: "sender"),
  ];*/

Queue<ChatMessage> messages_queue = ListQueue.of([
    ChatMessage(messageContent: "Hello, Will", messageType: "receiver"),
    ChatMessage(messageContent: "How have you been?", messageType: "receiver"),
    ChatMessage(messageContent: "Hey Kriss, I am doing fine dude. wbu?", messageType: "sender"),
    ChatMessage(messageContent: "ehhhh, doing OK.", messageType: "receiver"),
    ChatMessage(messageContent: "Is there any thing wrong?", messageType: "sender"),
    ChatMessage(messageContent: "Hello, Will", messageType: "receiver"),
    ChatMessage(messageContent: "How have you been?", messageType: "receiver"),
    ChatMessage(messageContent: "Hey Kriss, I am doing fine dude. wbu?", messageType: "sender"),
    ChatMessage(messageContent: "ehhhh, doing OK.", messageType: "receiver"),
    ChatMessage(messageContent: "Is there any thing wrong?", messageType: "sender"),
    ChatMessage(messageContent: "Hello, Will", messageType: "receiver"),
    ChatMessage(messageContent: "How have you been?", messageType: "receiver"),
    ChatMessage(messageContent: "Hey Kriss, I am doing fine dude. wbu?", messageType: "sender"),
    ChatMessage(messageContent: "ehhhh, doing OK.", messageType: "receiver"),
    ChatMessage(messageContent: "Is there any thing wrong?", messageType: "sender"),
  ]
  );


  @override
  Widget build(BuildContext context) {
     List<ChatMessage> messages = messages_queue.toList();
   
   return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        flexibleSpace: SafeArea(
          child: Container(
            padding: EdgeInsets.only(right: 16),
            child: Row(
              children: <Widget>[
                IconButton(
                  onPressed: (){
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back,color: Colors.black,),
                ),
                SizedBox(width: 2,),
                CircleAvatar(
                  backgroundImage: AssetImage('Assets/images/image1.jpg'),
                  maxRadius: 20,
                ),
                SizedBox(width: 12,),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("Kriss Benwat",style: TextStyle( fontSize: 16 ,fontWeight: FontWeight.w600),),
                      SizedBox(height: 6,),
                      Text("Online",style: TextStyle(color: Colors.grey.shade600, fontSize: 13),),
                    ],
                  ),
                ),
                Icon(Icons.settings,color: Colors.black54,),
              ],
            ),
          ),
        ),
      ),
      body: SafeArea(child: Column(
            
        children: <Widget>[
          Flexible(child: ListView.builder(
              itemCount: messages.length,
              shrinkWrap: true,
              padding: EdgeInsets.only(top: 10,bottom: 10),
         //     physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index){
                
                return SingleChildScrollView(  // 
                  physics: BouncingScrollPhysics(), //
                  child: Container( //
                  padding: EdgeInsets.only(left: 14,right: 14,top: 10,bottom: 10),
                  child: Align(
                    alignment: (messages[index].messageType == "receiver"?Alignment.topLeft:Alignment.topRight),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: (messages[index].messageType  == "receiver"?Colors.grey.shade200:Colors.blue[200]),
                      ),
                      padding: EdgeInsets.all(16),
                      child: Text(messages[index].messageContent, style: TextStyle(fontSize: 15),),
                    ),
                  ),
                ),
                );
              },
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              padding: EdgeInsets.only(left: 10,bottom: 10,top: 10),
              height: 60,
              width: double.infinity,
              color: Colors.white,
              child: Row(
                children: <Widget>[
                  GestureDetector(
                    onTap: (){
                    },
                    child: Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        color: Colors.lightBlue,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Icon(Icons.add, color: Colors.white, size: 20, ),
                    ),
                  ),
                  SizedBox(width: 15,),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Write message...",
                        hintStyle: TextStyle(color: Colors.black54),
                        border: InputBorder.none
                        
                      ),
                      controller: sendMessageController
                    ),
                  ),
                  SizedBox(width: 15,),
                  FloatingActionButton(
                    onPressed: (){
                     
                      if(sendMessageController.text.isNotEmpty){
                     //   sendNewMssg(sendMessageController.text);
                        String mssg = sendMessageController.text;
                        messages_queue.add(ChatMessage(messageContent: mssg, messageType: "sender"));
                        fetchDataAndAssign(1 , mssg);
                       
                       
                       // Queue<ChatMessage> list_q_r = sendMssgRasa(1,mssg); // list contiens querry and response 
                       // List<ChatMessage> list1 = [];
                        //(sendMssgRasa(1, mssg));
                       // Queue<ChatMessage> q_r = ListQueue.of(sendMssgRasa(1, mssg));
                        
                     //   messages_queue.a  
                      }
                    },    /*   *******************************************  */ 
                    child: Icon(Icons.send,color: Colors.white,size: 18,),
                    backgroundColor: Colors.blue,
                    elevation: 0,
                  ),
                ],
                
              ),
            ),
          ),
        ],
      ),
      ),
    );
  }



Future<bool> sendNewMssg(String message) async {
        ChatMessage newMssg =  ChatMessage(messageContent: message, messageType: "sender");
        
      final url = Uri.parse('http://f6e6-41-106-4-218.ngrok-free.app/messages/'); // rasa API server url  
      final /*Map<String, dynamic> */ body = jsonEncode({
      
          'Sender_id': widget.user_id, 
          'message': message,
        });
          print("******");
          print(body);
      
      try {
       final response = await http.post(url,headers: {'Content-Type': 'application/json'} ,body: body);
        if (response.statusCode == 202) {
          // API call succeeded, process the response
          setState(() {
          messages_queue.add(newMssg);
                      
     // messages_queue.add(newMssg);
        /* clear write text feiled */
        sendMessageController.clear();
             });}
             else{
                  print('API call failed with status code: ${response.statusCode}');
             }
      }
      catch (error){
           print('Error occurred during API call: $error');
      }
        

  
        
        
        
        return true ;
       // padding: EdgeInsets.all(16);
      //  return  Text(message, style: TextStyle(fontSize: 15),);
        

  /*    final url = Uri.parse('http://688b-197-202-251-189.ngrok-free.app/messages/');
      final body = jsonEncode({
          'message': message,
        });
          print("******");
          print(body);
         
      try {
       final response = await http.post(url,headers: {'Content-Type': 'application/json'} ,body: body); 
        if (response.statusCode == 202) {
          // API call succeeded, process the response 
       


       return "User is created successfully" ;

          // Handle the response data
        } else {
          // API call failed, handle the error
          print('API call failed with status code: ${response.statusCode}');
          return "Failed to create user" ;
        }
      } catch (error) {
        // Handle any exceptions that occurred during the API call
        print('Error occurred during API call: $error');
        return "failed";
      }
 */      }


  
}
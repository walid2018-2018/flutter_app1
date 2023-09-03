import 'dart:async';
import 'dart:collection';

import 'package:chat1/Screens/chatPage.dart';
import 'package:chat1/models/chatMessageModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:http/http.dart' as http ;
import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:chat1/models/globals.dart' as globals;
import 'package:socket_io_client/socket_io_client.dart' as IO;




class ConversationHistoryProvider extends ChangeNotifier {
  Queue<ChatMessage> _messages_queue = Queue<ChatMessage>();
  Queue<ChatMessage> getConversationHistory() => _messages_queue;

  void getHistory(int conversation_id) async {
    final url = Uri.parse('http://localhost');

      String URL = globals.apiUrl+"/event/"+conversation_id.toString();
     try {
       final jsonResponse = await http.get(Uri.parse(URL)); 
      
        if (jsonResponse.statusCode == 200) {
          final List responseList = json.decode(jsonResponse.body);
          
          for (var j in responseList) {
            String messageType = j['type_name'];
            String messageContent = '';

            if (messageType == "user") {
              messageContent=j['data']['text'];
              messageType="sender";
              }
            else{
              if( messageType=="bot"){
                messageContent=j['data']['text'];
                }
              else{
                if (j['data']['action_text'] != null){
                  messageContent=j['data']['action_text'];
                }
                else
                {
                  messageContent=j['action_name'];
                }
             
              }              messageType="receiver";

           
          }
            ChatMessage singlemessage =  ChatMessage(messageContent: messageContent, messageType: messageType);

            _messages_queue.add(singlemessage);
                    notifyListeners();

          } 
         }
          else {
         
               print('API call failed with status code: ${jsonResponse.statusCode}');
            
          }
      }
      catch (error) {
        // Handle any exceptions that occurred during the API call
        print('Error occurred during API call: $error');
        throw Exception('Error occurred during API call: $error');
      }
      }
      
    void addsocketResponseToContainer(ChatMessage singlemessage) async {

      _messages_queue.add(singlemessage);
                    notifyListeners();
    }
    
    void addSocketEmitToContainer(ChatMessage singlemessage) async{
      _messages_queue.add(singlemessage);
                    notifyListeners();
    }

  }


class ChatDetailPage extends StatefulWidget{


  ChatDetailPage({required this.conversation_id, this.roomprovider});

  final int conversation_id;
  final RoomsProvider? roomprovider;
  @override
  _ChatDetailPageState createState() => _ChatDetailPageState();
}

class _ChatDetailPageState extends State<ChatDetailPage> {

//List<ChatMessage> list_Q_R = [];


ConversationHistoryProvider conversation=ConversationHistoryProvider();

late IO.Socket socket;

@override
  void initState() {
    
    super.initState();
 
    conversation.getHistory(widget.conversation_id);
    conversation.addListener(() => mounted ? setState(() { null;}) : null);
    initSocket();    
  }
  
  initSocket() {
  print(globals.apiUrl);
  socket = IO.io(globals.socketurl, <String, dynamic>{
    'autoConnect': true,
    'transports': ['websocket'],
  });  socket.connect();
  socket.onConnect((_) {
    print('Connection established');
    Map joinjson={
    'roomID': widget.conversation_id,
    'userName': "globals.userprofile.username"
  };

    socket.emit('join-room',joinjson);
    socket.on('receive-message', (newMessage) {
      //Map<String,dynamic> jsonmap=json.decode(newMessage.toString());
      if (socket.id!=newMessage['socket_id']) {
      ChatMessage reveivedMessage =  ChatMessage(messageContent: newMessage['text'], messageType: "receiver");
          print("hehehehehehehehehehhehehehee"+newMessage.toString());
          conversation.addsocketResponseToContainer(reveivedMessage);
      }
});
    socket.off('receive-message', (data) {
  print('message updating: $data');
}
);
  });  


  socket.onDisconnect((_) => print('Connection Disconnection'));
  socket.onConnectError((err) => print(err));
  socket.onError((err) => print(err));
}

@override
void dispose() {
  socket.disconnect();
  socket.dispose();
  super.dispose();
}
Future<List<ChatMessage>> sendMssgRasa(int sender_id, String message) async {
      final url = Uri.parse(globals.apiUrl+'/webhooks/rest/webhook');
      final /*Map<String, dynamic> */ body = jsonEncode({
      
       'sender_id': sender_id,
          'message': message,
        });
          
      try {
       var response = await http.post(url,headers: {'Content-Type': 'application/json'} ,body: body);
        var jsonResponse = json.decode(response.body);
        print(jsonResponse);

          
          if (jsonResponse.isNotEmpty) {
            print("----------------------");
            print(jsonResponse); //consider multiple dispatches from rasa actions
            return [ChatMessage(messageContent: message, messageType: "sender"),ChatMessage(messageContent: jsonResponse[0]["text"] , messageType: "receiver")];  // Assuming Rasa returns a 'text' key
          } 
          else {
            if(jsonResponse.isEmpty){
            }
            else{
              print('API call failed with status code: ${response.statusCode}');
             }
          }
              //return true;
      

          // Handle the response data

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

Queue<ChatMessage> messages_queue = ListQueue.of([
    ChatMessage(messageContent: "Hi, i'm currently at site 165800L for quick ssv", messageType: "sender"),
    ChatMessage(messageContent: "Got it, 165800L it is.", messageType: "receiver"),
    ChatMessage(messageContent: "Do a check of avarilable technologies  ", messageType: "sender"),
    ChatMessage(messageContent: "2G Status is the following: 165800D ACTIVE ,165800E ACTIVE ,165800F ACTIVE", messageType: "receiver"),
    ChatMessage(messageContent: "3G technology doesn't exist", messageType: "receiver"),
    ChatMessage(messageContent: "4G status is: 165800T UNLOCKED ,165800R UNLOCKED ,165800S UNLOCKED", messageType: "receiver"),

    ChatMessage(messageContent: "I need sector 1 to be locked for 4G band L1800", messageType: "sender"),
    ChatMessage(messageContent: "Sector 1 band L1800 for 4G is locked now.", messageType: "receiver"),
    
  ]
  );
 @override
  void didChangeDependencies() {
    print("didChangeDependencies");
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    ScrollController _scrollController = ScrollController();
    bool isSwitched= globals.humanhandoff; 

    void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(_scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 300), curve: Curves.elasticOut);
    } else {
      Timer(Duration(milliseconds: 400), () => _scrollToBottom());
    }
 }
WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
     print("affiche"+widget.conversation_id.toString());
     
    messages_queue=conversation.getConversationHistory();

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
                  backgroundImage: AssetImage('Assets/images/bot.png'),
                  maxRadius: 20,
                ),
                SizedBox(width: 12,),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("Drive Test bot",style: TextStyle( fontSize: 16 ,fontWeight: FontWeight.w600),),
                      SizedBox(height: 6,),
                      Text("Online",style: TextStyle(color: Colors.grey.shade600, fontSize: 13),),
                    ],
                  ),
                ),Switch(value: isSwitched , onChanged: (value){

  globals.humanhandoff= !globals.humanhandoff ;
  print("glooo"+globals.humanhandoff.toString());
  setState((){
    isSwitched=value;
  });
}), Text(
              globals.humanhandoff ? "human" : "bot",
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),          
                ),
              ],
            ),
          ),
        ),
      ),
      body: SafeArea(child: Column(
            
        children: <Widget>[
          Flexible(child: ListView.builder(
              controller: _scrollController,
              itemCount: messages.length,
              shrinkWrap: false,
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
                  constraints: BoxConstraints(minWidth: 100, maxWidth: 200),
                      child: Flexible( child: Text(messages[index].messageContent, overflow: TextOverflow.visible,style: TextStyle(fontSize: 15),)),
                    ),
                  ),
                ),
                );
              },
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: EdgeInsets.only(left: 10,bottom: 10,top: 10),
              height: 60,
              width: double.infinity,
              color: Colors.white,
              child: widget.roomprovider?.getCurrentSession()!=null ? Row(
                children: <Widget>[
                  SizedBox(width: 15,),
                  Expanded(
                    child: widget.roomprovider?.getCurrentSession()!=null ? TextField(
                      decoration: InputDecoration(
                        hintText: "Write message...",
                        hintStyle: TextStyle(color: Colors.black54),
                        border: InputBorder.none
                        
                      ),
                      controller: sendMessageController
                    ): SizedBox()
                  ),
                  SizedBox(width: 15,),
                  FloatingActionButton(
                    onPressed: () async {
                     
                      if(sendMessageController.text.isNotEmpty){
                        Map messageMap={
    'text':sendMessageController.text,
    'roomID': widget.conversation_id,
    'userName': "globals.userprofile.username"
  };
          ChatMessage newMssg =  ChatMessage(messageContent: sendMessageController.text, messageType: "sender");

        

          
    if(globals.humanhandoff){
  socket.emit('send-message', messageMap);
  conversation.addSocketEmitToContainer(newMssg);}else{
                        await sendNewMssg(sendMessageController.text);


                        SchedulerBinding.instance.addPostFrameCallback((_) {
                 _scrollController.animateTo(
                 _scrollController.position.maxScrollExtent,
                 duration: const Duration(milliseconds: 1),
                 curve: Curves.fastOutSlowIn);
                 });
            }
                        //String mssg = sendMessageController.text;
                        //messages_queue.add(ChatMessage(messageContent: mssg, messageType: "sender"));
                        //fetchDataAndAssign(1 , mssg);
                       
                       
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
                
              ): SizedBox(child:Text("Session ended you cannot send a message",style: TextStyle(color: Colors.black45, fontFamily: "roboto",fontSize: 16 ))),
            ),
          ),
        ],
      ),
      ),
    );
  }



Future<bool> sendNewMssg(String message) async {
        ChatMessage newMssg =  ChatMessage(messageContent: message, messageType: "sender");
        
      final url = Uri.parse('http://0c1f-41-108-78-209.ngrok-free.app/botmessage/'); // rasa API server url  
      final /*Map<String, dynamic> */ body = jsonEncode({
      
          'sender': widget.conversation_id.toString(), 
          'message': message,
        });
          print("******");
          print(body);
      
      try {
       final response = await http.post(url,headers: {'Content-Type': 'application/json'} ,body: body);
        if (response.statusCode == 200) {
          // API call succeeded, process the response
          setState(() {
          messages_queue.add(newMssg);
          ChatMessage reveivedMessage =  ChatMessage(messageContent: json.decode(response.body)[0]['text'], messageType: "receiver");
          messages_queue.add(reveivedMessage); 
      
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

    }


  
}
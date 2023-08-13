import 'package:flutter/cupertino.dart';

class ChatSite{
  String name;
  String messageText;
  String imageURL;
  String time;
  ChatSite({required this.name ,required this.messageText,required this.imageURL,required this.time}); 

}


class Conversation{
  int id;
  String time;
  Conversation({required this.id,required this.time});
}


class Convo_Message{
  int convo_id;
  String messageText;
  String imageURL;
  String time;
  Convo_Message({required this.convo_id ,required this.messageText,required this.imageURL,required this.time});
}

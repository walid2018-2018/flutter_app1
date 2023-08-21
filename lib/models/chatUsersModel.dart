import 'package:flutter/cupertino.dart';

class ChatSite{
  String name;
  String messageText;
  String imageURL;
  String time;
  int id;
  ChatSite({required this.name ,required this.messageText,required this.imageURL,required this.time, required this.id}); 

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


class Profile{
  String username;
  String first_name;
  String last_name;
  String email;
  String last_login;
  String avatar="/static/default.jpg";

  Profile({required this.username, required this.first_name, required this.last_name, required this.last_login, required this.email, required this.avatar});
}
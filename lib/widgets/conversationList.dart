import 'package:chat1/Screens/chatDetailPage.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
class ConversationList extends StatefulWidget{
  String name;
  String messageText;
  String imageUrl;
  String time;
  bool isMessageRead;
  int id;
  ConversationList({required this.name,required this.messageText,required this.imageUrl,required this.time,required this.isMessageRead, required this.id});
  @override
  _ConversationListState createState() => _ConversationListState();
}

class _ConversationListState extends State<ConversationList> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){ Navigator.push(context, MaterialPageRoute(builder: (context){
          return ChatDetailPage( conversation_id:widget.id, roomprovider: null);
        }));
      },
      child: Container(
        decoration: BoxDecoration(
              
                        color: Color.fromARGB(255, 231, 235, 240),
                        border: Border.all(
                          color: Colors.white,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      boxShadow: [
      BoxShadow(
        color: Color.fromARGB(255, 192, 198, 206),
        blurRadius: 10.0, // soften the shadow
        spreadRadius: 5.0, //extend the shadow
        offset: Offset(
          2.0, // Move to right 5  horizontally
          2.0, // Move to bottom 5 Vertically
        ),
      )
    ],
                      ),
        padding: EdgeInsets.only(left: 16,right: 16,top: 10,bottom: 10),
        margin: EdgeInsets.all(10.0),
        child: Row(
          children: <Widget>[
            Expanded(
              
              child: Row(
                
                children: <Widget>[
                  Icon(color: Colors.indigo,Icons.label_important_outline_sharp ),

                  SizedBox(width: 16,),
                  Expanded(
                    child: Container(
                      color: Colors.transparent,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(children: <Widget>[Text(widget.name, style: TextStyle(fontSize: 20),),Spacer(),  Icon(color: Colors.black54,Icons.more_vert),]),
                          SizedBox(height: 6,),
                          Text(widget.messageText,style: TextStyle(fontSize: 16,color: Colors.grey.shade600, fontWeight: FontWeight.normal),),
                        Text(widget.time,style: TextStyle(fontSize: 12,fontWeight: FontWeight.w300,color: Colors.grey.shade600),
                        ),                       
                     
                        ],
                        
                      ),
                      
                    ),
                    
                  ),
                ],
              ),
            ),
                                    SizedBox(height: 10),
],
        ),
      ),
    );
  }
}
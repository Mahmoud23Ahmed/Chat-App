import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../models/message.dart';
import 'constatnt.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class chatPage extends StatelessWidget {

  static String id = 'chatPage';
  final Controller = ScrollController();
  CollectionReference messages = FirebaseFirestore.instance.collection(kMessagesCollection);
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)!.settings.arguments;
    return StreamBuilder<QuerySnapshot>(
      stream: messages.orderBy('createdAt' , descending: true).snapshots(),
      builder: (context , snapshot) {
          if (snapshot.hasData) {
            List<Message> messagesList = [];
            for(int i=0 ; i< snapshot.data!.docs.length ; i++){
              messagesList.add(Message.fromJson(snapshot.data!.docs[i]));
            }
            return Scaffold(
                appBar: AppBar(
                  automaticallyImplyLeading: false,
                  backgroundColor: kPriamryColor,
                  title: Row(
                      children: [
                        Image.asset('images/logo2.png', height: 45,),
                        Text('Chat App'),
                      ]),
                  centerTitle: true,
                ),
                body: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        reverse: true,
                        controller: Controller,
                          itemCount: messagesList.length,
                          itemBuilder: (context, index) {
                        return messagesList[index].id == email ? chatBubble(message: messagesList[index]
                        ): chatBubbleForFriends(message: messagesList[index]);
                      }),),
                    Padding(
                      padding: EdgeInsets.all(16),
                      child: TextField(
                        controller: controller,
                        onSubmitted: (data) {
                          messages.add({
                            'messages': data,
                            'createdAt' : DateTime.now(),
                            'id' : email ,
                          });
                          controller.clear();
                          Controller.animateTo(
                              0,
                              duration: Duration(milliseconds : 500),
                              curve: Curves.fastLinearToSlowEaseIn);
                        },
                        decoration: InputDecoration(
                          hintText: 'Send Message',
                          suffixIcon: Icon(
                            Icons.send,
                            color: kPriamryColor,
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16)
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide(
                                color: kPriamryColor,
                              )
                          ),
            
                        ),
                      ),
                    ),],
                )
            );
          }else{
            return ModalProgressHUD(
                inAsyncCall: true,
                child: Scaffold(
                    appBar: AppBar(
                      automaticallyImplyLeading: false,
                      backgroundColor: kPriamryColor,
                      title: Row(
                          children: [
                            Image.asset('images/logo2.png', height: 45,),
                            Text('Chat App'),
                          ]),
                      centerTitle: true,
                    )
                )
            );
          }
       
      }
        );
    }
}

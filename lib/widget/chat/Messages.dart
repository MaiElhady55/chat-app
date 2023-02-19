

import 'package:chatapp/widget/chat/Message_Bubbles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Messages extends StatelessWidget {
  const Messages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('chat')
            .orderBy('createdAt', descending: true)
            .snapshots(),
        builder: (
          BuildContext context,
          AsyncSnapshot snapshot,
        ) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }
          final mydocs = snapshot.data!.docs;
          return ListView.builder(
              reverse: true,
              itemCount: mydocs.length,
              itemBuilder: (ctx, index) {
                return MessageBubble(
                    key: ValueKey(mydocs[index].documentID),
                    message: mydocs[index]['text'],
                    username:  mydocs[index]['username'],
                    isMe:  mydocs[index]['userId']==FirebaseAuth.instance.currentUser!.uid,
                    userImage: mydocs[index]['userImage'],
                    );
              });
        });
  }
}

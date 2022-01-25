import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chat Screen"),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('chats/m6TBagFIxYMDkkykQHTS/messages')
            .snapshots(),
        builder: (ctx, streamSnapshot) {
          //---
          if (streamSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          final documents = streamSnapshot.data!.docs;
          return ListView.builder(
            itemCount: documents.length,
            itemBuilder: (ctx, index) => Container(
              padding: const EdgeInsets.all(8.0),
              child: Text(documents[index]['text']),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          //-- Snapshots return stream
          // Firebase.initializeApp();
          // FirebaseFirestore.instance
          //     .collection('chats/m6TBagFIxYMDkkykQHTS/messages')
          //     .snapshots()
          //     .listen((data) {
          //   data.docs.forEach((element) {
          //     print(element['text']);
          //   });
          //   // print(data.docs[0]['text']);
          // });
        },
      ),
    );
  }
}

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../widgets/auth_form.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _auth = FirebaseAuth.instance;
  var _isLoading = false;
  void _submitAuthForm(
    String email,
    String username,
    String password,
    File? userImage,
    bool isLogin,
    BuildContext ctx,
  ) async {
    //-- add or enable user to login
    UserCredential authResult;
    try {
      setState(() {
        _isLoading = true;
      });
      if (isLogin) {
        authResult = await _auth.signInWithEmailAndPassword(
            email: email, password: password);
      } else {
        authResult = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        // --- if it's not login, store the username to firebase.
        //--- Storing user profile picture using firebase_storage package
        //-- .ref() gives us access to our root cloud storage bucket. .child('user_image) adds a new folder if it doesn't exist in our bucket the last .child() adds file name with extension.
        final ref = FirebaseStorage.instance
            .ref()
            .child('user_image')
            .child(authResult.user!.uid + '.jpg');

        //to store some extra data during signup like usrname,etc
        //store the data in cloudFireStore immediatley after signup.
        //.collection()->creates a collection if not exists
        //.doc()->create a document with  an id
        //.set()->a Map to set the fields inside user documents
        // uploadTask.whenComplete(() async {
        ref.putFile(userImage!).whenComplete(() async {
          final url = await ref.getDownloadURL();
          await FirebaseFirestore.instance
              .collection('users')
              .doc(authResult.user!.uid)
              .set({
            'username': username,
            'email': email,
            'imageUrl': url,
          });
        });
      }
    } on FirebaseAuthException catch (error) {
      setState(() {
        _isLoading = false;
      });
      var message = 'An error occurred, pls check your credentials';
      if (error.message != null) {
        message = error.message!;
      }

      ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(
        content: Text(message),
        backgroundColor: Theme.of(context).errorColor,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: AuthForm(_submitAuthForm, _isLoading),
    );
  }
}

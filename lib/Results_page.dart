import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:connection_verify/connection_verify.dart';

class Results extends StatelessWidget {
  //final String documentId;

 // Results(this.documentId);
  Future<void> chceck() async {
    if (await ConnectionVerify.connectionStatus()){
    print("I have network connection!");
    //Do your online stuff here
    } else {
    print("I don't have network connection!");
    //Do your offline stuff here
    }

  }


  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('Shedule');


/*    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(documentId).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {

        if (snapshot.hasError) {
          return Text("Something went wrong",textDirection: TextDirection.ltr);
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data = snapshot.data.data();
          return Text("Full Name: ${data['id']} ${data['park']}");
        }

        return Text("loading" ,textDirection: TextDirection.ltr);
      },
    );*/
  return Scaffold(

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),

          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: chceck,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
  }

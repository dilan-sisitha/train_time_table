import 'package:flutter/material.dart';

import 'Home_page.dart';
import 'Results_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

void main()  {

  runApp(new MaterialApp(
    debugShowCheckedModeBanner: false,

    home: Home(),
  ));
}


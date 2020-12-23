import 'package:flutter/material.dart';
import 'package:train_time_table/Home.dart';
import 'package:train_time_table/TrainList.dart';

import 'Results_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

void main()  {

  runApp(new MaterialApp(
    debugShowCheckedModeBanner: false,

    home: Home1(),
  ));
}


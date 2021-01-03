import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'file:///C:/Users/Dilan/Documents/train_time_table/lib/UI/Home.dart';
import 'package:train_time_table/UI/LoadingScreen.dart';
import 'package:train_time_table/UI/WelcomeScreen.dart';

void main() => runApp(MyApp());







class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  var loggedInStatus;
  bool isLoading =true ;

  Future<bool> checkAlreadyLogin () async {
    SharedPreferences preferences =await SharedPreferences.getInstance();
    bool loggedin =preferences.getBool("login")?? false  ;
    return loggedin;
  }




  @override
  void initState(){
    super.initState();
   checkAlreadyLogin().then((value) { setState(() {
     loggedInStatus = value;
     isLoading = false;
   });});


  }

  @override
  Widget build(BuildContext context) {


    return MaterialApp(
        title: 'Train Time',
        home: isLoading?LoadingScreen(): loggedInStatus? Home() : WelcomeScreen() ,
        debugShowCheckedModeBanner: false,
       // home: LoadingScreen()
    );
  }
}

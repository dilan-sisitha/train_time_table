import 'dart:convert';
import 'dart:io';

import 'package:connection_verify/connection_verify.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'file:///C:/Users/Dilan/Documents/train_time_table/lib/UI/Home.dart';
import 'file:///C:/Users/Dilan/Documents/train_time_table/lib/Network/IpAdress.dart';
import 'package:train_time_table/UI/Components/AltertBox.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Components/RoundButton.dart';
import 'Components/TextFieldContainer.dart';
import 'package:http/http.dart' as http;

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final emailController = TextEditingController();
  final passwordController = TextEditingController();


 // bool newLogin;

  // ignore: non_constant_identifier_names
  bool altert_status = false;
  // ignore: non_constant_identifier_names
  String altert_text;



  Future checkuser() async {
    String email = emailController.text.toString();
    String pass = passwordController.text.toString();

    if (email.length==0|| pass.length==0) {
      // print("email or password empty");
      altert_status = true;
      altert_text = "Email or password empty";
    } else {
      if (await ConnectionVerify.connectionStatus()) {
        try {
          var url = IpAdress.ip +
              'demo/checkuser?email=' +
              email +
              '&password=' +
              pass;
          var response = await http.get(url);

          if (response.statusCode == 200) {
            int validity = json.decode(response.body);
            print(validity.toString());

           // int validity_status = int.parse(validity);
            if (validity== 1) {
              altert_status = false;
            } else {
              altert_status = true;
              altert_text = "email or password incorrect";
            }
            if (validity== null) {
              altert_status = true;
              altert_text = "connection error";
            }

          } else{
            altert_status = true;
            altert_text = "connection error";
          }


        } on SocketException {
          altert_status = true;
          altert_text = "connection error";

        } catch (e) {
          print("error " + e.toString());
        }
      } else {
        // print("no internet");
        altert_status = true;
        altert_text = "no internet connection";
      }
    }

  }


  Future nav()async{
    await checkuser();
    if(altert_status){


      AltertBox altertBox = new AltertBox(context,altert_text);
      altertBox.showMyDialog();

    }else{

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("login", true);

      Navigator.push(context, MaterialPageRoute(builder: (context)
      {
        return Home();
      }));
    }

  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
               height: size.height * 0.15,
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 40),
                width: size.width * 0.70,
                height: size.height * 0.25,
                child: Image(
                    image: AssetImage(
                  "assets/images/userimg.png",
                )),
              ),
              TextFieldContainer(
                hint: "email",
                icon: Icon(Icons.person),
                obsecure: false,
                controller: emailController,
              ),
              TextFieldContainer(
                hint: "Password",
                icon: Icon(Icons.lock),
                obsecure: true,
                controller: passwordController,
              ),
              RoundButton(
                press: () {
                //  checkuser();
                  nav();
                },
                text: "LOGIN",
              )
            ],
          ),
        ),
      ),
    );
  }
}

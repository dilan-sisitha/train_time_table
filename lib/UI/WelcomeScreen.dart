import 'package:flutter/material.dart';

import 'Components/RoundButton.dart';
import 'LoginScreen.dart';


class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {



  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: size.height*0.1,),
                Container(
                  padding: EdgeInsets.fromLTRB(0, 40, 0, 0),
                  child: Text("W E L C O M E",
                    style: TextStyle(fontWeight: FontWeight.w900,
                        fontSize: 25,
                        color:Color.fromRGBO(0, 128, 255,10)
                    ),
                    textAlign:TextAlign.center,
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 40),
                  width: size.width *0.80 ,
                  height: size.height*0.35,
                  child: Image(
                      image: AssetImage("assets/images/trainlogo.png",)
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  child: Column(
                    children: [
                      RoundButton(text: "LOGIN",
                        press: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)
                          {
                            return LoginScreen();
                          }));
                        },

                      ),
                      RoundButton(text: "SIGN UP",
                        color: Colors.grey,
                        textColor: Colors.black,
                        press: (){},

                      ),
                    ],
                  ),
                )

              ],
            ),


          ),
        ),
      ),

    );
  }
}



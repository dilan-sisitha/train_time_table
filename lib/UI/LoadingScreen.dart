import 'package:flutter/material.dart';

class LoadingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: size.width,
    //    decoration: BoxDecoration(color: Colors.redAccent),
        child: Column(

          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
        Container(
        margin: EdgeInsets.symmetric(vertical: 40),
        width: size.width *0.50 ,
        height: size.height*0.25,
        child: Image(
          image: AssetImage("assets/images/trainlogo.png",)
          )
        ),
            CircularProgressIndicator(
                backgroundColor: Colors.yellow,
                valueColor: new AlwaysStoppedAnimation<Color>(Colors.blue)
            ),
            Container(
              padding: EdgeInsets.only(top: 10),
              child: Text("Loading...",
              style: TextStyle(
                fontSize: 20,
                color: Colors.black45,
                fontWeight: FontWeight.w900,
                fontStyle: FontStyle.italic

              ),),
            )

          ],
        ),
      ),
    );
  }
}

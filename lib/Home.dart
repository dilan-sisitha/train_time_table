import 'package:flutter/material.dart';

class Home1 extends StatelessWidget {
  final myController = TextEditingController();
  String refno= "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(30.0),
          child: Center(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(top: 140.0),
                  child: Text("Train Time Table",
                  style: TextStyle(color: Colors.blue, fontSize: 25.0 ),),
                  ),
                Container(
                  padding: EdgeInsets.only(top: 50.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: "Enter reference number",
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),


                      )
                    ),
                    controller: myController,


                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 10.0),
                  child: RaisedButton.icon(
                    onPressed: (){pop();

                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.00))
                    ),
                    icon: Icon(Icons.search,color: Colors.white,),
                    label: Text("Search",style: TextStyle(color: Colors.white,fontSize: 20.0),),
                    textColor: Colors.white,
                    splashColor: Colors.white,
                    color: Colors.lightBlue,
                  ),
                )
              ],

            ),
          ),
        ),
      ),
    );
  }
  void pop(){
    if(myController.text.length==0) {
      debugPrint("null text");

    }
    else
      debugPrint(myController.text+"okay");
      refno = myController.text;

  }
}


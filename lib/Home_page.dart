import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:train_time_table/Data_Search.dart';


class Home extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Train Shedule"),
        centerTitle: true,

      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomButton()
          ],
        ),

      ),
    );
  }

}

class CustomButton extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
   return Container(
     child: RaisedButton.icon(
         onPressed: (){showSearch(context: context, delegate: DataSearch());},
         shape: RoundedRectangleBorder(
           borderRadius: BorderRadius.all(Radius.circular(10.00))
         ),
         icon: Icon(Icons.search,color: Colors.white,),
         label: Text("Search trains",style: TextStyle(color: Colors.white),),
       textColor: Colors.white,
       splashColor: Colors.red,
       color: Colors.lightBlue,
     ),

   );
  }


}


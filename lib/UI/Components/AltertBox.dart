

import 'package:flutter/material.dart';

class AltertBox{
   final BuildContext context;
   final String altert_text;

  AltertBox(this.context, this.altert_text);


   showMyDialog(){
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Align(
                    alignment: Alignment.center,
                    child: Text(
                      altert_text,
                      textAlign: TextAlign.center,
                    )),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text(
                'ok',
                style: TextStyle(fontSize: 15),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
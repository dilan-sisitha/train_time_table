import 'package:connection_verify/connection_verify.dart';
import 'package:flutter/material.dart';
import 'package:train_time_table/TrainList.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  String refno = "";

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int refno_validity;
  final myController = TextEditingController();
  String altert_text = "";
  bool altert_status = false;

  //fetch refno validity status
  Future fetchValidity() async {
    var rest;
    var url =
        'http://192.168.1.100:8080/demo/checkrefno?refno=' + myController.text;
    var response = await http.get(url);

    if (response.statusCode == 200) {
      rest = response.body;
    }
    return rest;
  }

//check conncetion and whether text field is empty
  Future<void> check() async {
    if (await ConnectionVerify.connectionStatus()) {
      //if you have internet cnncetion
      print("I have network connection!");

      if (myController.text.length == 0) {
        //if textfield is empty
        altert_text = "please enter reference number";
        altert_status = true;


      } else {
        //if internet connection is ok and text field is not empty

        //check if refernce number is valid
        var result = await fetchValidity();
        refno_validity = int.parse(result);

        //if ref num is correct
        if (refno_validity == 1) {
          altert_status = false;

          //if ref num is wrong
        } else if (refno_validity == 0) {
          altert_status = true;
          altert_text = "please enter a valid reference number\n eg: 1005";
        }


      }
    } else {
      //if no internet
      altert_text = "please check your internet connection";
      altert_status = true;
      print("I don't have network connection!");
    }
  }

  //alert dialog method
  Future<void> _showMyDialog() async {
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

  Future<void> nav() async {
    await check();
    if (altert_status) {
      _showMyDialog();
    } else {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => TrainList(data: myController.text),
      ));
      debugPrint("validity is " + refno_validity.toString());
    }
  }

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
                  child: Text(
                    "Train Time Table",
                    style: TextStyle(color: Colors.blue, fontSize: 25.0),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 50.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                        labelText: "Enter reference number",
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                        )),
                    controller: myController,

                    textInputAction: TextInputAction.search,

                    //on pressed enter on keyboard
                    onFieldSubmitted: (value) {
                      //  check();
                      nav();
                    },
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 10.0),
                  child: RaisedButton.icon(
                    //on pressed search button
                    onPressed: () {
                      //`  check();
                      nav();
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.00))),
                    icon: Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                    label: Text(
                      "Search",
                      style: TextStyle(color: Colors.white, fontSize: 20.0),
                    ),
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
}

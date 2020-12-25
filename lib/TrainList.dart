import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:train_time_table/FormDetails.dart';
import 'package:train_time_table/TrainDetails.dart';
import 'package:http/http.dart' as http;
import 'IpAdress.dart';

class TrainList extends StatefulWidget {

  //geting refno from navigation
  String data;

  TrainList({
    Key key,
    @required this.data}) : super(key: key);


  @override
  _TrainListState createState() => _TrainListState(this.data);
}

class _TrainListState extends State<TrainList> {

  //geting passed refno from navigatio to state class
  String data;
  _TrainListState(this.data);


  List<TrainDetails> _traindetails = List<TrainDetails>();


  List<FormDetails> _formdetails = List<FormDetails>();

  bool isSheduleLoading = true;
  bool isDetailsLoading = true;



  Future fetchTrainDetails() async{
    var url = IpAdress.ip+'demo/shedules?refno='+data;
    var response = await http.get(url);

    var traindetails = List<TrainDetails>();

    if (response.statusCode == 200) {
      var trainsJson = json.decode(response.body);
      for (var trainJson in trainsJson) {
        traindetails.add(TrainDetails.fromJson(trainJson));
      }
    }
    return traindetails;
  }



  Future fetchFormDetails()async{
    var url = IpAdress.ip+"demo/details?refno=1005";
    var response = await http.get(url);

    var formdetails = List<FormDetails>();
    if(response.statusCode ==200){
     var formsJson = json.decode(response.body);
     for(var form in formsJson){
       formdetails.add(FormDetails.fromJason(form));
     }

    }
    return formdetails;

  }

  @override
  void initState() {

    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
    fetchTrainDetails().then((value) {
      setState(() {
        _traindetails.addAll(value);
        isSheduleLoading =false;
      });
    });
    });


    fetchFormDetails().then((value) {
      setState(() {
        _formdetails.addAll(value);
        isDetailsLoading = false;
      });
    });


  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
        appBar: AppBar(
          title: Text('Train Time Table'),
        ),
        body: isSheduleLoading&&isDetailsLoading ?Center(child: CircularProgressIndicator(),): Container(
          padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
          child: Column(

            children: [
              Text( data,

                style: TextStyle(
                    fontSize: 20, fontWeight: FontWeight.bold
                ),
                textAlign: TextAlign.center,

              ),
              Container(
                padding: const EdgeInsets.only(top: 0, bottom: 0, left: 20.0, right: 0),
                child: Align(

                  alignment:Alignment.topLeft ,

                  child: _formdetails[0].form_no==null? Container():Text("form no = "+_formdetails[0].form_no.toString(),
                    style: TextStyle(
                        fontSize: 20

                    ),
                    textAlign: TextAlign.start,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 0, bottom: 0, left: 20.0, right: 0),
                child: Align(
                  alignment:Alignment.topLeft ,
                  child: Text("pt",
                    style: TextStyle(
                        fontSize: 20
                    ),
                    textAlign: TextAlign.start,
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 32.0, bottom: 32.0, left: 16.0, right: 16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start ,
                          children: <Widget>[
                            Text(
                              _traindetails[index].arrival,
                              style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                            Text(

                              _traindetails[index].departure,
                              style: TextStyle(
                                  color: Colors.grey.shade600
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  itemCount: _traindetails.length,
                ),
              )

            ],
          ),
        )
    );
  }
}

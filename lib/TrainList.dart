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
  bool isFetchingError = false;



  Future fetchTrainDetails() async{
    var url = IpAdress.ip+'demo/shedules?refno='+data;
    var response = await http.get(url);

    var traindetails = List<TrainDetails>();

    if (response.statusCode == 200) {
      isFetchingError = false;
      var trainsJson = json.decode(response.body);
      for (var trainJson in trainsJson) {
        traindetails.add(TrainDetails.fromJson(trainJson));
      }
    }
    else
      isFetchingError =true;
    return traindetails;
  }



  Future fetchFormDetails()async{
    var url = IpAdress.ip+"demo/details?refno="+data;
    var response = await http.get(url);

    var formdetails = List<FormDetails>();
    if(response.statusCode ==200){

      isFetchingError =false;
     var formsJson = json.decode(response.body);
     for(var form in formsJson){
       formdetails.add(FormDetails.fromJason(form));
     }

    }else
      isFetchingError = true;
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

          child: Column(

            children: [
              
              
              Card(

                child: Padding(
                  padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
                  child: Column(
                    children: [
                      Text( _formdetails[0].details.toString(),

                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold
                        ),
                        textAlign: TextAlign.center,

                      ),
                      Container(
                        padding: const EdgeInsets.only(top: 10, bottom: 0, left: 35.0, right: 0),
                        child: Align(

                          alignment:Alignment.topLeft ,

                          child:Text(
                               _formdetails[0].form_no==null?"form number not available":
                            "Form No. "+_formdetails[0].form_no.toString(),
                            style: TextStyle(
                                fontSize: 15,
                              color: Colors.black54


                            ),
                            textAlign: TextAlign.start,
                          ),
                        ),
                      ),
                      _formdetails[0].pt==null? Container( padding: const EdgeInsets.only(top: 10, bottom: 20, left: 35.0, right: 0),):
                      Container(
                        padding: const EdgeInsets.only(top: 10, bottom: 20, left: 30.0, right: 0),
                        child: Align(
                          alignment:Alignment.topLeft ,
                          child: Text("P.T "+_formdetails[0].pt,
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.black54
                            ),
                            textAlign: TextAlign.start,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),


              Expanded(
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 25.0, bottom: 25.0, left: 16.0, right: 16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start ,
                          children: <Widget>[
                            Center(
                              child: Text(

                                _traindetails[index].station==null? " ":
                                _traindetails[index].station,
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  color: Colors.black.withOpacity(0.7)

                                ),
                              ),
                            ),
                            Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 25.0, bottom: 10, left: 16.0, right: 16.0),
                                  child: Row(

                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      _traindetails[index].arrival==null|| _traindetails[index].arrival==""? Container():
                                      Padding(
                                        padding: EdgeInsets.only(top: 0.0, bottom: 0, left: 15.0, right: 0.0),
                                        child: Text(
                                          _traindetails[index].arrival==null? "":
                                         "A. "+ _traindetails[index].arrival,
                                          style: TextStyle(
                                              color: Colors.green[500],
                                              fontSize:20,
                                              fontWeight: FontWeight.w500

                                          ),
                                        ),
                                      ),
                                      _traindetails[index].departure==null|| _traindetails[index].departure==""? Container():
                                      Padding(
                                        padding: EdgeInsets.only(top: 0.0, bottom: 0, left: 25.0, right: 0.0),
                                        child: Text(

                                          "D. "+_traindetails[index].departure,
                                          style: TextStyle(
                                              color: Colors.deepOrangeAccent,
                                              fontSize:20,
                                              fontWeight: FontWeight.w500
                                          ),
                                        ),
                                      ),
                                      _traindetails[index].crossing==null? Container():
                                      Padding(
                                        padding: const EdgeInsets.only(top: 0.0, bottom: 0, left: 0, right: 0.0),
                                        child: Text(
                                          _traindetails[index].crossing==null? " ":
                                          " "+_traindetails[index].crossing,
                                          style: TextStyle(
                                              color: Color.fromRGBO(0, 0, 204, 10.0),
                                              fontSize:20,
                                              fontWeight: FontWeight.w500
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            _traindetails[index].park==null|| _traindetails[index].park==""? Container():Padding(
                              padding: EdgeInsets.only(top: 0.0, bottom: 0, left: 25.0, right: 0.0),
                              child: Text(
                               _traindetails[index].park==null|| _traindetails[index].park==""? " ":
                                "P. "+_traindetails[index].park,
                                style: TextStyle(
                                    color: Colors.grey.shade600,
                                    fontSize:20,
                                    fontWeight: FontWeight.w500
                                ),
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
